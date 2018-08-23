{pkgs}:

with pkgs;

protonmail-bridge.overrideDerivation (old: {
  installPhase = old.installPhase + ''
    ln -s $out/bin/Desktop-Bridge $out/bin/protonmail-bridge
  '';
})

