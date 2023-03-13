const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const helpers = b.addStaticLibrary(.{
        .name = "helpers",
        .root_source_file = .{ .path = "src/helpers.c" },
        .target = target,
        .optimize = optimize
    });
    helpers.addIncludePath("src");
    helpers.install();

    const exe = b.addExecutable(.{
        .name = "test",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });
    exe.linkLibrary(helpers);
    exe.addIncludePath("src");
    exe.install();

    const run_cmd = exe.run();
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
