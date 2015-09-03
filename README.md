android-unpacker
================

Android Unpacker presented at Defcon 22: Android Hacker Protection Level 0

Contents
--------

 - AHPL0 - Android Hacker Protection Level 0 + some blackphone stuff slides
 - gdb-scripts/ - Bash script for unpacking bangcle/secshell; requires gdb/adb
 - native-unpacker/ - Unpacker for APKProtect/Bangcle/LIAPP/Qihoo Packer that runs natively, no dependency on gdb
 - hide-qemu/ - Small hacks for hiding the qemu/debuggers, specifically from APKProtect

Disclaimer
----------

This presentation and code are meant for education and research purposes only. Do as you please with it, but accept any and all responsibility for your actions. The tools were created specifically to assist in malware reversing and analysis - be careful.

License
-------

    Copyright 2014-2015 Tim 'diff' Strazzere <strazz@gmail.com>

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
