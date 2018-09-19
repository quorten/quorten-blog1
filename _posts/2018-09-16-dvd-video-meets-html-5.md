---
layout: post
title: "Everything I need to know about DVD video encoding and HTML 5
        video migration"
author: quorten
date: 2018-09-16 14:22 -0500
categories: [misc]
tags: [misc]
---

What you... okay, what I need to know about DVD video encoding.  First
of all, some important background information.  Smartphones surged in
growth in the year 2010 and have reached a mature user base measuring
in the billions by the year 2015.  All modern smartphones are equipped
with video cameras that are capable of recording both photos and
videos.  The video encoding system output is compressed with H.264
AVC, making it perfectly suited for upload to social media video
sharing sites and playback from modern HTML 5 browsers without any
video transcoding.  In fact, the only _format conversion_ that may
ever be needed is to repackage the video codec stream into a different
container format.  Beyond that, all other format conversions are
mainly provided as a convenience, not a necessity.

Now, let us for a moment take a step backwards from the modern era.
What happened before the times of the year 2010?  Before the year
2010, we were living in the dark ages of video recording and playback.
To be honest, there were no clear standards that emerged that were
suitable for all uses of video recording.

<!-- more -->

* Professional movie studios mastered digital video discs in either
  DVD or Blu-ray format.  In the past, they also mastered in Video CD
  format.  For computer files and Internet distribution, MPEG-2 was
  the format of choice.  The market for commercial purchases on VHS
  videocassette tapes was clearly coming to its end, though still
  running at a smaller size.

* For amateur video recording and security camera video recording, VHS
  videocassette recorders were still in widespread use.  However, for
  these applications, analog video camera cathode-ray tubes were
  largely phased out by approximately the year 2005: CCD/CMOS image
  sensors were the component of choice in amateur and security
  cameras.

* QuickTime video files were originally only used for short computer
  videos, but later used as the video file format of choice for
  point-and-shoot digital cameras that had very limited video
  recording capabilities.  AVI video files were only ever used for
  short computer videos.

* Cellphone video recording was stored in this weird `.3GP` file
  format that nobody else used.

* Video game "cinematic sequences" were stored in Bink video and DivX
  video file formats.  Nobody outside the video game indsutry knew how
  to author Bink video files, much less watch them, although DivX
  videos became mildly popular outside the video game industry.
  Before Bink video, there was this even older video format named
  Smacker video that even less people used, again used primarily by
  video game developers.

* Some purpose-built consumer camcorders recorded directly to to the
  DVD Video file format on DVD mini-dics.  An even smaller minority
  recorded directly to internal hard disk drive or solid-state
  storage.

* In theory, there existed some cameras and hardware players that
  could work with Windows Media Video (WMV) files.  In practice, I
  have never personally encountered such equipment.

  Finally, there are hundreds more obscure, proprietary, and obsolete
  digital video formats that I have not mentioned here for the obvious
  reason that they are too obscure to be personally notable to me.

* In what was considered the bygone distant past in the year 2005,
  even older amateur video recorders of two decades past recorded
  video onto photosensitive film reels rather than magnetic tape.

Clearly, nowadays we know much better when it comes to digital video
encoding technology than we did during between the years 2000 - 2010.
Of course, this is all a relative comparison, as conditions were even
worse between the years 1970 - 2000, and arguably even more so before
1970.

But now... to set the table for my own interests.  What do I have to
say about my video sources from this time era?

* Smacker video, Bink video, QuickTime video, and AVI video?  I've
  found the player software with ease.  These are just self-contained
  computer files that you run through the player, end of story.
  Point-and-shoot digital cameras store separate clips as separate
  files.  Enough said.  Cellphone video???  We barely ever had many
  `.3GP` files, so there are very few remaining, but nonetheless
  mainstream GNU/Linux video players can play these files so long as
  you have the proper codecs installed.  DivX video?  This should be
  the same story, make sure you have the codecs installed.  Don't
  bother with WMV video, but same story anyways if you are interested.

* DVD Video?  Given that I have a DVD Video camcorder, this is by far
  one of the tougher formats to modernize.  Also, this is the original
  subject of the body of this article, so see the next section for
  details.

* Blu-ray video?  I don't have any Blu-ray discs that I know of, much
  less a Blu-ray camcorder.

* VHS videocassettes?  Unfortunately I still haven't decided on a
  solution for this.  I was hoping to do the digital video recording
  through a Raspberry Pi, but it looks like I might have quality
  problems without the application of lots of purpose-specific
  programming, which will take perhaps too much time.  So, I'm
  probably going to end up buying a purpose-specific USB composite
  video or S-video input device that works with GNU/Linux libre
  software.  It will be stupid because the quality, NTSC video, will
  only be good enough to digitize VHS video (which is less than NTSC
  video quality), but at least it will be easy to shop for and buy.

  If I'm willing to go really stupid, I might even get such a device
  that only works on Windows.

  I have a DVD Video camcorder that has the technical capability to
  record from composite video and S-video input, but it is
  deliberately engineered to obfuscate this capability lest it be used
  to make unauthorized copies of proprietary videos.  So, that's a dud
  for digitizing.

  Remember this when searching the Internet for conversion devices.
  Linux video recording information is tough to come by, so follow
  this search strategy.  First search for some good hardware,
  regardless of the operating system support.  Then see if you can
  search out and find information on the hardware on the Linux TV
  wiki.  Example.

  20180916/DuckDuckGo usb composite video input linux  
  20180916/DuckDuckGo usb s-video input linux  
  20180916/https://www.amazon.com/S-Video-Composite-Capture-Adapter-Support/dp/B00535BRBI  
  20180916/DuckDuckGo SVID2USB23 linux  
  20180916/https://www.linuxtv.org/wiki/index.php/Ion_Video_2_PC

----------

Now, what I need to know for modernizing DVD Video from a DVD Video
camcorder.  I have a few formats that I exported video from the
camcorder in:

* "Finalized" DVD Video discs, playable on a purpose-built DVD player
  hardware.

* "Backups" of DVD video discs, basically an unmodified digital copy
  of the DVD files to an external hard drive.  (Usually copies to two
  external hard drives for redundant back-up, of course.)

* "Exports" of individual DVD video clips to separate `.mpg` files.
  No additional processing needed for modern use, except possibly
  fiddling with the headers to set the "interlaced video" scan option
  correctly.

Again, I reiterate, because this is important!  Let's review what we
know about the DVD Video file format.  Most of this comes from the
following Wikipedia page:

20180916/https://en.wikipedia.org/wiki/DVD-Video

* All video files are stored in a `VIDEO_TS` directory.

* `*.VOB` files.  If there is only one file, this is your MPEG-2 video
  file.  If there are multiple files, use the Unix `cat` command to
  concatenate them altogether, in the order of their sequence numbers,
  to get your MPEG-2 video file.

* `*.IFO` file.  This contains your chapter division declarations.
  Use this file to split your single large MPEG-2 file into individual
  video clips.

* `*.BUP` file.  This is just a redundant backup copy of your `*.IFO`
  file.

DVD Video places several restrictions on the MPEG-2 data stream in the
VOB file.  For the features and purposes of my DVD Video camcorder,
the noteworthy ones are listed here:

* My DVD Video camcorder records "NTSC format" DVD Video resolutions.
  That means only video resolutions are 480 scanlines tall are
  applicable.

* Widescreen recording is only applicable in 720 x 480 resolution
  MPEG-2 data streams.  Do not try to export a widescreen video
  recording in other resolutions.

* 4:3 aspect ratio video should typically be in the 704 x 480
  resolution.  When the Sony D-1 digitized video at "720 x 480"
  resolution, this included digitization of horizontal retrace, hence
  there would be black bars filling up the edges of the 720-pixel-wide
  frame.

* I'm pretty sure my DVD Video camcorder only records audio in Linear
  PCM (LPCM) format, so there is no need to worry about messing with
  arcane audio codecs.

* The video editing software included with my DVD Video camcorder
  can't handle segmented VOB files on a UDF 1.0 filesystem.  Only
  single-file VOB on a UDF 2.0 filesystem can be handled, but no
  worries, just use that Unix `cat` trick I mentioned to do the
  conversion and copy from a DVD-R disc to a DVD-RAM disc.

* Content-scrambled, copy-protected DVDs?  There are means like DeCSS
  and `libdvdcss` around that, but for the most part the commercial
  encrypted DVDs aren't considered as valuable as the non-commercial,
  unencrypted DVDs.  `libdvdcss` is preferred over DeCSS because it
  does not distribute a cracked key as part of the software source
  code.

Now you're probably wondering how to split up your VOB files into one
clip at a time.  See the next section for details on that.

----------

Unix toys for working with DVD Video.

First of all, use `cat` to merge together separate VOB files into a
single VOB file.  Yep, it's that easy.

20180916/DuckDuckGo concatenate segmented vob into single file

This software is not necessary, but represents a more marketable
method for non-technical users.

20180916/https://download.cnet.com/Join-VOB-Files-Tool/3000-13631_4-10718007.html  
20180916/https://forum.videohelp.com/threads/268058-How-to-get-a-DVD-title-into-a-single-file  

Again not necessary, but more marketable to non-technical users.

20180916/DuckDuckGo join vob files tool sourceforge  
20180916/https://sourceforge.net/projects/vobmergenet/

Now you want to be able to split DVD files by their IFO markers.
Choose from the following array of relevant software and work from
there.

Some software is only capable of working directly off of a block
device.  In that case, if you only have the direct copied files, you
can build your own UDF file system and point the software to that.  In
that case, make sure you have the UDF file system tools and drivers
installed.

20180916/DuckDuckGo split dvd vob file by ifo markers

Not useful.

20180916/http://forums.afterdawn.com/threads/how-do-i-split-a-ripped-dvd-file-into-chapters-without-converting-to-xvid-etc.682279/

Let's try getting more specific, search by tool name used by technical
users.

20180916/DuckDuckGo ffmpeg ifo split chapters  
20180916/https://stackoverflow.com/questions/30305953/is-there-an-elegant-way-to-split-a-file-by-chapter-using-ffmpeg  
20180916/http://blog.albertarmea.com/post/91024308173/losslessly-splitting-videos-by-chapter-using-bash  
20180916/https://stackoverflow.com/questions/12239235/how-to-obtain-titles-and-chapters-information-in-dvd

This is a very helpful page.

20180916/https://www.joeldare.com/wiki/video:rip_a_dvd

HandBrake is a libre video transcoder, also highly recommended.

20180916/https://handbrake.fr/  
20180916/https://github.com/HandBrake/HandBrake

Ah, yes, so here we go.  Make sure you have all of the following Unix
tools for DVDs:

* FFMPEG, ffprobe
* VLC media player
* MPlayer
* HandBrake CLI
* MKVToolNix, mkvmerge
* lsdvd
* libvlc, libdvdnav, libdvdread

FFMPEG can easily be used to losslessly split video files if you use
`-vcodec copy -acodec copy`.  Example:

    ffmpeg -i input.mpg \
      -vcodec copy -acodec copy \
      -ss $START -to $END \
      output.mpg

I think you can also just use `-c copy` instead of the separate
`-vcodec` and `-acodec` options.

What about losslessly join videos?  Oh, you can do that with the
"concat demuxer."

    $ cat mylist.txt
    file '/path/to/file1'
    file '/path/to/file2'
    file '/path/to/file3'

    $ ffmpeg -f concat -i mylist.txt -c copy output

FFMPEG actually supports three concat methods, but there are obvious
reasons why you'd want to avoid 2 out of the 3 for single-clip video
editing.

* concat filter: Use this to join together clips recorded using
  different camera parameters such as resolution, frame rate, etc.
  Requires a lossy transcode.

* concat demuxer: Use this to join clips of the same parameters.

* concat protocol: Don't use this unless you want a so-called
  "file-level concatenation" where the video stream indicates it has
  multiple separate files concatenated together.

20180916/DuckDuckGo ffmpeg lossless merge video clips  
20180916/https://stackoverflow.com/questions/7333232/how-to-concatenate-two-mp4-files-using-ffmpeg

Final challenge.  You have input video in H.264 AVC but wrapped in a
QuickTime file format container, but you want to rewrap that same
video data into an MP4 container without transcoding.  How do you do
it with FFMPEG?  Easy, again use the `-c copy` option for this.

    ffmpeg -i video.mov -c copy video.mp4
    # Use `ffprobe` to verify the output.
    ffprobe video.mov
    ffprobe video.mp4

20180916/DuckDuckGo ffmpeg h.264 convert quicktime container to mpg
container  
20180916/https://stackoverflow.com/questions/17907762/how-to-convert-re-wrap-transport-stream-to-mpeg-4-container-in-ios-app  
20180916/https://video.stackexchange.com/questions/16927/ffmpeg-how-to-convert-quicktime-iphone-video-to-mp4-format

So unfortuantely, my statement above about phone recording formats had
one catch.  Now, cameras and some phones tend to record into a
QuickTime container format, but only the MP4 container format is
supported by HTML 5 video, so you're definitely going to need to
repackage before your video can be natively viewed by browsers, unless
your device natively outputs into an MP4 container format.

Oh, and double unfortunately, I didn't make appropriate mention of the
audio codec until now.  AAC is supported "everywhere" and MP3 is
supported "almost everywhere" (Safari historically did not support
MP3, not sure of the current status).  Bottom line: I might need to
transcode audio, but that's okay because audio typically isn't highly
compressed to begin with, so transcoding losses are not as severe as
is the case with video.

Especially because the QuickTime format videos that my DSLR camera
encodes in uses Linear PCM audio, and FFMPEG won't transcode Linear
PCM audio to the MPEG-4 format.

So, let's review my updated command.

    ffmpeg -i video.mov \
      -vcodec copy -acodec aac \
      video.mp4

20180916/https://developer.mozilla.org/en-US/docs/Web/HTML/Supported_media_formats  
20180916/https://hacks.mozilla.org/2012/03/video-mobile-and-the-open-web/

Bottom line: Of course you must support MP4 video format if you are
going to only support a single video format on your server.  But if
you are willing to up the notch just a bit, then adding support for
Ogg is your very next choice, for the sake of desktop computers, even
including legacy ones.  Third and last choice is to add support for
WebM, which still works on modern desktop computers but not as well as
Ogg on legacy desktop computers.

Oh boy, but there's another thing that I really have to comment on.
Want to setup your own photo server site with minimal code?  That's
easy.  Want to setup your own video server site with minimal code?
Well, that's a lot tougher, so much that you might opt to use someone
else's video hosting services, even if they are a megalith.  The fact
of today, as of 2018, is that for many web uses, you can't author your
own website directly, but instead you must employ the product of
another web application developer that sits between your content and
the browser.

----------

Okay, now for some updates from testing.  The results?  Viewing the
videos worked out pretty, in so far that none of the devices I tested
across claimed they were completely incapable of viewing the video.
However, testing on smartphones connected through Wi-Fi, there was a
clear bandwidth gap between the high-definition video playback versus
typical video playback on the Internet.  My verdict is that most
smartphones only access standard definition video on the Internet, and
this is the expectation of a smartphone user wishing to view a video.

So, as unfortunate as this may be, if you have high-definition video
sources, you could just as well be required to transcode them to
standard definition video so that they stream well to smartphones
connected through Wi-Fi.

First of all, that is good news for all of our previously recoreded
videos from the DVD Video camcorder.  It means that all we have to do
is transcode from MPEG-2 to MPEG-4 H.264 AVC as follows:

    ffmpeg -i video.mpg \
      -vcodec libx264 -acodec aac \
      video.mp4

Set the bitrate (`-b 15m`) to something reasonably high when
transcoding, otherwise you will get an excessively compressed output
file.  I have to explore this further, however, as setting bitrate
with experimental AAC (old version of FFMPEG) results in no sound.
Maybe just an upgrade is needed?

For transcoding to only a specific target resolution, i.e. "YouTube"
standard definition, augment the command line as follows:

    ffmpeg -i video.mpg \
      -vcodec libx264 -acodec aac -s 640x480 \
      video.mp4

If you're using 16:9 widescreen, make sure you transcode to 848x480 or
854x480 (YouTube prefers the non-mod-16 version):

    ffmpeg -i video.mpg \
      -vcodec libx264 -acodec aac -s 854x480 \
      video.mp4

Finally, now for some YouTube recommendations.

20180918/https://support.google.com/youtube/answer/1722171?hl=en  
20180918/https://support.google.com/youtube/answer/4603579?hl=en  
20180918/https://www.winxdvd.com/resource/best-youtube-size-for-uploading.htm  
20180918/https://en.wikipedia.org/wiki/480p

Only the key recommendations pertinent to me will be highlighted here,
see the YouTube page for full information.

* YouTube recommends using progressive scan video only, so if you have
  interlaced video content, you should deinterlace it.

* Also, YouTube only uses 16:9 widescreen aspect ratio video players,
  so you should record all your video in 16:9 resolution if you are
  producing new video.

* YouTube requires a minimum of 1920x1080 resolution, 16:9 widescreen
  for paid content.

* So, now for info on pixel resolutions.  Keeping in mind the
  requirements for progressive scan and 16:9 widescreen, the
  supported/recommended resolutions are as follows: 2160p, 1440p,
  1080p, 720p, 480p, 360p.  I've practically never heard of 360p
  before, so you probably want to avoid it.

4K video?  Oh, you have a curve ball here!  At this point we drop out
of the H.264 monopoly and enter the new world of VP9, contained by
WebM.  H.265 HEVC has not been adopted by the web at large, thus
pointing to the end of the MPEG LA monopoly.  However, despite
Google's enthusiasm for promoting a long-awaited open video format,
hardware support for decoding VP9 is still lacking, though definitely
growing in newer devices.  Not to mention, smartphone users really
only care for standard definition video, so requiring 4K uploads to be
in VP9 will have very little practical market impact.

Even so, Google isn't going to transcode their whole library of H.264
videos to WebM VP9 any time soon.  Not until transcoding your personal
library of videos at home becomes so fast and so easy will Google
YouTube embark on such an effort.

20180918/https://en.wikipedia.org/wiki/VP9  
20180918/https://en.wikipedia.org/wiki/HTML5_video#Browser_support

Relating to H.264 patents.  The H.264 standard, as far as modern HTML
5 video is concerned, was completed in 2003.  Assuming all claimed
patents were issued at earlier dates, this means that no H.264 patents
will last past the year 2023.  That's 5 years away from today, 2018.
Yeah, still a long ways away, but significantly less than a "lifetime"
(20 years).

Note that there are some H.264 extensions that were defined later, but
none of them are used in mass market Internet video streaming.

20180918/https://en.wikipedia.org/wiki/H.264/MPEG-4_AVC
