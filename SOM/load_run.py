
from ctypes import cdll

radx_lib = cdll.LoadLibrary("radxops.so")
#radx_lib = cdll.LoadLibrary("hello.so")
echo = radx_lib.main

print echo("one")
