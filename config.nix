with import <nixpkgs> {};

let
  hie = (import (fetchFromGitHub {
                   owner="domenkozar";
                   repo="hie-nix";
                   rev="e3113da";
                   sha256="05rkzjvzywsg66iafm84xgjlkf27yfbagrdcb8sc9fd59hrzyiqk";
                 }) {}).hie84;
  vscodeApps = with haskellPackages; with pythonPackages; [
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
in
{
  allowUnfree = true;
  packageOverrides = pkgs: rec {

    vscode = pkgs.vscode.overrideDerivation (old: {
      postFixup = old.postFixup + ''
        wrapProgram $out/bin/code --prefix PATH : ${lib.makeBinPath vscodeApps}
      '';
    });

  };
}
