{ pkgs }:

with pkgs;

(import (fetchFromGitHub {
                owner="domenkozar";
                repo="hie-nix";
                rev="e3113da";
                sha256="05rkzjvzywsg66iafm84xgjlkf27yfbagrdcb8sc9fd59hrzyiqk";
            }) {}).hie84
