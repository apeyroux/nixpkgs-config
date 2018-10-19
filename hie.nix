{ pkgs }:

with pkgs;

(import (fetchFromGitHub { owner = "apeyroux";
                           repo = "hie-nix";
                           rev = "update";
                           sha256 = "1wjg9qal4d0hjb5p7rf8v7gr0z59fkzipxas65fd5xflzs4g9ama"; }) {}).hie84.overrideDerivation(old: {
                           
                           })
