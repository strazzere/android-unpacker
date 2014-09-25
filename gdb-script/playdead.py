#!/usr/bin/python3

import argparse
import subprocess

DEBUG = 0
ODEX_MAGIC='dey\\n036'

def get_memory_address(pid, clone, pkg) :
    cmd = '''adb shell su -c "cat /proc/%s/maps"''' % pid
    if DEBUG :
        print(cmd)

    popen = subprocess.Popen(cmd, stdout=subprocess.PIPE, universal_newlines=True, shell=True)
    addr_list=[]
    for line in popen.stdout :
        if DEBUG :
            print(line.replace('\n', ''))
        if "/" in line :
            continue

        mem_line = line.replace('\n', '').replace('\r', '')[0:17]
        mem_start = mem_line[0:8]

        if DEBUG :
            print(mem_line)
            print(mem_start)

        peeked = peek_memory(clone, mem_start)
        if "dey"in peeked :
            if DEBUG :
                print("-"*20, peeked, "-"*20)
            return mem_line
    return None


def peek_memory(clone, mem_start) :
    cmd = '''adb shell su -c "/data/local/tmp/gdb --batch --pid %s -ex 'x/s 0x%s'" | cut -d'"' -f2 | cut -c1-8 | tail -1''' % (clone, mem_start)
    output = subprocess.check_output(cmd, stderr=subprocess.PIPE, universal_newlines=True, shell=True).replace('\n', '').replace('\r', '')
    return output


def dump_memory(clone, mem_addr) :
    mem_start = mem_addr[0:8]
    mem_end = mem_addr[9:17]
    info = "Got clone %s attempting to dump memory from 0x%sto 0x%s" % (clone, mem_start, mem_end)
    print(info)
    cmd='''adb shell su -c "/data/local/tmp/gdb --batch --pid %s -ex 'dump memory /data/local/tmp/dump.odex 0x%s 0x%s'"''' % (clone, mem_start, mem_end)
    if DEBUG :
        print(cmd)
    subprocess.call(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)


def main(pkg) :

    print("Package Name : ", pkg)

    cmd = "adb shell ps | grep %s | head -1 | tr -s ' ' | cut -d ' ' -f 2" % pkg
    if DEBUG :
        print(cmd)
    pid = subprocess.check_output(cmd, universal_newlines=True, shell=True).replace('\n', '').replace('\r', '')
    if pid is "" :
        print("Unable to find pid")
        return
    print("PID : ", pid)

    cmd = "adb shell ls /proc/%s/task/ | tail -1" % pid.replace('\n', '')
    if DEBUG :
        print(cmd)
    clone = subprocess.check_output(cmd, universal_newlines=True, shell=True).replace('\n', '').replace('\r', '')
    print("CLONE : ", clone)

    mem_addr = get_memory_address(pid, clone, pkg)
    print("ODEX MEMORY ADDRESS : ", mem_addr)
    if mem_addr :
        dump_memory(clone, mem_addr)
        print("Pulling dumped file...")
        cmd = "adb pull /data/local/tmp/dump.odex"
        subprocess.call(cmd, shell=True)
        cmd = "adb shell rm /data/local/tmp/dump.odex"
        subprocess.call(cmd, shell=True)
        print("Deodexing...")
        cmd = "baksmali -x dump.odex -d ~/Applications/framework/ -o temp-smali"
        subprocess.call(cmd, shell=True)
        print("Re-dexing...")
        cmd = "smali temp-smali -o debangcled.dex"
        subprocess.call(cmd, shell=True)
        cmd = "d2j-dex2jar.sh debangcled.dex"
        subprocess.call(cmd, shell=True)
        print("Cleaning up...")
        subprocess.call("rm -rf temp-smali/ dump.odex", stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)

    cmd = '''adb shell su -c "kill -9 %s"''' % pid
    subprocess.call(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)

if __name__ == '__main__' :
    parser = argparse.ArgumentParser("playdead.py")
    parser.add_argument("pkg", help="package name")
    args = parser.parse_args()
    main(args.pkg)
