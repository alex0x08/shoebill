#!/usr/local/bin/bash

CC=gcc13

files=""
for i in adb fpu mc68851 mem via floppy core_api cpu dis; do
	perl ../core/macro.pl ../core/$i.c $i.post.c
	files="$files $i.post.c"
done

for i in SoftFloat/softfloat atrap_tab coff exception macii_symbols redblack scsi video filesystem alloc_pool toby_frame_buffer ethernet sound; do
	files="$files ../core/$i.c"
done

$CC -O1 ../core/decoder_gen.c -o decoder_gen
./decoder_gen inst .
./decoder_gen dis .


cmd="$CC -O3 -ggdb -flto $files sdl.c -lpthread -lm -lSDL2 -lGL -o shoebill"
echo $cmd
$cmd
