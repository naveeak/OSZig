# OSZig
OS in thousand lines

Ref : https://operating-system-in-1000-lines.vercel.app/en/
Ref Zig: https://www.youtube.com/watch?v=eAM9ol7W2w8&list=WL&index=1

##Run help:
cd ${baseDir}
zig build run

##Completion Indicator:
https://operating-system-in-1000-lines.vercel.app/en/
https://operating-system-in-1000-lines.vercel.app/en/01-setting-up-development-environment
https://operating-system-in-1000-lines.vercel.app/en/02-assembly
https://operating-system-in-1000-lines.vercel.app/en/03-overview
https://operating-system-in-1000-lines.vercel.app/en/04-boot

##Helper command:
llvm-objdump -d zig-out/bin/kernel.elf | less
llvm-nm ig-out/bin/kernel.elf


##Notes
80200000 <boot>:
80200000: 37 05 22 80   lui     a0, 0x80220
80200004: 13 05 45 04   addi    a0, a0, 0x44
80200008: 2a 81         mv      sp, a0
8020000a: 6f 00 40 00   j       0x8020000e <kernel_main>

8020000e <kernel_main>:
8020000e: 41 11         addi    sp, sp, -0x10
80200010: 06 c6         sw      ra, 0xc(sp)
80200012: 37 05 20 80   lui     a0, 0x80200
80200016: 13 05 45 04   addi    a0, a0, 0x44
8020001a: b7 05 20 80   lui     a1, 0x80200
8020001e: 13 86 45 04   addi    a2, a1, 0x44
80200022: 09 8e         sub     a2, a2, a0
80200024: 81 45         li      a1, 0x0
80200026: 97 00 00 00   auipc   ra, 0x0
8020002a: e7 80 a0 00   jalr    0xa(ra) <memset>
8020002e: 01 a0         j       0x8020002e <kernel_main+0x20>

80200030 <memset>:
80200030: 01 ca         beqz    a2, 0x80200040 <memset+0x10>
80200032: 2a 96         add     a2, a2, a0

ashok@ashok-latitudee5470:~/Documents/projects/OSZig$ llvm-nm zig-out/bin/kernel.elf
00000000 N .Lline_table_start0
00000120 N .Lline_table_start0
80200044 B __bss
80200044 B __bss_end
80220044 B __stack_top
80200000 T boot
8020000e T kernel_main
80200030 W memset
