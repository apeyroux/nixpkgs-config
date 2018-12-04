{ pkgs }:

with pkgs;

(import (fetchFromGitHub { owner = "domenkozar";
                           repo = "hie-nix";
                           rev = "master";
                           sha256 = "0hilxgmh5aaxg37cbdwixwnnripvjqxbvi8cjzqrk7rpfafv352q"; }) {}).hies
