#! /usr/bin/env perl
# Split apart a text archive of Jekyll blog posts into individual
# files.  Reads from standard input.

# Every post file must have a "codename" field that specifies the
# filename "title" part to use.  A "date" field is likewise required.

use warnings;
use strict;

my $POST_DIVIDER = ('-' x 40) . "\n";

my $linenum = 1;
my $out;
my @linebuf = ();
my $post_start = 1;
my $in_preamble = 0;
my $codename = "";
my $date = "";

while (<>) {
    if ($_ eq $POST_DIVIDER) {
        # Post divider matched.
        $post_start = 1;
        $codename = "";
        $date = "";
        # Flush the line buffer, except for a trailing blank line.
        pop @linebuf if ($linebuf[$#linebuf] eq "\n");
        while (@linebuf) {
            print $out shift(@linebuf);
        }
        close $out or die "$out: $!";
        $out = undef;
    } elsif ($post_start and $_ eq "---\n") {
        # Preamble start/end matched.
        if ($in_preamble) {
            if ($date eq "" or $codename eq "") {
                die "$linenum: Missing filename fields.";
            }
            my $filename = "$date-$codename.md";
            open($out, ">", $filename) or die "$filename: $!";
            # Flush the line buffer, except for a leading blank line.
            my $leading = shift(@linebuf);
            print $out $leading if ($leading ne "\n");
            while (@linebuf) {
                print $out shift(@linebuf);
            }
            $post_start = 0;
        }
        $in_preamble = !$in_preamble;
        push(@linebuf, $_);
    } elsif ($in_preamble) {
        if ($_ =~ /^codename: ([^\n]+)\n$/) {
            $codename = $1;
            # Note that we do not propagate the "codename" field into
            # the separated blog post file.
        } elsif ($_ =~ /^date: ([^ ]+)/) {
            $date = $1;
            push(@linebuf, $_);
        } else {
            push(@linebuf, $_);
        }
    } elsif (!$post_start) {
        # Article body text.
        # Buffer up one line so we can look ahead two lines for an
        # article divider.
        push(@linebuf, $_);
        print $out shift(@linebuf) if (@linebuf > 1);
    }
    $linenum += 1;
}

# Flush the line buffer, if applicable.
if ($out) {
    while (@linebuf) {
        print $out shift(@linebuf);
    }
    close $out or die "$out: $!";
    $out = undef;
}
