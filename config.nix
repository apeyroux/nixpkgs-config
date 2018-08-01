with import <nixpkgs> {};

{
  allowUnfree = true;
  packageOverrides = pkgs: rec {
    vscode = (import ./vscode.nix { inherit pkgs; });
    emacs = (import ./emacs.nix { inherit pkgs; });
    flycheck-grammalecte = (import ./flycheck-grammalecte.nix { inherit pkgs; });
  };
}
