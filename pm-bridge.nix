{pkgs}:

with pkgs;

(import (fetchTarball https://github.com/NixOS/nixpkgs/archive/master.tar.gz) {}).protonmail-bridge.overrideDerivation (old: {
  installPhase = old.installPhase + ''
    ln -s $out/bin/Desktop-Bridge $out/bin/protonmail-bridge
  '';
})

