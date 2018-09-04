{pkgs}:

with pkgs;

let

  # apps = with haskell.packages.ghc861; [
  apps = with haskellPackages; [
      (import ./hie.nix { inherit pkgs; })
      ag
      aspellWithDictFR
      binutils
      cabal-install
      cabal2nix
      docker-machine
      emacs-all-the-icons-fonts
      gcc
      ghc
      ghcid
      git
      gnumake
      go
      happy
      hindent
      hlint
      hoogle
      hpack
      htmlTidy
      isync
      libxml2
      makeWrapper
      mercurial
      multimarkdown
      ncurses
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
      cargo
      rustc
      stack
      structured-haskell-mode
      stylish-haskell
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
      wrapProgram $out/bin/emacs --prefix PATH : ${lib.makeBinPath apps}
      wrapProgram $out/bin/emacs \
            --prefix PYTHONPATH : "$(toPythonPath ${python36}):$(toPythonPath ${pip}):$PYTHONPATH" \
            --prefix PYTHONPATH : "$(toPythonPath ${virtualenv})" \
            --prefix PYTHONPATH : "$(toPythonPath ${elpy})" \
            --prefix PYTHONPATH : "$(toPythonPath ${jedi})" \
            --prefix PYTHONPATH : "$(toPythonPath ${autopep8})" \
            --prefix PYTHONPATH : "$(toPythonPath ${flake8})" \
            --prefix PYTHONPATH : "$(toPythonPath ${grammalecte})" \
            --prefix PYTHONPATH : "$(toPythonPath ${python27Packages.rope})";
      '');
  })
