
const std = @import("std");
const print = std.debug.print;
const c = @cImport({
    @cInclude("c_example.h");
});

pub fn main() void {
    print("Hello from Zig!\n", .{});
}

test "assertion" {
    try std.testing.expectEqual(5, 2 + 3);
}

test "binarysearch" {
    var array = [_]c_int{1, 3, 5, 7, 9, 11, 13, 15, 17, 19};
    const target = 7;
    const expectedIndex: c_int = 3;

    const index = c.binarySearch(&array[0], array.len, target);
    if (index == -1) {
        return error.BinarySearchFailed;
    }
    try std.testing.expectEqual(expectedIndex, index);

    const notFoundTarget = 6;
    const expectedNotFoundIndex: c_int = -1;

    const notFoundIndex = c.binarySearch(&array[0], array.len, notFoundTarget);
    if (notFoundIndex != -1) {
        return error.BinarySearchFailed;
    }
    try std.testing.expectEqual(expectedNotFoundIndex, notFoundIndex);
}

