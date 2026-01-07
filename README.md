# Plan 9 from User Space ports of Plan 9 programs

[![check_then_build](https://github.com/theobori/9ports/actions/workflows/check_then_build.yml/badge.svg)](https://github.com/theobori/9ports/actions/workflows/check_then_build.yml)

[![built with nix](https://builtwithnix.org/badge.svg)](https://builtwithnix.org)

This GitHub repository is a KISS project which contains program ports [Plan 9](https://9p.io/plan9/) and [9front](https://git.9front.org/plan9front/9front/HEAD/info.html) for [Plan 9 from User Space (plan9port)](https://github.com/9fans/plan9port). Most are graphics applications and games.

## Getting started

To build the project you need GNU Make, [Plan 9 from User Space](https://github.com/9fans/plan9port) and its dependencies for building programs (compiler, linker, etc.). Then you can run the following command line.

```bash
export PREFIX=/usr
make && make install # Build and install every project
```

## Lifecycle management

Each ported program is treated as a project in its own right, with a dedicated folder at the project root, containing the source files, an mkfile with the `all`,`clean`,`install` and `nuke` targets, and a Makefile that serves as the interface to the mkfile. The design of the ported projects, their folders and files is such that the lifecycle of each of them is as independent as possible.

The `PREFIX` environment variable is at the heart of ported program lifecycle management. Its value defines the prefix of their installation path, and is used by mkfiles, while Makefiles provide a default value.

The `PREFIX` value SHOULD be the same for all targets.

### Root mkfile and Makefile

The mkfile and Makefile at the root of the project enable all projects to be managed together. So, for example, the command line below will build and install projects in the `/tmp` folder.

```bash
export PREFIX=/tmp
make clean && make install
```

Without make, with mk.

```bash
export PREFIX=/tmp
9 mk clean && 9 mk install
```

Then you can, for example, launch a catclock with the following command line.

```bash
9 /tmp/bin/catclock
```

## Source code

The code for ported projects was retrieved from [https://9p.io/sources/plan9](https://9p.io/sources/plan9) and [9front](https://git.9front.org/plan9front/9front/30d6e6879e9acff30267a146ecb956ac470a38db/files.html) for projects that do not exist in [Plan 9](https://9p.io/plan9/).

### Modifying

To enable projects to be built, installed and run, modifications have been made to the source code.

All these changes are documented in files modified according to the following model.

```text
Port comment

<Description line 1>
...
<Description line n>
```

For a C file, it migth look like this.

```C
// Port comment
// 
// <Description line 1>
// ...
// <Description line n>
```

## Compatibility

Builds and installation and project execution have so far only been tested for the `x86_64-linux` platform.

Builds and installation are tested using a GitHub Action [workflow](/.github/workflows/check_then_build.yml) for `x86_64-linux`, `aarch64-linux` and `aarch64-darwin` platforms.

## Nix

A Nix Flake is provided, exposing Nix packages representing each of the ported projects and the packages named `all` and `default` enabling them to be managed together.

For example, you can launch a catclock with the following command line.

```bash
nix run github:theobori/9ports#catclock
```

## Contribute

If you want to help the project, you can follow the guidelines in [CONTRIBUTING.md](./CONTRIBUTING.md).
