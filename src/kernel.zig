const bss = @extern( [*]u8,.{.name = "__bss"});
const bss_end = @extern( [*]u8,.{.name = "__bss_end"});
const stack_top = @extern( [*]u8,.{.name = "__stack_top"});



export fn kernel_main() noreturn{
    const bss_len = @intFromPtr(bss_end) - @intFromPtr(bss);
    @memset(bss[0..bss_len], 0);

    while(true) asm volatile ("");
}

export fn boot() linksection(".text.boot") callconv(.Naked) void {
    _ = asm volatile(
        \\mv sp, %[stack_top]
        \\j kernel_main
    :
    : [stack_top] "r" (stack_top),
    );
}

