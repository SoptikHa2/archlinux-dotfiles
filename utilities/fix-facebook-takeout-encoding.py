#!/usr/bin/python3
# Facebook allows users to download all their information
# However the file encoding is horryfing experience
# This takes file from facebook takeout and converts
# it to proper utf-8
# Requirements: python3-ftfy
#
# Everything is read and printed from/to stdin/stdout

import codecs
import ftfy
import sys


# Take string, find all unicode bytes and
# unescape them
# Example:
# Hello\tworld!\u00c3\u00a9
# Should become:
# Hello\tworld!Ã©
def unescape_bytes(text):
    newtext = text
    unicode_byte = ""
    for character in text:
        if len(unicode_byte) == 6:
            # We captured whole byte
            real_byte_value = codecs.getdecoder("unicode_escape")(unicode_byte)[0]
            newtext = newtext.replace(unicode_byte, real_byte_value)
            unicode_byte = ""
        if len(unicode_byte) == 0 and character == "\\":
            unicode_byte = "\\"
        elif ((len(unicode_byte) == 1 and character == "u") or
              (len(unicode_byte) in [2, 3] and character == "0") or
              (len(unicode_byte) > 3) and character in "abcdef1234567890"):
            unicode_byte += character

    # Do one more substitution if the last character made the byte long enough
    if len(unicode_byte) == 6:
        # We captured whole byte
        real_byte_value = codecs.getdecoder("unicode_escape")(unicode_byte)[0]
        newtext = newtext.replace(unicode_byte, real_byte_value)
        unicode_byte = ""

    return newtext



for line in sys.stdin:
    # A line looks like this: r"Ad\u00c3\u00a9la"
    # The bytes are really in there like this (so '\', 'u', '0', '0', 'c', '3' etc)
    # So we first need to "unescape" the line
    # But we want to ignore everything else, so we use custom method to do so
    unescaped = unescape_bytes(line)
    # Now, we have line that looks like this: u"Ad\u00ac3\u00a9la"
    # So the bytes in there are actually bytes
    # Now just convert it to normal utf-8 and we're done
    fixed = ftfy.fix_encoding(unescaped)
    print(fixed, end='')
