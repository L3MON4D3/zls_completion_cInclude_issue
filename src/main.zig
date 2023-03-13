const c = @cImport({
    @cInclude("helpers.h");
});

pub fn main() !void {
    var t: c_int = c.tst();
    _ = t;
}
