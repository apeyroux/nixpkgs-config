{pkgs}:

with pkgs;

let
  version = "1.29.1";
  apps = with haskellPackages; with python3Packages; [
        (import ./hie.nix { inherit pkgs; })
        (import <nixos> {}).rustChannels.stable.rust
        (python3.withPackages(py3: with py3; [pylint pip]))
        alsa-core
        binutils.bintools
        cabal-install
        cabal2nix
        gcc
        haskell.compiler.ghc844
        gnumake
        hdevtools
        hoogle
        hpack
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
      sha256 = "1r66mjz4lgv3dk0rjb9p27ha9y7vj7xld9x9gqnjxqx9ify71r9i";
    };
    postFixup = old.postFixup + ''
      wrapProgram $out/bin/code --prefix PATH : ${lib.makeBinPath apps}
    '';
  })
