with import <nixpkgs> {};

let
  hie = (import /nix/store/0jbly87rqr9dy3s1bpq0rawpv0cz5d0a-hie-nix {}).hie82;
  vscodeApps = with haskellPackages; with pythonPackages; [
    hie
    stack
    hoogle
    ipython
  ];
in
{
  allowUnfree = true;
  packageOverrides = pkgs: rec {
    vscode = pkgs.vscode.overrideDerivation (old: {
      postFixup = old.postFixup + ''
        wrapProgram $out/bin/code --prefix PATH : ${lib.makeBinPath vscodeApps}
      '';
    });
  };
}
