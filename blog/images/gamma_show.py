#! /usr/bin/env python
# Plot a gamma curve with matplotlib.

import sys
from optparse import OptionParser

import matplotlib
import matplotlib.pyplot as plt

opt_parser = OptionParser()
opt_parser.add_option('-f', '--plot-fmt', dest='plot_fmt', default='-',
                      help='Matplotlib format string to use for plots '
                      "(i.e. '.', 'o', '-')")
opt_parser.add_option('-c', '--cgi-stdout', dest='cgi_stdout',
                      action='store_true',
                      help='Output as CGI PNG on standard output')
opt_parser.add_option('-o', '--output-file', dest='output_file', default='',
                      help='File name to write image to')
opt_parser.add_option('-t', '--output-type', dest='output_type', default='svg',
                      help='Output format to use (svg, png)')

(options, args) = opt_parser.parse_args()
fmt_str = options.plot_fmt
cgi_stdout = options.cgi_stdout
output_file = options.output_file
output_type = options.output_type

myplot = [[], []]

i = 0
while i <= 128:
    myin = float(i) / 128
    myout = myin ** 2.2
    myplot[0].append(myin)
    myplot[1].append(myout)
    i += 1

plt.plot(myplot[0], myplot[1], fmt_str)
plt.title('Meals versus dish washing')

# rule = matplotlib.dates.rrulewrapper(matplotlib.dates.DAILY)
# plt.xaxis.set_major_locator(loc)

plt.axis([0.0, 1.0, 0.0, 1.0])

if cgi_stdout:
    if output_type == 'png':
        print 'Content-Type: image/png'
    elif output_type == 'svg':
        print 'Content-Type: image/svg+xml'
    print ''
    # plt.savefig(sys.stdout.buffer)
    plt.savefig(sys.stdout, format=output_type)
elif output_file:
    plt.savefig(output_file, format=output_type)
else:
    plt.show()
