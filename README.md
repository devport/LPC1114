# LPC1114
LPC11114 in FreePascal

Binutils:
Download http://ftp.gnu.org/gnu/binutils/binutils-2.20.tar.bz2
Unzip in binutils-2.20
Create a directory binutils-arm
From binutils-arm run: ../binutils-2.20/configure --target=arm-elf --disable-nls --prefix=directory_where_you_want_binutils_installed
Build using: make all install

or download binary for windows:
https://svn.freepascal.org/svn/fpcbuild/binaries/i386-win32/

FPC:
1.Requires trunk version of FPC
2.Get source FPC
3.Copy lpc11xx.pp to fpc_src\rtl\embedded\arm
4.Go to fpc_src directory and Build using: 

PATH=C:\fpc\3.0.4\bin\i386-win32;C:\cross
make clean buildbase installbase CROSSINSTALL=1 OS_TARGET=embedded CPU_TARGET=arm SUBARCH=armv6m

C:\fpc\3.0.4\bin\i386-win32 << directory FPC
C:\cross  << binary files fpcBuild (arm-embedded-as, arm-embedded-ld, etc.)

5. Copy fpc_src\compiler\ppcrossarm.exe to fpc\3.0.4\bin\i386-win32
6. Copy directory fpc_src\rtl\units\arm-embedded to fpc\3.0.4\units

Compile projects using:

ppcrossarm  -Fu..\units -Sc -O1 -Cparmv6m -Parm -Tembedded -Wplpc1114FBD48_303 project.pas

