PATH=C:\fpc\3.0.4\bin\i386-win32;C:\cross
make clean buildbase installbase CROSSINSTALL=1 OS_TARGET=embedded CPU_TARGET=arm SUBARCH=armv6m
pause