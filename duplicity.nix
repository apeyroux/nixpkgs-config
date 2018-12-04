{ pkgs }:

with pkgs;

let
# b2 = callPackage /home/alex/tmp/b2/requirements.nix {};
in
duplicity.overrideDerivation (old: {
  propagatedBuildInputs = old.propagatedBuildInputs ++ [ b2 ];
})
