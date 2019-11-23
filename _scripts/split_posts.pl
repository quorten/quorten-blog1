#! /usr/bin/env perl
# Split apart a text archive of Jekyll blog posts into individual
# files.  Reads from standard input.

# Every post file must have a "codename" field that specifies the
# filename "title" part to use.  A "date" field is likewise required.

use warnings;
use strict;

my $POST_DIVIDER = ('-' x 40) . "\n";

# Note: We keep track of line numbers for the sake of printing error
# messages.  As it turns out, Perl prints the line numbers for us when
# we use `warn', but if we convert this script to C, not so much.

# Why C?  Sure, for one-time conversions after a manual article
# type-up, Perl is fast enough, even on a Raspberry Pi.  But, for an
# alternative workflow that puts this in the middle of a repeated
# build from source process... not so much.
my $linenum = 1;
my $out;
my @linebuf = ();
my $post_start = 1;
my $in_preamble = 0;
my $codename = "";
my $date = "";
my $article_error = 0;

my $total_posts = 1;
my $cvted_posts = 0;

while (<>) {
    if ($_ eq $POST_DIVIDER) {
        # Post divider matched.
	if ($post_start) {
	    warn "$linenum: Missing preamble.";
	}
        $post_start = 1;
        $codename = "";
        $date = "";
	$article_error = 0;
	$total_posts++;
	if ($out) {
	    # Flush the line buffer, except for a trailing blank line.
	    pop @linebuf if ($linebuf[$#linebuf] eq "\n");
	    while (@linebuf) {
		print $out shift(@linebuf);
	    }
	    close $out or die "$out: $!";
	    $out = undef;
	}
    } elsif ($post_start and !$article_error and $_ eq "---\n") {
        # Preamble start/end matched.
        if ($in_preamble) {
            if ($date eq "" or $codename eq "") {
                warn "$linenum: Missing preamble filename fields.";
		# Clear line buffer leave `post_start' set, set
		# `article_error', and let `in_preamble' reset to
		# zero.  This will simply ignore all lines with
		# minimal processing until we reach the next article
		# divider.
		@linebuf = ();
		$article_error = 1;
            } else {
		$cvted_posts++;
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
        }
        $in_preamble = !$in_preamble;
	if (!$article_error) {
	    push(@linebuf, $_);
	}
    } elsif ($in_preamble) {
        if ($_ =~ /^codename: ([^\n]+)\n$/) {
            $codename = $1;
            # Note that we do not propagate the "codename" field into
            # the separated blog post file.
        } elsif ($_ =~ /^date: ([^\s]+)/) {
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

# Output statistics.
my $cvt_percent = $cvted_posts / $total_posts * 100;
my $cvt_per_str = sprintf('%.2f', $cvt_percent);
warn "$cvted_posts/$total_posts = $cvt_per_str% converted"
