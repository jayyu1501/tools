#!/usr/bin/env python3
import os, time, shutil, sys

work_dir = os.path.abspath(sys.argv[1])
os.chdir(work_dir)
print(f'Working in {work_dir}')
for src_file_name in os.listdir(work_dir):
    if os.path.isdir(src_file_name):
        print(f'skip {src_file_name} dir')
        continue
    ftime = time.gmtime(os.path.getmtime(src_file_name))
    ctime_dir = os.path.join(work_dir, str(ftime.tm_year), '{:02d}'.format(ftime.tm_mon))
    if not os.path.isdir(ctime_dir):
        os.makedirs(ctime_dir)
    dst_path = os.path.join(ctime_dir, src_file_name)
    shutil.move(src_file_name, dst_path);
    print(f'{src_file_name} has been moved to {dst_path}')
print("All done!")