with import <nixpkgs> {};

{
  allowUnfree = true;
  packageOverrides = pkgs: rec {
    vscode = (import ./vscode.nix { inherit pkgs; });
    emacs = (import ./emacs.nix { inherit pkgs; });
    kitty = (import ./kitty.nix { inherit pkgs; });
  };
}
