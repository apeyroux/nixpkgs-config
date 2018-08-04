{pkgs}:

with pkgs;

let

  kittyCfg = fetchurl {url="https://raw.githubusercontent.com/apeyroux/kitty-theme/master/kitty.conf"; sha256="0ri392yq13zkc4vrjjb99farp8qxx4isi59197mac1cldxasdxll";};

in

kitty.overrideDerivation (old: {
  installPhase = ''
    runHook preInstall
    mkdir -p $out
    cp -r linux-package/{bin,share,lib} $out
    wrapProgram "$out/bin/kitty" --prefix PATH : "$out/bin:${stdenv.lib.makeBinPath [ imagemagick xsel ]}" --add-flags "--config ${kittyCfg}"
    runHook postInstall
  '';
})

