---
# You can also start simply with 'default'
theme: default
title: First Nix Meetup!
class: text-center
drawings:
  persist: false
transition: fade
mdc: true
canvasWidth: 800
---

![](https://zurich.nix.ug/assets/nix-zurich.svg){width=200px}

# First Nix Meetup!

Welcome!

<style>
img {
  display: block;
  margin-left: auto;
  margin-right: auto;
}
</style>

---
layout: two-cols-header
---

# Code of Conduct
- We are respectful
- We are inclusive
- We do not tolerate abusive behavior

::right::

![](https://raw.githubusercontent.com/NixOS/nixos-artwork/refs/heads/master/logo/nix-snowflake-rainbow.svg){width=150px}

::bottom::

https://github.com/NixOS/.github/blob/master/CODE_OF_CONDUCT.md


<style>
  img {
    position: absolute;
    top: 30px;
    right: 50px;
    
  }
</style>

---

# Toilets

Down the stairs on the first floor

![](/toilets.png){width=300px}

<style>
img {
  display: block;
  margin-left: auto;
  margin-right: auto;
}
</style>

---

# Door

Locked after 19:00

---
layout: two-cols-header
---

# Introduction

::left::

![](/lorenz.jpg)
## Lorenz Bischof
Peak Scale

::right::

![](/lena.webp)
## Lena Fuhrimann
bespinian

<style>
  p,h2 {
    text-align: center;
  }
  img {
    width: 170px;
    text-align: center;
    display: inline-block;
    border-radius: 50%;
    margin-bottom: -20px;
  }
</style>

---

# Software deployment

- `deployment-v3-fixed.zip`
- Dependencies specified in a README
- Build script can download random things from the internet

::v-click
![](/works.jpg){width=240px}
::

<style>
img {
  display: block;
  margin-left: auto;
  margin-right: auto;
  margin-top: 15px;
}
</style>

---

# Software deployment

- Dependencies with incorrect versions
- Dependencies with incorrect patches or build arguments
- Lets patch and compile our dependencies!

::v-click
![](/simple.jpg){width=290px}
::

<style>
img {
  display: block;
  margin-left: auto;
  margin-right: auto;
  margin-top: 30px;
}
</style>

---

# Software deployment is hard

- Forgotten dependencies
- Different applications require different versions of dependencies
- Power failure during `apt upgrade`
- Application does not work anymore after upgrade

::v-click
![](/fine.jpg){width=290px}
::

<style>
img {
  display: block;
  margin-left: auto;
  margin-right: auto;
  margin-top: 15px;
}
</style>

---

# Software deployment is hard

- **Dependencies:** hard to identify correctly, leading to incomplete deployments
- **Variability:** package names do not guarantee identical software across systems
- **Source vs binary:** separate logic for source and binary deployments
- **Atomicity:** upgrades are not atomic, creating broken intermediate states
- **Scope:** software can only be installed system-wide

---

# How Nix helps

- **Dependencies:** build in a sandbox with nothing else available
- **Variability:** multiple variants and versions at the same time
- **Source vs binary:** binary cache if available
- **Atomicity:** upgrades happen by switching a symlink
- **Scope:** software can be installed system-wide or for a single user

---

# Nix History

- Initial release was in 2003
- More than 20 years ago
- Docker was released 10 Years later in 2013 
- Nix still seems new and niche

---

# What is Nix?

## 🧙 Functional programming language
"It's just JSON with functions"

## 📦 Package manager
The largest software repository on the planet with more than 100.000 packages

## 🐧 Operating system (NixOS)

Linux distribution built around the Nix package manager

<style>
  h2 {
    font-size: 20px;
    margin-bottom: -10px;
    color: darkblue;
  }
</style>

---

# NixPkgs

![](/repology.png)

<style>
img {
display: block;
margin-left: auto;
margin-right: auto;
}
</style>

---

# NixPkgs

````md magic-move
```nix {2-6|8-14}
let
  nixpkgs = fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/bdac72d387dca7f836f6ef1fe547755fb0e9df61.tar.gz";
    sha256 = "1kyxarhs7g80ixlcddxw2fbs24zqb250hkyb8wv9xz8hs869n2si";
  };
  pkgs = import nixpkgs { };
in
{
  hello = import ./hello.nix { 
    stdenv = pkgs.stdenv; 
    fetchurl = pkgs.fetchurl; 
    ffmpeg = pkgs.ffmpeg;
  };
}
```
```nix {8-14}
let
  nixpkgs = fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/bdac72d387dca7f836f6ef1fe547755fb0e9df61.tar.gz";
    sha256 = "1kyxarhs7g80ixlcddxw2fbs24zqb250hkyb8wv9xz8hs869n2si";
  };
  pkgs = import nixpkgs { };
in
{
  hello = import ./hello.nix { 
    stdenv = pkgs.stdenv; 
    fetchurl = pkgs.fetchurl; 
    ffmpeg = pkgs.ffmpeg_6;
  };
}
```
```nix {8-16}
let
  nixpkgs = fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/bdac72d387dca7f836f6ef1fe547755fb0e9df61.tar.gz";
    sha256 = "1kyxarhs7g80ixlcddxw2fbs24zqb250hkyb8wv9xz8hs869n2si";
  };
  pkgs = import nixpkgs { };
in
{
  hello = import ./hello.nix { 
    stdenv = pkgs.stdenv; 
    fetchurl = pkgs.fetchurl; 
    ffmpeg = pkgs.ffmpeg_6.override { 
      withUnfree = true; 
    };
  };
}
```
```nix {8-14}
let
  nixpkgs = fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/bdac72d387dca7f836f6ef1fe547755fb0e9df61.tar.gz";
    sha256 = "1kyxarhs7g80ixlcddxw2fbs24zqb250hkyb8wv9xz8hs869n2si";
  };
  pkgs = import nixpkgs { };
in
{
  hello = import ./hello.nix { 
    stdenv = pkgs.stdenv; 
    fetchurl = pkgs.fetchurl; 
    ffmpeg = pkgs.ffmpeg_6.overrideAttrs (previousAttrs: {
      patches = previousAttrs.patches ++ [ ./my-patch.patch ];
    }))
  };
}
```
````

---

# Derivation

````md magic-move
```nix
{
  stdenv,
  fetchurl,
  ffmpeg,
}:

stdenv.mkDerivation {
  name = "hello-2.12.1";
  nativeBuildInputs = [ ffmpeg ];
  src = fetchurl {
    url = "mirror://gnu/hello/hello-2.12.1.tar.gz";
    hash = "sha256-jZkUKv2SV28wsM18tCqNxoCZmLxdYH2Idh9RLibH2yA=";
  };
}
```
```nix {10}
{
  stdenv,
  fetchurl,
  ffmpeg,
}:

stdenv.mkDerivation {
  name = "hello-2.12.1";
  nativeBuildInputs = [ ffmpeg ];
  installPhase = "make install";
  src = fetchurl {
    url = "mirror://gnu/hello/hello-2.12.1.tar.gz";
    hash = "sha256-jZkUKv2SV28wsM18tCqNxoCZmLxdYH2Idh9RLibH2yA=";
  };
}
```
```nix {10|4,9,10}
{
  stdenv,
  fetchurl,
  ffmpeg,
}:

stdenv.mkDerivation {
  name = "hello-2.12.1";
  nativeBuildInputs = [ ffmpeg ];
  builder = ./builder.sh;
  src = fetchurl {
    url = "mirror://gnu/hello/hello-2.12.1.tar.gz";
    hash = "sha256-jZkUKv2SV28wsM18tCqNxoCZmLxdYH2Idh9RLibH2yA=";
  };
}
```
````

---

#### `builder.sh`

````md magic-move
```bash {*|1,3}
tar xvfz $src
cd hello-*
./configure --prefix=$out
make
make install

# For demonstration purposes only
ffmpeg -version
```

```bash {1,3}
tar xvfz $src               # /nix/store/pa10z4ngm0g83kx9mssrqzz30s84vq7k-hello-2.12.1.tar.gz
cd hello-*
./configure --prefix=$out   # /nix/store/zadhh5ypxak314zk5xcbwxgx6ssg2kb6-hello-2.12.1
make
make install

# For demonstration purposes only
ffmpeg -version
```
````

---

# Building

````md magic-move
```nix {8-14}
let
  nixpkgs = fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/bdac72d387dca7f836f6ef1fe547755fb0e9df61.tar.gz";
    sha256 = "1kyxarhs7g80ixlcddxw2fbs24zqb250hkyb8wv9xz8hs869n2si";
  };
  pkgs = import nixpkgs { };
in
{
  hello = import ./hello.nix { 
    stdenv = pkgs.stdenv; 
    fetchurl = pkgs.fetchurl; 
    ffmpeg = pkgs.ffmpeg;
  };
}
```
```nix {8-10}
let
  nixpkgs = fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/bdac72d387dca7f836f6ef1fe547755fb0e9df61.tar.gz";
    sha256 = "1kyxarhs7g80ixlcddxw2fbs24zqb250hkyb8wv9xz8hs869n2si";
  };
  pkgs = import nixpkgs { };
in
{
  hello = pkgs.callPackage ./hello.nix { };
}
```
```nix {8-10}
let
  nixpkgs = fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/bdac72d387dca7f836f6ef1fe547755fb0e9df61.tar.gz";
    sha256 = "1kyxarhs7g80ixlcddxw2fbs24zqb250hkyb8wv9xz8hs869n2si";
  };
  pkgs = import nixpkgs { };
in
{
  hello = pkgs.callPackage ./hello.nix { ffmpeg = pkgs.ffmpeg_6; };
}
```
````

---

# Building

```nix {8-10}
let
  nixpkgs = fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/bdac72d387dca7f836f6ef1fe547755fb0e9df61.tar.gz";
    sha256 = "1kyxarhs7g80ixlcddxw2fbs24zqb250hkyb8wv9xz8hs869n2si";
  };
  pkgs = import nixpkgs { };
in
{
  hello = pkgs.callPackage ./hello.nix { ffmpeg = pkgs.ffmpeg_6; };
}
```

```bash
$ nix-build -A hello
```

::v-click
````md magic-move
```bash
/nix/store/zadhh5ypxak314zk5xcbwxgx6ssg2kb6-hello-2.12.1
```
```bash
nix show-derivation /nix/store/zadhh5ypxak314zk5xcbwxgx6ssg2kb6-hello-2.12.1
```
````
::

::v-click
https://github.com/NixOS/nixpkgs/blob/master/pkgs/top-level/all-packages.nix
::

---

![](/store.png){width=400px}
https://edolstra.github.io/pubs/phd-thesis.pdf

::v-click
<v-drag-arrow pos="374,362,-37,0"/>
<v-drag-arrow pos="374,218,-37,0"/>
::

::v-click
<v-drag-arrow class="text-green" pos="374,404,-37,0"/>
<v-drag-arrow class="text-green" pos="374,260,-37,0"/>
::

::v-click
<v-drag-arrow class="text-purple" pos="374,296,-37,0"/>
::

<style>
  img { 
    display: block;
    margin: -30px auto 0 auto;
  }
  a {
    float: right;
  }
</style>

---


# Developer Shells

```bash
$ ffmpeg -version
Command not found!

$ nix-shell -p ffmpeg
ffmpeg version 7.1.1 Copyright (c) 2000-2025 the FFmpeg developers

$ exit

$ ffmpeg -version
Command not found!
```

---

# Developer Shells

```nix
pkgs.mkShell {
  packages = [
    pkgs.ffmpeg
  ];

  shellHook = ''
    export DEBUG=1
  '';
}
```

```bash
nix-shell
```

---

# Developer Shells

```nix
{ pkgs, ... }: {
  packages = [
    pkgs.ffmpeg
  ];
  languages.rust.enable = true;
  services.postgres.enable = true;
}

```

```bash
devenv shell
```

https://devenv.sh

---

# NixOS

- Declarative
- Build in CICD
- Artifacts are pushed to Cache
- GitOps for your laptop
- Atomic upgrades
- Rollbacks

---

![](/docker.png)

<style>
  img { 
    width: 325px;
    margin-right: auto;
    margin-left: auto;
    margin-top: -50px;
  }
</style>

---

# Sponsoring and Locations

TODO

---

# Speakers

TODO
