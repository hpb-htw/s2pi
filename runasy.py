#! /usr/bin/env python3

# script to call asy to make PDF file (=2 dimenensional)

import os
import sys

latex = "pdflatex"
latex_opt = "--shell-escape --synctex=1 -interaction=nonstopmode"
auxiliaries = ["aux", "out", "log", "pre", "synctex.gz"]

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

def run_latex(tex_filename:str) -> int:
    basename = tex_filename.replace(".tex", "")
    cmd = f"{latex} {latex_opt} {tex_filename}"
    return execute_cmd(cmd)

def run_asy(tex_filename:str) -> int:
    basename = tex_filename.replace(".tex", "")
    cmd = f"asy -f pdf {basename}-1.asy"
    return execute_cmd(cmd)

def run_pdfcrop(tex_filename:str) -> int:
    basename = tex_filename.replace(".tex", "")
    pdfcrop = f"pdfcrop {basename}.pdf"
    crop_ok = execute_cmd(pdfcrop)
    if crop_ok == 0:
        rename = f"mv -f {basename}-crop.pdf {basename}.pdf"
        return execute_cmd(rename)
    else:
        return crop_ok


def clean_up(tex_filename:str) -> int:
    basename = tex_filename.replace(".tex", "")
    auxiliaries_files = map(lambda a : f"{basename}-1*.{a} {basename}*.{a}", auxiliaries)
    rm_cmd = f"rm -f {basename}-*.asy {basename}-1.tex {basename}-1_*.pdf {' '.join(auxiliaries_files)}"
    return execute_cmd(rm_cmd)

def clean_target(tex_filename:str) -> int:
    basename = tex_filename.replace(".tex", "")
    cmd = f"rm -f {basename}*.pdf"
    return execute_cmd(cmd)

if __name__ == "__main__":
    tex_filename = sys.argv[1]
    run_latex(tex_filename)
    is_ok = run_asy(tex_filename)
    if is_ok == 0:
        is_ok = run_latex(tex_filename)
        if is_ok == 0:
            #is_ok = run_pdfcrop(tex_filename)
            pass
    if is_ok != 0:
        clean_target(tex_filename)
    #clean_up(tex_filename)
    sys.exit(is_ok)







