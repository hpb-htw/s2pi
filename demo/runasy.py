#! /usr/bin/env python3

# script to call asy to make PDF file (=2 dimenensional)

import os
import sys


auxiliaries = ["ps"]

class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

def execute_cmd(cmd:str) -> int:
    print(f"{bcolors.HEADER}Execute {bcolors.BOLD}{cmd}{bcolors.ENDC}")
    is_ok = os.system(cmd)
    if is_ok != 0:
        print(f"{bcolors.FAIL}   Fail {bcolors.BOLD}{cmd}{bcolors.ENDC}")
    return is_ok

def run_asy(filename:str) -> int:    
    cmd = f"asy -f pdf {filename}"
    return execute_cmd(cmd)

def clean_up(filename:str) -> int:
    basename = filename.replace(".asy", "")
    auxiliaries_files = map(lambda a : f"{basename}-1*.{a} {basename}*.{a}", auxiliaries)    
    rm_cmd = f"rm -f {basename}__.ps {' '.join(auxiliaries_files)}"
    return execute_cmd(rm_cmd)

def clean_target(filename:str) -> int:
    basename = filename.replace(".asy", "")
    cmd = f"rm -f {basename}*.pdf"
    return execute_cmd(cmd)

if __name__ == "__main__":
    filename = sys.argv[1]    
    is_ok = run_asy(filename)
    
    if is_ok != 0:
        clean_target(filename)
    clean_up(filename)
    sys.exit(is_ok)







