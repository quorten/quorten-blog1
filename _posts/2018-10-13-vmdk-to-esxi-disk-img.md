---
layout: post
title: Convert a VMDK disk image to an ESXi disk image
author: quorten
date: 2018-10-13 12:00 PM -0500
categories: [unix, centos, vmware]
tags: [unix, centos, vmware]
---

Suppose you have a VMDK disk image, and you want to import that
directly into an ESX host.  How do you do that?

As it turns out, ESX hosts do not run off of VMDK disk images.  You
have to convert it to an ESX compatible format in order to be able to
run it.  ESX compatible format disk images are composed of two files:
one `*.vmdk file` and another `*-flat.vmdk` file.  The first file is
the header, the second file is the disk image data itself.

So, here's how I was able to successfully do it.

1. Download and unzip `-vdiskmanager-windows-7.0.1.exe2.zip` for
   Windows from the linked VMware KB article.  I couldn't easily get
   the Linux one working because it was only 32-bit and I didn't have
   a multiarch machine on hand, otherwise I'd prefer to use that one.

<!-- more -->

2. Run the utility as follows:

       vmware-vdiskmanager.exe -r my-virtualbox-disk.vmdk \
         -t 4  my-new-esxi-disk.vmdk

   This will result in two files, `my-new-esxi-disk.vmdk` and
   `my-new-esxi-disk-flat.vmdk`.

   I chose `-t 4`, for ESX thick provision compatible image, because
   the tool claimed that it doesn't support ESX thin provision images.
   If you choose a thick provision type, absolutely make sure you have
   enough disk space to store the destination image on the machine you
   are running the conversion on.

3. Now upload these files using the vCenter file manager.  Create a
   temporary folder to store them in.  They will show up in the file
   manager as only one file, even though they are too.  Beware of
   complications this will cause.

4. Create a new virtual machine with the device specifications you
   want.  Include a blank disk with your desired specifications.

5. Delete the unused blank disk from your VM.

6. **Copy** the disk image "file" from your temporary folder to your
   new folder.  You should copy, rather than move, to make sure that
   you get both files copied over, even when the vCenter file manager
   only displays it as one file.

7. Delete the temporary folder and temporary disk image copy.

20181013/DuckDuckGo vcenter upload vmdk disk image  
20181013/https://communities.vmware.com/thread/472934  
20181013/https://kb.vmware.com/s/article/1023856  
20181013/https://www.lewan.com/blog/how-to-use-vmware-converter-to-import-vms-or-vmdks-into-vsphere  
20181013/DuckDuckGo flat.vmdk file  
20181013/https://www.on-cloud9.com/2012/01/16/virtual_machine_files_explained/

Now having issues on power-on?  "Failed to lock vm power on."
Navigate to the virtual machine in the vCenter file manager.  You'll
see some log file stored there.  Take a look at them.  If you were
like me, you would have tried to rename the disk images to the
original names of the new VM that you've created that you desire to
replace the disks on.  Do not rename the disk image files, as they
contain internal name reference pointers to each other that would also
have to be renamed.  Instead, edit the virtual machine's `*.vmx` file
to point to the names of your converted disk images.

20181013/DuckDuckGo vmware failed to lock vm power on  
20181013/https://communities.vmware.com/thread/467312  
20181013/https://kb.vmware.com/s/article/1038189

All in all, I would much more highly recommend that you "surgically"
create an OVA file to import that contains your VMDK format disk
image.  As I have pointed out, I was unable to create an ESX "thin"
disk image, which was tremendously inconvenient for the time that I
had to find **large** temporary storage to buffer up the converted
files to.

So, here's how to do that.

1. Create a virtual machine in vCenter/ESX that contains most the
   specifications you want on the destination VM.

2. Export that to an OVA file.

3. Untar the OVA file.

4. Replace the VMDK disk image with the desired disk image of your
   choice.  If you have doubts as to how plain the VMDK image file is,
   you can try using the aforementioned conversion tool on it to
   convert it to a plain VMDK file.

5. Edit `*.mf` file with updated checksums.  The checksums are SHA1
   format.

6. Repack the OVA tar archive.  You must pack it in this order.

    1. `*.ovf` file
    2. Everything else
    3. `*.mf` file.

7. Import that OVA file into vCenter/ESX.  Now you have your new VM
   built from an existing VMDK disk image.

----------

UPDATE 2020-12-15: What if you really do want to be able to run the
Linux executable on 64-bit CentOS?  And modern CentOS 8 to boot?
Well, although the documentation appears tricky and hard to find,
here's what I've found to be able to work.  The trickiest part is the
fact that the binaries depend on an old version of OpenSSL, assumed to
have been distributed with VMware workstation when you bought the
license.  But I didn't buy the license, all I have is ESXi!  Well, no
worries, there's a workaround to get that working too.  But the trick
is that even though it was only ever designed for CentOS 6 and CentOS
7, you can still get it working in CentOS 8 if you do a manual install
of the package binaries.  Interestingly, it appears that the old
package wasn't just a recompile of the old version of OpenSSL, but is
actually designed as a transparent compatibility wrapper to use the
newer version included in the distro, which is why it works with newer
CentOS.

```
# sudo yum groupinstall "Compatibility Libraries"
sudo dnf -y install glibc.i686 zlib.i686
# sudo dnf -y install openssl098e
# 20201205/https://centos.pkgs.org/7/centos-x86_64/openssl098e-0.9.8e-29.el7.centos.3.i686.rpm.html
curl -L -O https://mirror.centos.org/7/os/x86_64/Packages/openssl098e-0.9.8e-29.el7.centos.3.i686.rpm
sudo dnf -y install openssl098e-0.9.8e-29.el7.centos.3.i686.rpm

mkdir -p ~/libdir/lib/libcrypto.so.0.9.8
ln -s /usr/lib/libcrypto.so.0.9.8e ~/libdir/lib/libcrypto.so.0.9.8/libcrypto.so.0.9.8
mkdir -p ~/libdir/lib/libssl.so.0.9.8
ln -s /usr/lib/libssl.so.0.9.8e ~/libdir/lib/libssl.so.0.9.8/libssl.so.0.9.8
```
