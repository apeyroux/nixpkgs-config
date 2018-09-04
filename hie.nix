{ pkgs }:

with pkgs;

(import (fetchFromGitHub { owner = "apeyroux";
                           repo = "hie-nix";
                           rev = "update";
                           sha256 = "03w21cn5n3z0ldjmnl2mzza9jysw5avhip6cpgb4anbjyvkzpnqf"; }) {}).hie84.overrideDerivation(old: {

                           

})
