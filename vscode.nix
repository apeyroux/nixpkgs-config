{pkgs}:

with pkgs;

let

  version = "1.25.1";
  hie = (import ./hie.nix { inherit pkgs; });
  apps = with haskellPackages; with pythonPackages; [
        binutils.bintools
        cabal-install
        cabal2nix
        gcc
        ghc
        cabal-helper
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
      sha256 = "0f1lpwyxfchmbymzzxv97w9cy1z5pdljhwm49mc5v84aygmvnmjq";
    };
    postFixup = old.postFixup + ''
      wrapProgram $out/bin/code --prefix PATH : ${lib.makeBinPath apps}
    '';
  })
