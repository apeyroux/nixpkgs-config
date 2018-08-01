with import <nixpkgs> {};

{
  allowUnfree = true;
  packageOverrides = pkgs: rec {
    vscode = (import ./vscode.nix { inherit pkgs; });
  };
}
