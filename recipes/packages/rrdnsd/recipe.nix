{
  lib,
  ...
}:
{
  packages.rrdnsd = {
    version = "0-main-2026-04-03";
    description = "Distributed monitoring for round-robin DNS load balancing and high availability.";
    homePage = "https://rrdnsd.eu";
    mainProgram = "rrdnsd";
    license = lib.licenses.agpl3Only;

    source = {
      git = "codeberg:FedericoCeratto/rrdnsd/0df119a1d49bb81dedd4d874031fe96d41fa1f3d";
      hash = "sha256-3spJ2b1TJ9u528sHNNO43PprArO611Ho1W6I4+SKbYk=";
    };

    build.rustPackageBuilder = {
      enable = true;
      cargoHash = "sha256-3D4ck9gMI4C6ULE5S75cZmvN8WnBCVdu1bIODe4X5Vc=";
    };

    build.extraAttrs = {
      cargoPatches = [
        ./add-cargo-lock.patch
      ];
      doCheck = false;
    };

    test.script = ''
      cat > /tmp/rrdnsd.json <<EOF
      {
        "conf_version": 1,
        "local_node": "127.0.0.1:13333",
        "nodes": ["127.0.0.1:13333"],
        "nodes_protocol": "http",
        "services": [],
        "update_method": "nsupdate",
        "update_credentials": "",
        "update_resolvers": [],
        "enable_fail_open": false,
        "api": {"enabled": false},
        "loglevel": "info"
      }
      EOF
      timeout 2 env CONF=/tmp/rrdnsd.json rrdnsd 2>&1 || true
    '';
  };
}
