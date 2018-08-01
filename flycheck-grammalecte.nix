{pkgs}:

with pkgs;

stdenv.mkDerivation {
    name = "flycheck-grammalecte";
    src = fetchgit {
      url = "https://gitlab.com/geeklhem/flycheck-grammalecte.git";
      rev = "6fa0d0cefa9c324831c7bf97d6cc360dcdaa85e0";
      sha256 = "1s66py788f2vvmjsnka2lcjkravvdliznbvmfi5z7kpcq62jiccw";
      fetchSubmodules = true;
    };

    buildInputs = [ (emacsWithPackages (ps: with ps; with emacsPackagesNg; [ flycheck ])) ];

    buildPhase = ''
      emacs --batch -f batch-byte-compile flycheck-grammalecte.el
    '';

    installPhase = ''
      install -d $out/share/emacs/site-lisp
      install flycheck-grammalecte.el $out/share/emacs/site-lisp
      install flycheck-grammalecte.elc $out/share/emacs/site-lisp
      install flycheck-grammalecte.py $out/share/emacs/site-lisp
    '';
}