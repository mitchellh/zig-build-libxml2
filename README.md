# libxml2 built with Zig

This project builds [libxml2](https://github.com/GNOME/libxml2.git)
with Zig. These are _not Zig language bindings_ to the project. The goal of
this project is to enable the upstream project to be used with the Zig
package manager. Downstream users may also not be Zig language users, they
may just be using Zig as a build system.

This is not strictly a fork (the source for the upstream project is copied
into the "upstream" directory unmodified unless noted). For security reasons,
you can verify the contents using the `verify.sh` script. Please read the
shell script contents, it is written in a plain way.

I implore that you do not blindly trust me -- pin this repository to a
specific version and verify the checksums match yourself.

## Usage

Create a `build.zig.zon` like so:

```zig
.{
    .name = "my-project",
    .version = "0.0.0",
    .dependencies = .{
        .libxml2 = .{
            .url = "https://github.com/mitchellh/zig-build-libxml2/archive/<git-ref-here>.tar.gz",
            .hash = "12208070233b17de6be05e32af096a6760682b48598323234824def41789e993432c",
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

**The current version is always available in `upstream.txt`.** This is
the Git commit hash of the "upstream" folder.

### Updating

You can update to any arbitrary upstream Git ref using `update.sh`:

```
$ ./update.sh HEAD
```

### Verify

You can verify that the contents match upstream by running `verify.sh`:

```
$ ./verify.sh
```

An exit status of 0 means it was successful.
