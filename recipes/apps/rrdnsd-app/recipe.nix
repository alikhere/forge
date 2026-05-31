{
  pkgs,
  ...
}:
{
  apps.rrdnsd = {
    displayName = "rrdnsd";
    description = "Distributed monitoring for round-robin DNS load balancing and high availability.";
    usage = ''
      rrdnsd monitors HTTP(S) service availability and updates DNS records to
      implement round-robin DNS failover across geographically-distributed services.

      #### Configuration

      Create a configuration file at `/etc/rrdnsd.json` (or set `CONF` env var):

      ```json
      {
        "conf_version": 1,
        "local_node": "127.0.0.1:3333",
        "nodes": ["127.0.0.1:3333"],
        "nodes_protocol": "http",
        "services": [
          {
            "fqdn": "example.com",
            "healthcheck": "http://{}:80/",
            "ipaddrs": ["192.0.2.1", "192.0.2.2"],
            "probe_interval_ms": 5000,
            "ttl": 30,
            "zone": "example.com"
          }
        ],
        "update_method": "nsupdate",
        "update_credentials": "",
        "update_resolvers": ["127.0.0.1:53"],
        "enable_fail_open": true,
        "api": {"enabled": true},
        "loglevel": "info"
      }
      ```

      #### Start

      ```bash
      rrdnsd
      ```

      _Available in: shell._
    '';

    links = {
      website = "https://rrdnsd.eu";
      source = "https://codeberg.org/FedericoCeratto/rrdnsd";
    };

    ngi.grants = {
      Core = [
        "rrdnsd"
      ];
    };

    programs = {
      packages = [
        pkgs.rrdnsd
      ];

      runtimes.shell = {
        enable = true;
      };
    };
  };
}
