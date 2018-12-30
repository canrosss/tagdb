#python
import sys
import zklib
import time
import zkconst

zk = zklib.ZKLib("192.168.1.201", 4370)
ret = zk.connect()
print "connection:", ret
