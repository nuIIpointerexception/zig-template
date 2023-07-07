const std = @import("std");

pub fn build(b: *std.build.Builder) void {

    const src = "src/";
    const c = [_][]const u8{
        "-std=c99",
        "-Wpedantic",
        "-Wall",
        "-Wextra",
        "-Wshadow",
    };

    const target = b.standardTargetOptions(.{});

    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "hello-world",
        .root_source_file = .{ .path = "src/entry.zig" },
        .optimize = optimize,
        .target = target,
    });

    exe.addCSourceFiles(&.{
        src ++ "c_example.c",
    }, &c);
    exe.linkSystemLibrary("c");
    exe.addIncludePath("src");

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);

    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "run the program.");
    run_step.dependOn(&run_cmd.step);

    const exe_tests = b.addTest(.{
        .root_source_file = .{ .path = "src/entry.zig" },
        .target = target,
        .optimize = optimize,
    });

    exe_tests.addCSourceFiles(&.{
        src ++ "c_example.c",
    }, &c);
    exe_tests.linkSystemLibrary("c");
    exe_tests.addIncludePath("src");


    const run_exe_tests = b.addRunArtifact(exe_tests);

    const test_step = b.step("test", "run the tests.");
    test_step.dependOn(&run_exe_tests.step);
}
