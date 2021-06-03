# Getting Started with Rust+Ferrite+Nix

[![License: Unlicense](https://img.shields.io/badge/license-Unlicense-blue.svg)](http://unlicense.org)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A basic project template for [rust+ferrite](https://github.com/ferrite-rs/ferrite) development using the [nix package manager](https://nixos.org/). The Rust toolchain and all dependencies are pinned to fixed versions for reproducibility. Supports both building as a nix derivation and normal dev shell hacking.

As of the time of writing, the Rust toolchain provided is the latest stable version: **1.52.1**.

## Who is this for?

Best fit: Current nix users of any skill level with little to no Rust experience.

Poor fit: Fluent Rust users already comfortable with an existing workflow and not familiar with nix. You might learn something here but are probably better off sticking to [familar tools](https://rustup.rs/) and focusing your energy on learning strange new theory.

## Getting Started: Zero to Hello World in three commands

Prerequisite: A working nix installation. No Rust preparation needed.

```console
$ git clone https://github.com/miangraham/rust-ferrite-nix-starter
Cloning into 'rust-ferrite-nix-starter'...
...
Receiving objects: 100% (16/16), 29.45 KiB | 90.00 KiB/s, done.

$ cd rust-ferrite-nix-starter

$ nix-shell --run 'cargo run'
... Expect several minutes of package installation ...
    Finished dev [unoptimized + debuginfo] target(s) in 10.33s
     Running `target/debug/rust-ferrite-nix-starter`
 INFO  rust_ferrite_nix_starter > Hello ferrite!
```

## Template summary: Tools used

- [niv](https://github.com/nmattia/niv): Pins nix package versions to fixed hashes for reproducibility.
- [oxalica/rust-overlay](https://github.com/oxalica/rust-overlay): Allows flexible selection of Rust toolchain version.
- [crate2nix](https://github.com/kolloch/crate2nix): Builds the project as a nix derivation so you can use it from other nix-side packages.

## Using the rust dev toolchain

To use cargo, rustc, and friends, enter the shell defined in `shell.nix`.

```console
$ nix-shell   # See also direnv and lorri

$ cargo build
...
    Finished dev [unoptimized + debuginfo] target(s) in 10.29s
    
$ cargo run
    Finished dev [unoptimized + debuginfo] target(s) in 0.02s
     Running `target/debug/rust-ferrite-nix-starter`
 INFO  rust_ferrite_nix_starter > Hello ferrite! 
 
$ rustc --version
rustc 1.52.1 (9bc8c42bb 2021-05-09)
$ cargo --version
cargo 1.52.0 (69767412a 2021-04-21)
$ cargo-clippy --version
clippy 0.1.52 (9bc8c42 2021-05-09)
$ rustfmt --version
rustfmt 1.4.36-stable (7de6968 2021-02-07)
$ rust-analyzer --version
rust-analyzer 2021-05-31
```

## Building as nix derivation

*Note: If you're just doing exercises and building one-off executables you may never need this.*

To get your build output back into nix land, just use the `default.nix` derivation as normal.

```console
$ nix-build
these derivations will be built:
  /nix/store/q44z1f9ricyy6f6asrwjzrf155b8zx96-libc-0.2.96.tar.gz.drv
  /nix/store/2xc9xnwp3pwig797w88d3y29kl0qvg68-rust_libc-0.2.96.drv
...  
/nix/store/zcbl9bv326dqsv4m10rw2mf4hqbvs6dx-rust_rust-ferrite-nix-starter-0.1.0

$ ./result/bin/rust-ferrite-nix-starter
 INFO  rust_ferrite_nix_starter > Hello ferrite!
```

If you have changed any crate dependencies in `Cargo.toml`, before running `nix-build` you'll need to update `Cargo.lock` and `Cargo.nix`:

```console
$ nix-shell
$ cargo build
...
$ crate2nix generate
Generated ./Cargo.nix successfully.
```

## Version updates

### Crate versions

1. Edit `Cargo.toml` or use `cargo upgrade` to do the same.
1. Run `cargo build` to update `Cargo.lock`. For dev builds and CLI testing you can stop here.
1. Run `crate2nix generate` to update `Cargo.nix`. Only needed for nix derivation updates.

### Rust toolchain

The Rust version is set by the [oxalica-overlay](https://github.com/oxalica/rust-overlay) to the number specified in [overlays.nix](./nix/overlays.nix). To select something more recent:

1. Update the pinned nixpkgs and overlay versions by running `niv update`.
1. Modify [overlays.nix](./nix/overlays.nix) to set your desired to channel to e.g. `let channel = super.rust-bin.stable."1.52.1".default`.
1. Re-enter `nix-shell` and rebuild everything. (If using direnv you might need to `touch shell.nix` to get it to pick up changes.)

## License

Dual-licensed under the [Unlicense](http://unlicense.org) or [MIT License](https://opensource.org/licenses/MIT) per your preference and jurisdiction.

It's sample code. Do what you want with it.
