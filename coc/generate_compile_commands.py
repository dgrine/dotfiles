import os
import pathlib
import subprocess
import json

def generate_compile_commands():
    cwd = os.getcwd()
    print(f"Generating compile_commands.json in {cwd}")
    build_dir = '.cmake-compile-commands-cache'
    fn = f'{build_dir}/compile_commands.json'
    subprocess.run(['rm', '-rf', build_dir])
    subprocess.run(['mkdir', build_dir])
    subprocess.run(['cmake', '.', f'-B{build_dir}', '-DCMAKE_BUILD_TYPE=Debug', '-DCMAKE_EXPORT_COMPILE_COMMANDS=YES'])
    subprocess.run(['rm', '-rf', 'compile_commands.json'])
    subprocess.run(['ln', '-s', fn, '.'])
    # Adjust include directory
    sysroot_dir = '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include/c++/v1'
    with open(fn, 'r') as fin:
        obj = json.load(fin)
        for item in obj:
            cmd = item['command'].split(' ')
            cmd.insert(1, f'-I{sysroot_dir}')
            item['command'] = ' '.join(cmd)
    assert obj is not None
    with open(fn, 'w') as fout:
        json.dump(obj, fout)

if '__main__' == __name__:
    generate_compile_commands()
