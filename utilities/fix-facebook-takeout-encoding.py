#!/usr/bin/python3
# Facebook allows users to download all their information
# However the file encoding is horryfing experience
# This takes file from facebook takeout and converts
# it to proper utf-8
# Side effect: all newlines seem to be doubled
#
# Requirements: python3-ftfy
#
# Everything is read and printed from/to stdin/stdout

import codecs
import ftfy
import sys

for line in sys.stdin:
    # A line looks like this: r"Ad\u00ac3\u00a9la"
    # The bytes are really in there like this (so '\', 'u', '0', '0', 'a', 'c', '3' etc)
    # So we first need to "unescape" the line
    unescaped = codecs.getdecoder("unicode_escape")(line)[0]
    # Now, we have line that looks like this: u"Ad\u00ac3\u00a9la"
    # So the bytes in there are actually bytes
    # Now just convert it to normal utf-8 and we're done
    fixed = ftfy.ftfy(unescaped)
    print(fixed)
