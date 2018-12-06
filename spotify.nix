{pkgs}:

with pkgs;

spotify.overrideDerivation (old: {
  postInstall = ''
    wrapProgram $out/share/spotify/spotify --add-flags ${lib.escapeShellArg "--force-device-scale-factor=2"}
  '';
})
