{pkgs}:

with pkgs;
with import <nixos> {};

let

  version = "1.28.2";
  hie = (import ./hie.nix { inherit pkgs; });
  apps = with haskellPackages; with pythonPackages; with latest; [
        binutils.bintools
        cabal-install
        cabal2nix
        gcc
        rustChannels.nightly.rust
        ghc
        alsa-core
        gnumake
        hdevtools
        hie
        hoogle
        ipython
        perl
        stack
  ];
  plat = "linux-x64";
  channel = "stable";
  archive_fmt = if stdenv.system == "x86_64-darwin" then "zip" else "tar.gz";

in

  vscode.overrideDerivation (old: {
    name = "vscode-${version}";
    src = fetchurl {
      name = "VSCode_${version}_${plat}.${archive_fmt}";
      url = "https://vscode-update.azurewebsites.net/${version}/${plat}/${channel}";
      sha256 = "1z50hkr9mcf76hlr1jb80nbvpxbpm2bh0l63yh9yqpalmz66xbfy";
    };
    postFixup = old.postFixup + ''
      wrapProgram $out/bin/code --prefix PATH : ${lib.makeBinPath apps}
    '';
  })
