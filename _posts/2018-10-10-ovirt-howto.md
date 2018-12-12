---
layout: post
title: How to use oVirt for virtualization like VMware ESXi/vSphere
author: quorten
date: 2018-10-10 12:00 -0500
categories: [random-software]
tags: [random-software]
---

Nowadays, Red Hat is further advancing its virtualization solutions to
be more competitive with some offerings that have been coming from
VMware such as ESXi and vCenter Server Appliance (VCSA).  The general
architecture of such VMware offerings is as follows:

* Each host machine runs ESXi, which is basically a virtualization
  hypervisor operating system.

* A vCenter Server Appliance is connected to multiple ESXi host
  machines.  The VCSA can then be used to manage all of ESXi host
  machines the as a cluster.  The vCenter Server Appliance also
  provides a web user interface to the management features and exposes
  a network API that can be controlled by other programs.

* There are tons of wrapper libraries in different programming
  languages designed to expose a programmer-friendly interface to the
  network API exposed by the vCenter Server Appliance.

In abstract, you could argue that this high-level architecture is
sound.  However, there are very, very, many specific implemenation
details that I don't like about the real-world instantiation of the
VMware ESXi and VCSA architecture.  Nevertheless, Red Hat's new
virtualization solutions are designed to mimick in as many ways as
possible, mainly as a means to look more appealing to existing users
that have existing software code bases programmed up against the
VMware APIs.

<!-- more -->

The new Red Hat virtualization system comes with not one, but two
names:

* oVirt, the main open-source project.

* Red Hat Virtualization (RHV), the Red Hat branded version.

The main new things that Red Hat Virtualization adds over its existing
offerings is a virtualization manager, similar to the VMware VCSA
discussed previously, and APIs that connect to the exposed network
API.  The rest reuses existing Red Hat virtualization technologies,
that we will briefly review here.

1. QEMU is one of the earliest virtualization systems promoted by Red
   Hat.  It is still being used as the base of the oVirt system for
   providing virtualization features and functions on a single host.
   The guest VMs run a QEMU guest agent to provide the special
   features and functions expected from a modern virtualization
   environment.

2. KVM is used by QEMU to provide accelerated virtualization.
   Historically KVM was an optional component that QEMU could use for
   faster virtualization when available; however, KVM is _required_
   for oVirt.

3. `libvirt` is basically a library to provide network APIs to QEMU.
   `libvirt` was designed with support for multiple hypervisor
   backends, but only QEMU is used with oVirt.

20181010/https://en.wikipedia.org/wiki/OVirt  
20181010/https://en.wikipedia.org/wiki/Red_Hat_Virtualization  
20181010/https://en.wikipedia.org/wiki/Kernel-based_Virtual_Machine  
20181010/https://www.ovirt.org  
20181010/https://www.ovirt.org/documentation/architecture/architecture/  
20181010/https://en.wikipedia.org/wiki/Libvirt  
20181010/https://libvirt.org

So, why do you still need to be familiar with these back-end
components?  Mainly, because the newer front-end components, like the
virtualization manager and oVirt API libraries, are not fully
developed.  They still lack several important and key functions that
you will need to use to be able to get a virtualization system up and
running.  So, we will include discussion on managing the lower layers
too.

For example, take `libvirt`.  The features exposed by `libvirt` are
practically the limits of what can be done inside the oVirt
virtualization manager.  Is there an API to copy files in and out of
the guest VM?  Looking at `ovirt`, it doesn't look like it... but
there are commands to read and write files from the guest VM in the
QEMU guest agent.

20181010/DuckDuckGo ovirt run program in guest  
20181010/DuckDuckGo ovirt guest agent  
20181010/https://www.ovirt.org/documentation/internal/guest-agent/understanding-guest-agents-and-other-tools/  
20181010/https://www.ovirt.org/develop/developer-guide/vdsm/guest-agent/  
20181010/DuckDuckGo qemu tools api  
20181010/https://wiki.qemu.org/Features/GuestAgent

Also note that when reading the `libvirt` documentation, the word
"domain" is effectively used to refer to a "host machine" as it is
called elsewhere, and "host" is a "guest VM".

20181010/https://libvirt.org/docs.html  
20181010/https://libvirt.org/html/index.html

Another key example.  How do you configure networking on a guest VM?
There doesn't appear to be many options available from the oVirt Web
UIs.  And indeed, you might be led to believe that it's not possible
to setup a functional network.  But, never fear.  The features and
functions are in there, they just can't be controlled from the
new-style API.  Use the good old `virt-manager` to get at them.

20181010/https://en.wikipedia.org/wiki/Virtual_Machine_Manager

TODO: Also, you might be wondering.  Run command in guest?

----------

### Create the VM nodes

The first thing you need to do is get an oVirt setup installed and
running.  For starters learning how this multi-machine system works,
that obviously means you will first need to get an existing
virtualization setup up and running.  That means either VirtualBox or
QEMU, in the case of your typical small open-source software
developer's personal computer.

Next, you can start creating three virtual machines for a three node
setup: two QEMU host machines and one virtualization manager machine.
You can keep things fairly basic for each node:

* One CPU core
* 4 GB of RAM
* 20 GB of disk space for the operating system on each node
* 80 GB of disk space for data such as virtual machines, databases,
  etc.

Yes, these numbers are fairly big for a single personal computer, but
oVirt was designed for larger scale virtualization.  Nevertheless, you
may be able to scale down the RAM for each node.  These are the
recommendations, however:

oVirt Virtualization Manager:

* 4 CPU cores
* 16 GB of RAM
* 50 GB of disk space

Virtualization Host Machine?  The sky is the limit and ground zero is
the floor for most things.  However, a minimum of 2 GB of RAM and 35
GB of disk space is "required".  (20 GB of disk space worked okay for
me for just getting started.)

You can start with CentOS 7.5 (as of 2018) as the operating system
running on each node.  Note that there are also pre-built minimalistic
virtualization manager and QEMU host images that you can use, but we
are going to describe the process of doing otherwise as that involves
more steps.  You can simply skip these steps if you are using the
pre-built minimalistic images.

### Setup the virtualization manager

Wondering about what an oVirt self-hosted engine is all about?
Basically, that is installing the oVirt virtualization manager onto
one of the host machine's of the cluster.  In this case, you would
want to setup the QEMU host nodes first, then deploy the
virtualization manager as a VM on the QEMU host nodes.  You don't
actually need a separate VM for the manager, which is pretty nice,
compared to VMware.  Note that we do _not_ cover self-hosted engine
setup here, we only cover the case where you have a dedicated
machine/VM for the virtualization manager.

20181010/DuckDuckGo ovirt hosted engine  
20181010/https://www.ovirt.org/documentation/self-hosted/Self-Hosted_Engine_Guide/  
20181010/https://www.ovirt.org/documentation/self-hosted/chap-Introduction/

Designate one of the nodes as the virtualization manager node and
complete the installation as follows:

    ssh root@ovirt01
    curl -L -O http://resources.ovirt.org/pub/yum-repo/ovirt-release-master.rpm
    rpm -iv ovirt-release-master.rpm
    sed -i -e 's/\$releasever/7/g' /etc/yum.repos.d/ovirt-master-dependencies.repo
    yum update
    yum install ovirt-engine
    engine-setup

`engine-setup` will prompt you for configuration.  For most options,
just pick all the defaults by hitting enter.  For the admin password,
make sure you pick a password of your choice.  You will later login to
it via `admin@internal` for CLI tools.  The Web UI appends the
`@internal` part for you, so don't try to add it when logging in
through the Web UI.

Also note that `engine-setup` can be easily automated/scripted through
the use of an "answers file": you run `engine-setup` once with
`--generate-answers=your_file.txt`, run through it interactively, and
the answers file `your_answers.txt` will be output corresponding to
your choices.  Then you can use `--config-append=your_answers.txt`
when you run `engine-setup` the next time to configure the
virtualization manager non-interactively.

#### Root password reset

If you want to change the admin password later, use the following
command:

    ovirt-aaa-jdbc-tool user password-reset admin

#### Save self-signed certificates to a file

Finally, logging on to your virtualization manager is going to be
finicky because of its self-signed certificates.  Get the data you
need by running the OpenSSL certificate information command:

    openssl s_client -showcerts -connect hostname.domain.tld:443

20181010/DuckDuckGo Peer's certificate issuer has been marked as not
  trusted by the user  
20181010/https://stackoverflow.com/questions/23434235/60-peers-certificate-issuer-has-been-marked-as-not-trusted-by-the-user-linux#23482430

Copy the two `-----BEGIN CERTIFICATE-----`...`-----END
CERTIFICATE-----` blocks to a `ovirt01.pem` file that you will point
all API software at to accept the server's self-signed certificates.
If you only copy one certificate, it won't work, so make sure you get
them all.  (Maybe at some point in the future, you will need to copy
more than two certificate blocks.)  Node that you can comment-out
lines in the `.pem` file by using the `#` character at the beginning
of the line.

Actually, you can script the whole process using a `sed` command to
extract the proper sections as follows:

    openssl s_client -showcerts \
      -servername hostname.domain.tld \
      -connect hostname.domain.tld:443 </dev/null |
      sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' >ovirt01.pem

This command also supports virtual server names.

### QEMU host nodes

Now that you've got your virtualization manager setup, you can setup
each QEMU host node.  We'll also add storage domain servers onto each
node.

    ssh root@ovirt02
    HOSTNAME=ovirt02
    rpm -iv ovirt-release-master.rpm
    sed -i -e 's/\$releasever/7/g' /etc/yum.repos.d/ovirt-master-dependencies.repo
    yum update
    yum install ovirt-host
    # Partition and mount `/dev/sdb' for 80 GB more data.
    parted /dev/sdb <<EOF
    mklabel msdos
    mkpart primary ext4 16 85888
    EOF
    DISK_UUID=`blkid /dev/sdb1 | cut -d' ' -f2 | tr -d '"'`
    echo "$DISK_UUID /home/nfs_storage                   ext4     defaults        0 0" >>/etc/fstab
    mount -l
    chmod 777 /home/nfs_storage/
    chmod +t /home/nfs_storage/
    echo "/home/nfs_storage *(rw,nohide,insecure,no_subtree_check)"  >>/etc/exports
    firewall-cmd --permanent --add-service=nfs
    firewall-cmd --permanent --add-service=mountd
    firewall-cmd --permanent --add-service=rpc-bind
    firewall-cmd --reload
    service nfs start
    systemctl enable nfs

Note that there are a few special system settings that you must verify
to be configured for your virtualization host nodes to work correctly:

* For the CPU, virtualization extensions must be available.

* For the network, "promiscuous mode" or "MAC address spoofing
  capability" must be enabled.  If this is not enabled, bridged
  networking will not work.  Instead, you will only be able to use NAT
  for networking.

### Pair host nodes to manager

This step you can do manually in the oVirt virtualization manager Web
UI.  Log in as the admin user, go to CPU > Hosts, and add your two
hosts.  Then go and do likewise for Storage > Domains, and add your
NFS shares from the host machines.

Note that you can alternatively configure local storage domains.  From
a performance standpoint, especially for small systems, this would be
preferrable.  However, the primary restriction is that either you can
only have a single host node or your network gets split into separate
clusters/datacenters for each host node.

20181010/DuckDuckGo ovirt configure local storage  
20181010/https://www.ovirt.org/documentation/admin-guide/chap-Storage/

Also, a word on storage and connectivity.  Suppose you power off all
nodes in your cluster and power them back on.  Are you having trouble
with the storage being onlined again?  Proceed as follows to solve
this problem.  Put all hosts into maintenance mode, then activate
them.  The storage should get recognized correctly again and your
cluster and datacenter should be back up and running.  Also, this is
useful for another thing.  What if you have some storage domains that
you want to remove?  The Web UI will typically tell you that you
cannot remove any storage domains when the cluster is running.  But,
if you put all hosts into maintenance mode, you will have the option
to "destroy" a storage domain, even though "remove" may still be
grayed out.

Also, take note of some of these important details on authentication
with SSH and `libvirt`.

* The virtualization manager creates SSH keys that it uses to connect
  to the QEMU hosts.

* `libvirt` is installed on the QEMU hosts and uses SASL
  authentication.

* When connecting to `libvirt` on the same host, use `qemu:///system`
  as the URI.

* You can also connect to `libvirt` through an SSH channel.  When
  doing so, use `qemu+ssh://hostname/system` as the URI.  In this
  case, if you are not connecting over SSH keys, you will first need
  to provide the SSH credentials, followed by the `libvirt`
  credentials.

* There is a default SASL username and password configured that you
  can use if you need to connect directly to `libvirt` on the QEMU
  hosts.

      vdsm@ovirt
      shibboleth

* Otherwise you can add a new username and password as follows.

      # saslpasswd2 -a libvirt USERNAME@DOMAIN
      Password:
      Again (for verification):

  Note that SASL usernames must always be of the format
  `USERNAME@DOMAIN`.  If you omit the domain, it will default to the
  host name or localhost.  Check the SASL DB file file to be sure:
  `/etc/libvirt/passwd.db`.  When authenticating as this user, you must
  always include the `@DOMAIN` part, otherwise you will get an
  authentication error.  SASL config is located at
  `/etc/sasl2/libvirt.conf`.

* Cannot connect through SSH via `virt-manager` to host machines?
  SASL authentication problems are to blame.  Make sure you have the
  required SASL module libraries installed on the client machine:
  `cyrus-sasl-scram` and `cyrus-sasl-gssapi`.  Default username and
  password that should work.

* Note that the `libvirt` SASL username and password is also required
  to properly run the `guestfish` commands.  Otherwise, another option
  is to disable the auth requirements in the config, shown here.

      sed -i -e 's/#auth_unix_rw = "none"/auth_unix_rw = "none"/g' \
        /etc/libvirt/libvirtd.conf
      service libvirtd restart

20181010/DuckDuckGo ovirt connect to libvirt  
20181010/https://serverfault.com/questions/507151/virsh-cant-connect-to-ovirt-hypervisor#507397

`libvirt` connection URIs official documentation.

20181010/https://libvirt.org/uri.html

20181010/DuckDuckGo libguestfs: error: could not connect to libvirt (URI =
  qemu:///system): authentication failed: authentication failed [code=45
  int1=-1]  
20181010/https://github.com/jeffreywildman/homebrew-virt-manager/issues/37  
20181010/DuckDuckGo guestfish cannot connect to ovirt

20181010/DuckDuckGo libvirt authentication names https://libvirt.org/auth.html  
20181010/DuckDuckGo connect virt-manager ovirt vdsm host  
20181010/https://scottlinux.com/2016/01/09/how-to-connect-to-rhev-with-virt-manager/  
20181010/DuckDuckGo ovirt virsh

20181010/DuckDuckGo ssh error: authentication failed: Failed to start SASL negotiation: -4 (SASL(-4): no mechanism available: No worthy mechs found)  
20181010/https://bugzilla.redhat.com/show_bug.cgi?id=490255  
20181010/https://bugzilla.redhat.com/show_bug.cgi?id=489250  
20181010/https://github.com/cloudera/impyla/issues/149#issuecomment-227519194

Some notes on how oVirt networking internal works.

* The default management network is named `vdsm-ovirtmgmt` from within
  QEMU (i.e. `virt-manager`).  However, the oVirt management tools
  will report the network name to you as `ovirtmgmt` (i.e. `virsh`).
  The default management network works fine for VMs if you will be
  using bridged networking where your VMs will get their IP addresses
  from an external DHCP server.  It also works fine if you only need
  internal networking between the VMs on one host.

  To list networks as seen by oVirt, use `virsh` as follows:

      virsh net-info ovirtmgmt

  Note that you will be prompted for SASL credentials.

  To list Linux bridged network device information, use `ip` as
  follows:

      ip addr

  You'll notice that all virtual devices are connected to the bridge,
  and the bridge device is connected to the physical device.  Well, I
  don't know great detail about how Linux bridge networking works at
  this current time, but if you see something like that, you know it
  is working as intended.

For more detail, here are some notes on Linux/QEMU bridged networking.

20181010/DuckDuckGo ovirt vnic profile  
20181010/https://www.ovirt.org/develop/release-management/features/sla/vnic-profiles/  
20181010/DuckDuckGo ovirt connect to external network  
20181010/DuckDuckGo ovirt networking  
20181010/https://www.ovirt.org/documentation/how-to/networking/networks/  
20181010/DuckDuckGo qemu vnet0  
20181010/https://wiki.qemu.org/Documentation/Networking  
20181010/DuckDuckGo qemu create tap  
20181010/https://blog.elastocloud.org/2015/07/qemukvm-bridged-network-with-tap.html  
20181010/DuckDuckGo qemu bridge network dhcp ip address  
20181010/DuckDuckGo qemu bridged networking ip forward  
20181010/DuckDuckGo qemu bridged networking ip forward firewall  
20181010/https://resources.infosecinstitute.com/qemu-windows-guest-bridged-networking/

More notes on networking.

20181010/DuckDuckGo linux bridge virtual networking  
20181010/https://superuser.com/questions/1204229/bridge-virtual-interface-into-physical-network#1204491  
20181010/https://www.linux-kvm.org/page/Networking  
20181010/https://www.ovirt.org/documentation/admin-guide/chap-Logical_Networks/

### oVirt API documentation

Note that you will need some oVirt API-based tools to perform some
important next-step tasks on your installation such as importing VMs,
so do take some time to familiarize yourself with the oVirt API at
this point.

Your oVirt virtualization manager may have built-in links to API
documentation within itself.  The oVirt API documentation is a bit
challenging to chase down to get to an Internet link.  However, after
a bit of searching, I've found reasonable documentation.

20181010/DuckDuckGo ovirt rest api  
20181010/DuckDuckGo ovirt-engine documentation  
20181010/DuckDuckGo ovirt engine sdk  
20181010/DuckDuckGo ovirt engine api  
20181010/DuckDuckGo ovirt engine api sdk  
20181010/DuckDuckGo ovirt api sdk  
20181010/DuckDuckGo ovirt-engine-sdk  
20181010/DuckDuckGo ovirt-engine-api

The official Python PyPI package is named `ovirt-engine-sdk-python`.

201810108/https://pypi.org/project/ovirt-engine-sdk-python/

Don't be fooled, there is also an alternative package name that is not
officially maintained and is now out-of-date.

This repository contains the source code and generated documentation
for the Python API.

20181010/https://pypi.org/project/ovirt-engine-sdk/

Don't be fooled by some of the out-of-date or unmaintained
documentation on the oVirt website.

20181010/https://www.ovirt.org/develop/api/  
20181010/https://www.ovirt.org/develop/api/rest-api/  
20181010/https://www.ovirt.org/develop/api/rest-api/rest-api/
20181010/https://www.ovirt.org/develop/sdk/  
20181010/https://www.ovirt.org/develop/sdk/sdk/  
20181010/https://www.ovirt.org/develop/release-management/features/infra/python-sdk/

The official up-to-date documentation is automatically generated from
the source code repositories.

20181010/https://github.com/oVirt/ovirt-engine-sdk  
20181010/https://github.com/oVirt/ovirt-engine-sdk/blob/master/sdk/README.adoc  
20181010/http://ovirt.github.io/ovirt-engine-sdk/master/

This repository is for the API definition.

20181010/https://github.com/oVirt/ovirt-engine-api-model

This repository is for the generation system.

20181010/https://github.com/oVirt/ovirt-engine-api-metamodel

This repository is the final piece that makes the documentation
viewable on a oVirt virtualization manager server.

20181010/https://github.com/oVirt/ovirt-engine-api-explorer

Be careful when installing the Python API via `pip`.  You might get an
error like this:

> `ImportError: pycurl: libcurl link-time ssl backend (nss) is
> different from compile-time ssl backend (openssl)`

Fix it as follows.

    pip uninstall pycurl
    export PYCURL_SSL_LIBRARY=openssl
    pip install pycurl --no-cache-dir

20181010/DuckDuckGo libcurl link-time ssl backend (nss) is different
  from compile-time ssl backend (openssl)  
20181010/https://stackoverflow.com/questions/21096436/ssl-backend-error-when-using-openssl#21099222

About Ansible modules.  oVirt has a lot of Ansible modules available
for it.  Look around here for info.

20181010/DuckDuckGo ansible ovirt import ova  
20181010/https://docs.ansible.com/ansible/2.6/modules/ovirt_vms_module.html  
20181010/DuckDuckGo ansible ovirt add host  
20181010/https://www.ovirt.org/develop/release-management/features/infra/ansible_modules/  
20181010/DuckDuckGo ansible ovirt host  
20181010/https://docs.ansible.com/ansible/latest/modules/ovirt_host_pm_module.html  
20181010/https://docs.ansible.com/ansible/latest/modules/ovirt_host_module.html  
20181010/DuckDuckGo ansible ovirt-ova-extract  
20181010/https://www.ovirt.org/develop/release-management/features/sla/hosted-engine-new-deployment/

Unfortunately, it turns out that that there is not an official
upstream Ansible module for importing and exporting OVA templates to
oVirt.  We'll cover how to do VM import via a script that uses oVirt
API next.

Looking for Perl API access?  Look here.  Unfortunately, this only
provides access to the V3 API, not the V4 API.  There is not an
official Perl library to access the oVirt API.  This is a third-party
library.

20181010/DuckDuckGo ovirt perl api  
20181010/https://github.com/ovido/ovirt-perl-api  
20181010/https://metacpan.org/pod/Ovirt

### Importing ISO CD/DVD disk images

Want to upload iso images to oVirt?  Just look here at the oVirt
quick-start guide.  This is a great way to get started if you want to
create your first VM from an ISO installation disk.

20181010/DuckDuckGo ovirt cd-rom disk image  
20181010/https://www.ovirt.org/documentation/quickstart/quickstart-guide/

How to upload ISO images to oVirt.

20181010/DuckDuckGo ovirt mount cd to guest  
20181010/https://community.redhat.com/blog/2015/05/how-to-install-and-use-ovirts-windows-guest-tools/

### Importing VMs

As it turns out, importing VMs is a bit tricky due to a buggy web UI.
However, you can do it sufficiently using the oVirt API and some tools
pre-installed in the host machines.  If you have an OVA file, that's a
good place to start.  As it happens, there's an example Python script
for importing an Open Virtualization Archive (OVA) file as a VM, and
it partially works under limited circumstances.  Chances are you might
find your OVA file to use a few more advanced features that the import
script can't handle, but you can par it down so it only functions as a
disk image importer.  Theoretically, the GUI would be great for just
importing disk images, unfortunately that too is a bit buggy.

So, here's some background info.

20181010/DuckDuckGo import ova ovirt rhv  
20181010/https://www.ovirt.org/develop/release-management/features/virt/enhance-import-export-with-ova/  
20181010/DuckDuckGo ovirt upload ova template

Now, here's the sample script that you'll need to modify to get
something working.

20181010/https://github.com/oVirt/ovirt-engine-sdk/blob/master/sdk/examples/upload_ova_as_template.py

By far the biggest manual step and shortcoming that you'll need to
work with is the fact that the API can only handle uploading QCOW2
format images, as noted by the Ansible module documentation.  You can
easily convert the VMDK format disk to a QCOW2 format disk with the
following command, found on any one of your host machines:

    qemu-img convert -f vmdk -O qcow2 source.vmdk target.qcow2

20181010/DuckDuckGo convert vmdk qemu  
20181010/https://medium.com/dtoebe/convert-vmdk-to-qcow2-168c0166c86c  
20181010/https://docs.ansible.com/ansible/latest/modules/ovirt_disk_module.html

There is also the `virt-v2v` tool that is already installed on the
host machines.  You can use this tool to convert an OVA file that
contains VMDK format disk images to an OVA file that uses QCOW2 format
disk images.

First, create a temporary storage pool in your large NFS storage space.

    mkdir -m 1777 /home/nfs_storage/plain
    virsh pool-create-as staging dir --target /home/nfs_storage/plain

Now run `virt-v2v` as follows.

    virt-v2v -i ova guestvm1.ova -o libvirt -of qcow2 -os staging

Unfortunately, in the version of oVirt that I tried this on (which is
purportedly older than your version), I had "permission denied" issues
due to a known bug of the root user account not having a corresponding
`virsh` user account.  For the time being, you can work around this
bug by adding a simple environment variable option as follows.

    LIBGUESTFS_BACKEND=direct virt-v2v \
      -i ova guestvm1.ova -o libvirt -of qcow2 -os staging

Also note that the previously mentioned methods assume that your
version of `virt-v2v` and dependencies is too old to support a direct
import into oVirt.  Therefore, the previously described method is part
of a two-stage process to (1) import the VM into `libvirt` and (2)
import the `libvirt` VM into oVirt.  In the latest versions, you can
tweak the command line and run as follows to directly import into
oVirt.

    virt-v2v -i ova guestvm1.ova \
      -o rhv-upload \
      -oc https://ovirt01.local/ovirt-engine/api \
      -os ovirt02:/home/nfs_storage \
      -op /tmp/ovirtpasswd \
      -oo rhv-cafile=ovirt01.pem \
      -oo rhv-direct=true -v -x

Otherwise, if you need to do the two-stage approach, perform the
second stage, import from `libvirt` to oVirt, as follows.

1. Open up the oVirt web admin console.

2. Navigate to Compute > Virtual Machines.

3. Click on the triple dots at the right of the toolbar.

4. Select Import.

5. Setup the form values as follows.

    * Source: KVM (via Libvirt)
    * URI: qemu:///system
    * Requires Authentication: Yes
    * Username: vdsm@ovirt
    * Password: shibboleth
    * Proxy host: ovirt02 \<select host that you imported on\>

   Click load, select your virtual machine, and continue.  The rest of
   the steps should be self-explanatory

After you're done with the second-stage VM import, you can cleanup the
temporary first stage.

    virsh undefine VM-NAME
    rm -rf /home/nfs_storage/plain/*
    rmdir /home/nfs_storage/plain/
    virsh pool-destroy staging

20181010/DuckDuckGo ovirt export ova command line  
20181010/https://access.redhat.com/articles/1351963  
20181010/DuckDuckGo red hat virtualization export ova  
20181010/DuckDuckGo ovirt import ova  
20181010/https://www.ovirt.org/develop/release-management/features/virt/virt-v2v-integration/
20181010/http://libguestfs.org/virt-v2v/  
20181010/https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html-single/v2v_guide/index

Background information on using `virt-v2v` to import a Windows VM to
KVM.  The ideal for me would be import a VM directly from
ESXi/vCenter, but I haven't got that working, so instead I opt to
first export as an OVA, then import the OVA.

20181010/https://access.redhat.com/articles/1353463  
20181010/DuckDuckGo libvirt: ESX Driver error : invalid argument Path
  does not specify a host system

Failed search.

20181010/Google virt-v2v vpx://

Background information on the `virt-v2v` import bug on oVirt.

20181010/DuckDuckGo virt-v2v Could not open : Permission denied  
20181010/https://bugzilla.redhat.com/show_bug.cgi?id=1375157  
20181010/https://access.redhat.com/errata/RHBA-2017:2023  

Import a KVM VM into oVirt.

20181010/https://www.ovirt.org/develop/release-management/features/virt/KvmToOvirt/

Background information on using `virt-v2v`, `virsh`, and working with
`libvirt` storage.

20181010/http://manpages.ubuntu.com/manpages/bionic/man1/virt-v2v.1.html  
20181010/http://manpages.ubuntu.com/manpages/xenial/man1/virsh.1.html  
20181010/https://libvirt.org/storage.html

### Pre-installing `virtio` drivers

By default, oVirt uses `virtio` devices for the disk drives and
network interfaces.  In short, this means that if you import an
existing guest VM as-is, you will be left with an unbootable system.
And, even if you do manage to boot it, you will not be able to connect
to it over the network to issue commands through a script.  So, my
recommendation is to pre-install the drivers if possible.

#### Linux-based

On Linux-based guests, you can do this through the means of the
initrd-building utilities.  Search for all the `virtio` driver modules
under /lib/modules/`uname -r`, i.e. for your current kernel.  Then run
the initrd building command with the names of all those `virtio`
drivers.

On Red Hat, CentOS, and SUSE systems, you can pre-install the `virtio`
drivers using the following commands.

    dracut --add-drivers "virtio virtio_ring virtio_console virtio_pci virtio_blk virtio_scsi virtio_net virtio_rng" -f

Note that you can also rebuild the `initrd` for a different kernel
version than the currently running kernel.  In that case, you would
add a `--kver $KVER` command line option to specify that version.

When it is not possible to pre-install the `virtio` drivers, you must
take a stepping stone through a plain QEMU/KVM virtualization setup
before you enter the full oVirt virtualization setup.  But, before
doing this, you must have `virt-manager` installed somewhere.  We will
cover that in the "Console connection" section before continuing to
describe driver install process.

Another alternative method for installing `virtio` drivers for Linux.

1. Get one VM booted on oVirt through emergency mode, where you can
   load the oVirt drivers.  Note that this may only work for some OS
   distributions like Red Hat/CentOS, as SUSE still uses the initrd
   for emergency boot.

2. Mount LVM of non-booting VM to booting one, chroot to its disks,
   then rebuild initrd, twice.  If you renamed the LVM, once you
   rename it back, you'll also have to rename the contents inside the
   initrd.  Unpack it, and repack it using CPIO and LZMA compression.

NOTE: How to solve non a-booting LVM dracut.  Make sure that the LVM
names specified in your initrd match the actual LVM names.  If they do
not, check the `dracut` config files, change the values, and rebuild
using `dracut -f`.

20181010/DuckDuckGo dracut-initqueue timeout starting timeout requests
20181010/https://access.redhat.com/solutions/2515741  
20181010/DuckDuckGo centos install drivers for virtio disk  
20181010/DuckDuckGo centos install drivers for virtio disk update-initramfs  
20181010/https://wiki.centos.org/HowTos/KVM  
20181010/DuckDuckGo centos update init ramfs  
20181010/DuckDuckGo centos update initrd

NOTE: Here's how to use dracut to rebuild initrd: `dracut -f`.

20181010/https://www.thegeekdiary.com/centos-rhel-6-how-to-rebuild-initial-ramdisk-image/  
20181010/DuckDuckGo mount lv by uuid  
20181010/https://askubuntu.com/questions/110226/how-do-you-mount-a-lvm-patition-that-has-the-same-vg-name-as-my-current-partitio#680808  
20181010/DuckDuckGo mount lvm  
20181010/https://superuser.com/questions/116617/how-to-mount-an-lvm-volume#666034

#### Windows

Pre-installing drivers on Windows is a particular challenge because
Windows is only designed to install drivers on-demand, when the actual
hardware devices are recognized.  This works fine for non-boot devices
on a running Windows system, and for boot devices during the initial
install of Windows, but it doesn't scale nicely to the case of
migrating VMs from one hypervisor to another.  However, it is
possible, though challenging, to pre-install drivers on Windows.  This
way, you can install the drivers when running on an existing
hypervisor, then migrate to oVirt easier.

The primary requirement is an additional program to do the work of
pre-installing the driver.  There are two ways to do this:

1. Use the program included in the Windows Driver Development Kit,
   `DPInst.exe`.

2. Use a third-party program that does the same thing.

Alternatively, rather than pre-installing the drivers for Windows, you
can do a multi-stage migration as follows.

1. Import the VM into `libvirt` using the previously mentioned method.

2. Reconfigure the VM's hardware so that it both has a compatible boot
   disk and also all the new `virtio` hardware connected at the same
   time.

3. Boot Windows, then manually install/update the drivers for all the
   new `virtio` hardware as follows.

    * Open the Device Manager
    * Look for unrecognized devices in order, then install drivers for
      them by means of "upgrade driver."
    * Map devices to updated drivers as follows.
    * "Ignore HID Button over Interrupt Driver", that is a bug.
    * First "PCI Device", i.e. `\\VEN_1AF4&DEV_1002...` => Balloon
    * Second "PCI Device", i.e. `\\VEN_1AF4&DEV_1005...` => viorng
    * PCI Simple Communications Controller => vioserial
    * First SCSI Controller, i.e. `\\VEN_1AF4&DEV_1001` => viostor
    * Second SCSI Controller, i.e. `\\VEN_1AF4&DEV_1004` => vioscsi
    * Ethernet Controller => NetKVM
    * Microsoft Basic Display Adapter => qxldod

4. Shut down Windows, change all hardware to `virtio`, and finish the
   import into oVirt, using the previously mentioned method.

Background information:

20181010/DuckDuckGo windows virtio drivers  
20181010/https://superuser.com/questions/485351/installing-virtio-drivers-in-windows-server-2008/502134  
20181010/https://web.archive.org/web/20130324035326/https://www.bfccomputing.com/2009/09/14/converting-a-windows-vista-kvm-virtual-machine-to-redhat-virtio-drivers/  
20181010/http://www.zeta.systems/blog/2018/07/03/Installing-Virtio-Drivers-In-Windows-On-KVM/  
20181010/DuckDuckGo windows precopy virtio device drivers  
20181010/https://www.itfromallangles.com/2011/03/kvm-guests-install-virtio-drivers-for-windows-guests/

Find the `virtio` driver disk here, at the final link in the
redirection chain.

20181010/https://dl.fedoraproject.org/pub/alt/virtio-win/latest/images/  
20181010/https://dl.fedoraproject.org/pub/alt/virtio-win/latest/images/deprecated-README  
20181010/https://docs.fedoraproject.org/quick-docs/en-US/creating-windows-virtual-machines-using-virtio-drivers.html  
20181010/https://docs.fedoraproject.org/en-US/quick-docs/creating-windows-virtual-machines-using-virtio-drivers/index.html  
20181010/https://docs.fedoraproject.org/en-US/quick-docs/creating-windows-virtual-machines-using-virtio-drivers/index.html#virtio-win-direct-downloads

20181010/DuckDuckGo preinstall windows drivers  
20181010/https://docs.microsoft.com/en-us/windows-hardware/drivers/install/preinstalling-driver-packages

Here is a link to a third-party program.

20181010/http://ultimaserial.com/preinstalldriver.html

20181010/https://4sysops.com/archives/pre-install-device-drivers-with-dpinst-exe-of-the-windows-driver-kit/  
20181010/https://social.technet.microsoft.com/Forums/windows/en-US/30d10df7-724c-41eb-a722-7a3744e26d75/pre-install-a-printer-without-being-phisically-connected  
20181010/DuckDuckGo windows pre install virtio virtual disk driver
  cannot boot

And here's how to download files with PowerShell for convenience.

20181010/DuckDuckGo powershell download file  
20181010/https://blog.jourdant.me/post/3-ways-to-download-files-with-powershell

Wondering about the "HID Button over Interrupt Driver" unknown device
that appears on Windows Server 2016?  Don't worry about it, it is a
false device probe that isn't what it says it is.  Just ignore it.

20181010/DuckDuckGo windows qemu hid button over interrupt driver  
20181010/https://bugzilla.redhat.com/show_bug.cgi?id=1377155

### Installing oVirt guest agents

#### Red Hat/CentOS

Install oVirt guest agents for Red Hat or CentOS as follows:

    yum install -y qemu-guest-agent ovirt-guest-agent-common
    systemctl enable ovirt-guest-agent.service

NOTE: ovirt-guest-agent install HOWTO for Fedora

20181010/DuckDuckGo ovirt install guest agent  
20181010/https://www.ovirt.org/documentation/how-to/guest-agent/install-the-guest-agent-in-fedora/

#### SUSE

Looking for the oVirt guest agent for SUSE?  Beware, there are
broken references to an outdated link on the Internet.

20181010/DuckDuckGo suse install ovirt guest agent  
20181010/DuckDuckGo opensuse ovirt-guest-agent  
20181010/DuckDuckGo opensuse 12.2 ovirt-guest-agent  
20181010/DuckDuckGo sles 12.2 ovirt-guest-agent  
20181010/https://software.opensuse.org/download.html?project=Virtualization%3AoVirt&package=ovirt-guest-agent  
20181010/https://software.opensuse.org/package/qemu-guest-agent?search_term=qemu-guest-agent  
20181010/https://pkgs.org/download/ovirt-guest-agent  
20181010/DuckDuckGo suse qemu guest agent  
20181010/DuckDuckGo suse qemu guest agent  
20181010/https://www.ovirt.org/develop/release-management/features/virt/guestagentopensuse/  
20181010/Google ovirt guest agent suse  
20181010/https://bugzilla.redhat.com/show_bug.cgi?id=1043471  
20181010/http://download.opensuse.org/repositories/home:/evilissimo/SLE_11_SP3/

Find it here, including the latest versions for your up-to-date SUSE
setup.

20181010/http://download.opensuse.org/repositories/home:/evilissimo/SLE_12_SP2/

Install them as follows:

    curl -L -O http://download.opensuse.org/repositories/home:/evilissimo/SLE_12_SP2/noarch/ovirt-guest-agent-common-1.0.14-9.1.noarch.rpm
    curl -L -O http://download.opensuse.org/repositories/home:/evilissimo/SLE_12_SP2/x86_64/python-ethtool-0.11-12.1.x86_64.rpm
    zypper --no-gpg-checks install -y ovirt-guest-agent-common-1.0.14-9.1.noarch.rpm python-ethtool-0.11-12.1.x86_64.rpm
    systemctl enable ovirt-guest-agent.service
    rm -f  ovirt-guest-agent-common-1.0.14-9.1.noarch.rpm python-ethtool-0.11-12.1.x86_64.rpm

#### Windows

First, make sure you've installed the drivers for Windows.  If the
drivers are installed, you can first install the QEMU guest agent
(`qemu-ga-x64.msi` for 64-bit or `qemu-ga-x86.msi` for 32-bit), then
the oVirt guest agent.  Actually, installing the QEMU guest agent as a
separate step is optional, as you can also install it via the oVirt
guest agent installer.

Since you've already installed the `virtio` drivers for Windows, you
do not need to install everything that is available on the oVirt guest
agent disk.  In particular, you only need to select the following for
installation.

* oVirt VirtIO Serial
* oVirt Spice Agent
* oVirt Agent
* oVirt Qemu GA

20181010/DuckDuckGo windows install qemu agent  
20181010/https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/virtualization_administration_guide/sect-qemu_guest_agent-running_the_qemu_guest_agent_on_a_windows_guest  
20181010/https://wiki.libvirt.org/page/Qemu_guest_agent  
20181010/https://pve.proxmox.com/wiki/Qemu-guest-agent

Anyways, find the oVirt guest utilities disk here.

20181010/DuckDuckGo ovirt guest utilities  
20181010/https://www.ovirt.org/develop/release-management/features/integration/windows-guest-tools/  
20181010/https://resources.ovirt.org/pub/ovirt-4.2/iso/oVirt-toolsSetup/

### Console connection

Connecting to the VM console in the current version of oVirt is a bit
tricky.  First of all, the preferred VM console connection in modern
QEMU is the SPICE protocol, which is a bit less standard than the
older VNC protocol that was used.  Second, if you have a promiscuous
deep packet inspection firewall between your client machine and your
host machines (i.e. typical enterprise networks), you're going to have
problems with the SPICE protocol.

So, what's the easiest way to get started with the console connection?
Start by installing `virt-viewer` on the virtualization manager.
Also, let's install some other useful management tools at the same
time.

    yum -y install xauth libvirt-client virt-viewer virt-manager \
      openssh-askpass cyrus-sasl-scram cyrus-sasl-gssapi

Log into the manager machine with trusted SSH forwarding:

    ssh -Y root@ovirt01

Run `ovirt-shell` with your saved `.pem` file to auto-launch
`virt-viewer` to your desired VM.

    # Make sure you use the FQDN you've provided at install time for
    # proper HTTPS.
    ovirt-shell -A ovirt01.pem
    URL: https://ovirt01.local/ovirt-engine/api
    Username: admin@internal
    Password: <pw>
    [oVirt shell (connected)]# console testvm1

NOTE: You **must** add your host certificates to the machine you are
running `ovirt-shell` abd `virt-viewer` from as follows:

    update-ca-trust force-enable
    cp ovirt01.pem /etc/pki/ca-trust/source/anchors/
    update-ca-trust extract

Otherwise, `ovirt-viewer` will fail to launch.

Okay, now that you've verified you've got that to work, you can try
out the more challenging method of connecting through the portal, or
even more challenging method of connecting over the HTML 5 console.

20181010/https://en.wikipedia.org/wiki/Simple_Protocol_for_Independent_Computing_Environments  
20181010/https://www.ovirt.org/documentation/admin-guide/virt/console-client-resources/  
20181010/https://virt-manager.org/download/  
20181010/DuckDuckGo spice html5 use ovirt  
20181010/DuckDuckGo spice html5 install ovirt manager  
20181010/https://www.ovirt.org/develop/release-management/features/virt/novnc-console/  
20181010/https://www.ovirt.org/develop/release-management/features/virt/spicehtml5/

Configuring SPICE and VNC to use the HTML5 websocket proxy in RHEV 3.3

20181010/https://access.redhat.com/solutions/718653  
20181010/DuckDuckGo spice html5 howto  
20181010/https://www.spice-space.org/spice-html5.html  
20181010/DuckDuckGo ovirt check if spice server is running  
20181010/https://www.ovirt.org/documentation/how-to/guest-console/connect-to-spice-console-with-portal/  
20181010/https://www.ovirt.org/documentation/how-to/guest-console/connect-to-spice-console-without-portal/

Test if a WebSocket is active, trying to connect to the WebSocket
proxy for the HTML 5 SPICE interface.

20181010/DuckDuckGo test if a websocket is active  
20181010/https://stackoverflow.com/questions/42112919/check-if-websocket-server-is-running-on-localhost#42113398  
20181010/https://gist.github.com/htp/fbce19069187ec1cc486b594104f01d0

Trials on learning about trying to get HTML 5 SPICE client.

For now, I've concluded that getting the HTML 5 SPICE client is too
tough to do if you've got to jump through firewall hoops and the like.
But, if you want to give it a try.  First note that the SPICE HTML 5
web socket proxy is enabled by default on the virtualization manager,
unless you opted to disable it during `engine-setup`.

1. Install the SPICE HTML 5 client on the manager: `yum -y install
   spice-html5`.

2. Configure the HTTP server to serve up this client from a URL.

3. Install certificates on your browser-side computer if necessary.

4. Try launching the SPICE HTML 5 client by connecting to the URL
   you've configured for it.

Verify the proxy is configured.

20181010/https://access.redhat.com/solutions/718653  
20181010/DuckDuckGo ovirt web socket proxy  
20181010/https://www.ovirt.org/documentation/admin-guide/chap-Proxies/

Install the proxy on a separate machine.

20181010/DuckDuckGo installing a websocket proxy on a separate machine  
20181010/https://www.ovirt.org/documentation/install-guide/appe-Installing_the_Websocket_Proxy_on_a_Separate_Machine/

This is the GitHub repo for the SPICE HTML 5 client.

20181010/DuckDuckGo github spice html 5  
20181010/https://github.com/openstack/deb-spice-html5  
20181010/hhhhttps://github.com/openstack/deb-spice-html5/blob/master/spicetype.js

This is the GitHub repo for a generic TCP socket to WebSocket proxy.

20181010/https://github.com/novnc/websockify

As you can see, a patch was proposed but was not accepted upstream,
hence the need to use the proxy.

20181010/https://lists.freedesktop.org/archives/spice-devel/2016-June/030552.html

This is the Debian package for the SPICE HTML 5 client.

20181010/DuckDuckGo package spice-html5  
20181010/https://packages.debian.org/stretch/spice-html5

### Serial console connection

So VMware can do a serial console, but it is arguably not as elegant
as the solution in oVirt.  Anyways, the serial console in oVirt is an
excellent addition to virtualization capabilities, especially if you
are working with emulated architectures such as ARM or MIPS that
typically do feature serial consoles.  The serial console connection
to your VMs can be very convenient when you have trouble with
networking, and the graphical console can be a pain to deal with.

20181010/DuckDuckGo vmware serial console  
20181010/https://communities.vmware.com/thread/312091

When you create or import your virtual machine into oVirt, make sure
that the virtio serial console is enabled on your VM.  Go to your VM
settings, make sure "Show Advanced Options" is clicked, and then make
sure "Enable VirtIO serial console" is clicked.

#### Linux guests

Getting the serial console setup correctly can be a bit tricky too, so
here's how to do it for Linux-based guest VMs.

First of all, in your guest VM, edit your bootloader to boot your
kernel, and optionally your bootloader, with with the correction
options for the serial console.

For systems that use GRUB 2 and a generator/builder for the GRUB 2
config file, follow the instructions from this oVirt documentation
page.

20181010/https://www.ovirt.org/documentation/vmm-guide/chap-Installing_Linux_Virtual_Machines/

NOTE: Also note that there are driver install details on that page.
However, I've already covered most of that information in the previous
sections.

They are quoted here for easy reference.

1. Add these settings to `/etc/default/grub`:

       GRUB_CMDLINE_LINUX="console=tty0 console=ttyS0,115200n8"
       GRUB_TERMINAL="console serial"
       GRUB_SERIAL_COMMAND="serial --speed=115200 --unit=0 --word=8 --parity=no --stop=1"

   **Note:** `GRUB_CMDLINE_LINUX_DEFAULT` applies this configuration
   only to the default menu entry. Use `GRUB_CMDLINE_LINUX` to apply
   the configuration to all the menu entries.

2. Rebuild /boot/grub2/grub.cfg:

    * BIOS-based machines

          grub2-mkconfig -o /boot/grub2/grub.cfg

    * UEFI-based machines

          grub2-mkconfig -o /boot/efi/EFI/redhat/grub.cfg

3. In the oVirt Web UI administrative console, edit the virtual
   machine, make sure "Show advanced options" is selected, go to the
   **Console** tab, and select **Enable VirtIO serial console** check
   box.

After you have your guest VM setup, you must use SSH keys to connect
to the SSH oVirt serial console director, so set this up as follows.
Again, we're quoting information from the previous mentioned oVirt
documentation page.

1. Generate the keys for the serial console director.

       ssh-keygen -t rsa -b 2048 -C "user@domain" -f .ssh/serialconsolekey

2. In the Administration Portal or the VM Portal, click the name of
   the signed-in user on the header bar and click **Options** to open
   the **Edit Options** window.

3. In the **User's Public Key** text field, paste the public key of
   the client machine that will be used to access the serial console.

4. Now you can connect to the serial console director as follows:

       ssh -t -p 2222 ovirt-vmconsole@ovirt01 -i .ssh/serialconsolekey

5. To disconnect, press enter followed by `~.` to close a serial
   console session.

Note that if you login to the host machine directly, you can also
connect to a VM serial console as follows, using GNU Screen:

    screen /dev/pts/0

Use the correct pseudo-terminal for your target VM as found out
through `virsh` or `virt-manager`, of course.

DuckDuckGo ovirt serial console  
https://www.ovirt.org/develop/release-management/features/virt/serial-console/  
DuckDuckGo ovirt serial console api  
DuckDuckGo ovirt serial console python  
DuckDuckGo ovirt write to serial console python  
https://github.com/oVirt/ovirt-vmconsole/  
DuckDuckGo qemu connect to serial console tty  
https://rwmj.wordpress.com/2011/07/08/setting-up-a-serial-console-in-qemu-and-libvirt/  
DuckDuckGo ovirt serial console  
https://www.ovirt.org/documentation/vmm-guide/chap-Installing_Linux_Virtual_Machines/

#### Windows guests

Can you do a serial console on Windows?  Indeed you can!  Here's how
to setup the serial console on Windows, which is called the Emergency
Management Console (EMS) and Special Administration Console (SAC).
Note that only server versions of Windows support the EMS.  For client
versions of Windows, your next best option to get a similar experience
is to install OpenSSH, but this comes with the requirement that
networking must be up for the console to be accessible, unfortunately.
See my other blog post on the subject for more details: [Set up
Windows for SSH-style access]({{ site.baseurl }}/blog/2018/10/25/windows-ssh-style).

XP/2003:

    ootcfg /ems on /port com1 /baud 9600 /id 1

Vista/2008+:

    bcdedit /bootems {default} ON
    bcdedit /emssettings EMSPORT:1 EMSBAUDRATE:115200

NOTE: From experimental trials, you must do this for newer versions of
Windows to get the EMS working.  Now there are different commands for
the bootloader versus operating system entries.

    bcdedit /bootems {bootmgr} ON
    bcdedit /emssettings EMSPORT:1 EMSBAUDRATE:115200
    bcdedit /ems {current} ON

20181010/DuckDuckGo windows serial console  
20181010/https://serverfault.com/questions/554298/windows-serial-console#554300

So, I was having a bit of trouble getting it setup on QEMU.  Let's see
if there's more information on how to set this up correctly.  Oh,
there is an INF driver file that may be of use to get it setup
correctly.  UPDATE: I tried some manual serial console testing via
direct input on the QEMU pseudo-terminal and Windows COM1 devices and
verified that the serial console access works without needing to
install any drivers.

20181010/DuckDuckGo qemu windows ems  
20181010/DuckDuckGo qemu windows serial console  
20181010/DuckDuckGo qemu windows server serial console  
20181010/https://serverfault.com/questions/309894/how-to-add-a-serial-com-port-to-windows-server-2008-using-linux-kvm-qemu#327837  
20181010/DuckDuckGo qemu windows nt serial port  
20181010/https://github.com/qemu/qemu/blob/master/docs/qemupciserial.inf  
20181010/https://falstaff.agner.ch/2016/08/23/using-kvm-with-qemu-on-arm/

After some frantic searching, I've finally found some fully up-to-date
information and more comprehensive documentation on EMS.  Good news,
EMS is enabled by default on newer versions of Windows server.  Bad
news, EMS is not available on older client versions of Windows.  Also
note that the default shell started by EMS is Special Administration
Console (SAC).  So if you're wondering how to use that, look for more
information on that.

Very interesting what's going on here.  All the new development is
focused on Azure and is Linux-centric.  One by one, features that have
come to be expected on Linux are being "backported" as afterthoughts
for Windows, after a full two decades of being ignorant.

20181019/DuckDuckGo microsoft sac toggle paging
20181019/https://social.technet.microsoft.com/forums/windows/en-US/1a0ebfcd-edfb-4bf9-adc7-96c3e799bd47/is-it-possible-to-add-the-special-administration-console-sac-to-windows-7  
20181019/DuckDuckGo msdn sac  
20181019/DuckDuckGo sac site:msdn.microsoft.com  
20181019/DuckDuckGo sac paging site:msdn.microsoft.com  
20181019/DuckDuckGo ems sac paging site:msdn.microsoft.com  
20181019/DuckDuckGo ems sac site:msdn.microsoft.com  
20181019/DuckDuckGo emergency management services site:msdn.microsoft.com  
20181019/DuckDuckGo emergency management services escape site:msdn.microsoft.com  
20181019/DuckDuckGo special administration console site:msdn.microsoft.com  
20181019/DuckDuckGo microsoft special administration console  
20181019/DuckDuckGo microsoft "special administration console"  
20181019/DuckDuckGo windows "special administration console"  
20181019/https://azure.microsoft.com/en-us/blog/virtual-machine-serial-console-access/  
20181019/https://docs.microsoft.com/en-us/azure/virtual-machines/troubleshooting/serial-console-windows  
20181019/https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2003/cc787940(v=ws.10)

### oVirt API example: Get IP addresses of guest VMs

Now, this is a common and useful thing that people want to do, so here
is an example that does so in Python.  Beware, this is programmed
against the V3 oVirt Python API.  Yes, it still works when run against
a V3 oVirt Python API library, but make sure you don't try to run this
code on a newer oVirt Python API library.  In other words, install
this first:

    pip install ovirt-engine-sdk-python==3.6.9.2

20181010/DuckDuckGo ovirt get ip address of vm  
20181010/https://www.humblec.com/ovirt-list-vms-ip-addresses-nic-details-etc-using-python-sdk-part-4/

### Guest operating system images

So, now you're wondering.  Importing existing guest VM images as-is
won't lead to a very interesting experience due to the lack of the
QEMU guest agent.  So, what's the easiest way to get started with
that?  Download one of the existing guest images with the QEMU guest
agent built-in.  But then you'll encounter a problem.  What is the
default root password?  Actually, there is no default root password:
the root password is disabled and completely blank.  You'll have to
edit the guest VM image to add a password as follows.  **Do not** do
this on a running VM image, or else you risk corrupting it.

    # Use guestfish to edit the filesystem as follows.
    # NOTE: Do not copy-paste as this requires an interactive terminal.
    guestfish --rw -o target.qcow2
    run
    # Enter auth credentials if necessary.
    list-filesystems
    mount /dev/sda1 /
    PASS_HASH=`openssl passwd -1 changeme`
    sed -i -e "s/^root:!!/root:$PASS_HASH/g" /etc/shadow
    quit

20181010/DuckDuckGo red hat KVM default root password  
20181010/https://access.redhat.com/discussions/1517483  
20181010/https://access.redhat.com/discussions/664843  
20181010/https://access.redhat.com/solutions/641193  
20181010/https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/virtualization_deployment_and_administration_guide/sect-guest_virtual_machine_disk_access_with_offline_tools-the_guestfish_shell

### Exporting VMs to OVA

Exporting a VM from oVirt is simple.  Just use the web admin console
to click on a VM, click on the triple dots, then click "Export as
OVA."

Well, it _should_ be simple, but unfortunately there was a bug when I
first tried this.  Hopefully you won't encounter this bug by the time
you try it out.  Trying to export an OVA via the Web UI and getting
failure and "Permission denied" in the oVirt engine logs?  Here's
what's happening.  When you export a VM, oVirt creates a clone of the
disks and then needs to access those disks correctly to complete the
OVA export.  The "Permission denied" comes from read access for
"other" not being enabled on the disks.  So, here's how you can fix
that problem.  Log into the host machines where the disk clones are
happening on, and run this in a root shell.

    cd /home/nfs_storage
    while true; do chmod o+r */*; sleep 0.5; done

Run the OVA export while that is happening, and the OVA disk export
should then complete without issues.

Note that an Ansible playbook is used to perform the import and export
tasks, so there is hope that this task can also be easily integrated
into an Ansible playbook of your own.

### Conclusion

Whoah!  That was a blog article of epic length, not to mention that
this blog article was correspondingly epicly difficult to research and
organize all the information for.  I hope you've enjoyed learning
about setting ip an oVirt virtualization environment from my hands-on
beginner's perspective.  I know I'll sure be using QEMU more often now
that I am more skilled with using that software component from this
exercise.  As for oVirt, well I might not be using that nearly so
often as I don't really have a need to setup computers at that kind of
scale very frequently.
