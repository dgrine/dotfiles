import os
import pathlib
import subprocess
import json

def generate_compile_commands():
    cwd = os.getcwd()
    build_dir = '.ccls-cmake'
    fn = f'{build_dir}/compile_commands.json'
    print(f"Generating {fn}")
    subprocess.run(['rm', '-rf', build_dir])
    subprocess.run(['mkdir', build_dir])
    subprocess.run(['cmake', '.', f'-B{build_dir}', '-DCMAKE_BUILD_TYPE=Debug', '-DCMAKE_EXPORT_COMPILE_COMMANDS=YES'])
    subprocess.run(['rm', '-rf', 'compile_commands.json'])
    subprocess.run(['ln', '-s', fn, '.'])
    # Adjust include directories
    sysroot_dir = '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include/c++/v1'
    doctest_dir = f'{cwd}/core/test/doctest'
    doctest_h_dir = f'{cwd}/core/test/extern/doctest/doctest/'
    include_directories = [sysroot_dir, doctest_dir, doctest_h_dir]
    for include_directory in include_directories:
        with open(fn, 'r') as fin:
            obj = json.load(fin)
            for item in obj:
                cmd = item['command'].split(' ')
                cmd.insert(1, f'-I{include_directory}')
                item['command'] = ' '.join(cmd)
        assert obj is not None
        with open(fn, 'w') as fout:
            json.dump(obj, fout)

    # print(f"Generating .ccls-root")
    # lines = [f'-I{sysroot_dir}', '--sysroot', sysroot_dir]
    # with open('.ccls-root', 'w') as fout:
        # fout.write('\n'.join(lines))

if '__main__' == __name__:
    generate_compile_commands()
