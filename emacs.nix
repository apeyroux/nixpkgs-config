{ pkgs }:

with pkgs;

let
  bintools = binutils.bintools;
  rust-src = fetchFromGitHub {
    owner = "mozilla";
    repo = "nixpkgs-mozilla";
    # 191019
    rev = "65bfcb376612a2dc0439346e3af8dd0cd257a3de";
    sha256 = "034m1dryrzh2lmjvk3c0krgip652dql46w5yfwpvh7gavd3iypyw";
  };
  # apps = with haskell.packages.ghc861; [
  # apps = with haskellPackages; [
  apps =   with import "${rust-src.out}/rust-overlay.nix" pkgs pkgs; [
      (import ./hie.nix { inherit pkgs; })
      ag
      aspellWithDictFR
      autoconf
      automake
      binutils
      bintools
      cabal-install
      cabal2nix
      docker-machine
      emacs-all-the-icons-fonts
      gcc
      ghc
      git
      gnumake
      go
      haskellPackages.ghcid
      haskellPackages.happy
      haskellPackages.hindent
      haskellPackages.hlint
      haskellPackages.hoogle
      haskellPackages.hpack
      haskellPackages.structured-haskell-mode
      haskellPackages.stylish-haskell
      htmlTidy
      imagemagick
      isync
      libpng
      libxml2
      makeWrapper
      mercurial
      multimarkdown
      ncurses
      poppler # confusion avec poppler haskell
      python27Packages.rope
      python36
      python36Packages.autopep8
      python36Packages.elpy
      python36Packages.epc
      python36Packages.flake8
      python36Packages.grammalecte
      python36Packages.importmagic
      python36Packages.ipython
      python36Packages.jedi
      python36Packages.virtualenv
      rustChannels.nightly.cargo
      rustChannels.nightly.rust
      rustChannels.nightly.rust-docs
      rustChannels.nightly.rustc
      rustracer
      rustracerd
      rustfmt
      siji
      stack
      tshark
      w3m
      xclip
      xz
      zip
      zlib
    ];

  aspellWithDictFR = aspellWithDicts (ps: with ps; [ en fr ]);

in

  emacs.overrideDerivation (old: rec {
    postInstall = with python36Packages; (old.postInstall + ''
      # bin
      wrapProgram $out/bin/emacs --prefix PATH : "${lib.makeBinPath apps}"
      # python
      wrapProgram $out/bin/emacs --prefix PYTHONPATH : "$(toPythonPath ${pip})" 
      wrapProgram $out/bin/emacs --prefix PYTHONPATH : "$(toPythonPath ${virtualenv})"
      wrapProgram $out/bin/emacs --prefix PYTHONPATH : "$(toPythonPath ${elpy})"
      wrapProgram $out/bin/emacs --prefix PYTHONPATH : "$(toPythonPath ${jedi})"
      wrapProgram $out/bin/emacs --prefix PYTHONPATH : "$(toPythonPath ${autopep8})"
      wrapProgram $out/bin/emacs --prefix PYTHONPATH : "$(toPythonPath ${flake8})"
      wrapProgram $out/bin/emacs --prefix PYTHONPATH : "$(toPythonPath ${rope})"
      '');
  })
