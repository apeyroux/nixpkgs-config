{ pkgs }:

with pkgs;

google-chrome.overrideDerivation (old: {
  installPhase = old.installPhase + ''
  cp $out/bin/google-chrome-stable $out/bin/google-chrome
  '';
})
