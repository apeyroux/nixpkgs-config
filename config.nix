with import <nixpkgs> {};

{
  allowUnfree = true;
  packageOverrides = pkgs: rec {
    vscode = (import ./vscode.nix { inherit pkgs; });
    # emacs = (import ./emacs.nix { inherit pkgs; });
    st = (import ./st.nix { inherit pkgs; });
    duplicity = (import ./duplicity.nix { inherit pkgs; });
    spotify = (import ./spotify.nix { inherit pkgs;});
    google-chrome = (import ./google-chrome.nix { inherit pkgs;});
    stable-rust = (rustChannels.stable.rust.override {
         targets = [ "x86_64-unknown-linux-gnu" "x86_64-unknown-linux-musl" ];
    });
    nightly-rust = (rustChannels.nightly.rust.override {
         targets = [ "x86_64-unknown-linux-gnu" "x86_64-unknown-linux-musl" ];
    });
  };
}
