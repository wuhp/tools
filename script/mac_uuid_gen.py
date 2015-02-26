#!/usr/bin/env python
#  -*- mode: python; -*-

print ""
print "New UUID:"
import virtinst.util
print virtinst.util.uuidToString(virtinst.util.randomUUID())

print "New MAC:"
import virtinst.util
print virtinst.util.randomMAC()
print ""
