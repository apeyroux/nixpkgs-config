{pkgs}:

with pkgs;

let
  # apps = with haskell.packages.ghc861; [
  # apps = with haskellPackages; [
  apps = [
      # (import ./hie.nix { inherit pkgs; })
      # end pdf
      # pdf tools
      ag
      aspellWithDictFR
      autoconf
      automake
      binutils
      cabal-install
      cabal2nix
      cargo
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
      rustc
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
