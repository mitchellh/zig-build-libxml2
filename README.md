# libxml2 built with Zig

This project builds [libxml2](https://github.com/GNOME/libxml2.git)
with Zig. These are _not Zig language bindings_ to the project. The goal of
this project is to enable the upstream project to be used with the Zig
package manager. Downstream users may also not be Zig language users, they
may just be using Zig as a build system.

Upstream sources are fetched from a release tarball using the Zig package
manager.

## Usage

Create a `build.zig.zon` like so:

```zig
.{
    .name = "my-project",
    .version = "0.0.0",
    .dependencies = .{
        .libxml2 = .{
            .url = "https://github.com/mitchellh/zig-build-libxml2/archive/<git-ref-here>.tar.gz",
            // Add the hash field here using the output from invoking zig build for the first time
        },
    },
}
```

And in your `build.zig`:

```zig
const libxml2 = b.dependency("libxml2", .{ .target = target, .optimize = optimize });
exe.linkLibrary(libxml2.artifact("xml2"));
```

In your code you can now `@cImport` the project.

## Versions

This project makes no guarantee to stay up to date with every released
version of the upstream project. If you'd like to contribute a new version,
please do and we will tag it accordingly.

The current version (and the upstream distribution tarball which is fetched) is
recorded in `build.zig.zon`.
