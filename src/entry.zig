const std = @import("std");

pub fn main() !void {

    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    try stdout.print("Run `zig build test` to run the tests.\n", .{});

    try bw.flush();

}

test "assertion test" {

    try std.testing.expectEqual(2 + 3, 5, "Addition test failed");

}
