const std = @import("std");

pub fn build(b: *std.Build) void {
    // 2.
    // CFLAGS="-std=c11 -O2 -g3 -Wall -Wextra --target=riscv32 -ffreestanding -nostdlib"
    const exe = b.addExecutable(.{ .name = "kernel.elf", .root_source_file = b.path("src/kernel.zig"), .target = b.resolveTargetQuery(.{
        .cpu_arch = .riscv32,
        .os_tag = .freestanding,
        .abi = .none,
    }), .optimize = .ReleaseSmall, .strip = false });

    exe.entry = .disabled;

    exe.setLinkerScript(b.path("src/kernel.ld"));

    b.installArtifact(exe);

    // zig build run trigger this 1.
    const run_cmd = b.addSystemCommand(&.{"qemu-system-riscv32"});
    run_cmd.step.dependOn(b.getInstallStep());
    run_cmd.addArgs(&.{
        "-machine",   "virt",
        "-bios",      "default",
        "-serial",    "mon:stdio",
        "-nographic", "--no-reboot",
        "-kernel",
    });

    // add the zig executable that present in the zig cache dynamically
    // $QEMU -machine virt -bios default -nographic -serial mon:stdio --no-reboot \
    // -kernel kernel.elf
    // this triggers the exe build defined earlier 2.
    run_cmd.addArtifactArg(exe);


    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
