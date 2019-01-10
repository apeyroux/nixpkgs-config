{ pkgs }:

with pkgs;

let

  pydrive = with pythonPackages; buildPythonPackage rec {
    pname = "PyDrive";
    version = "1.3.1";

    src = fetchPypi {
      inherit pname version;
      sha256 = "83890dcc2278081c6e3f6a8da1f8083e25de0bcc8eb7c91374908c5549a20787";
    };

    propagatedBuildInputs = [ oauth2client pyyaml google_api_python_client ];

    doCheck = false;
  };

in

duplicity.overrideDerivation (old: {
  propagatedBuildInputs = old.propagatedBuildInputs ++ [ pydrive ];
})
