# -*- coding: utf-8 -*-
# vim: ft=yaml
---
letsencrypt:
  install_method: pip
  version: 1.7.0
  pip_pkgs:
    - certbot-dns-powerdns
  config: |
    server = https://acme-staging.api.letsencrypt.org/directory
    email = saltstack-letsencrypt-formula@example.com
    authenticator = standalone
    agree-tos = True
    renew-by-default = True
  domainsets:
    www:
      - letsencrypt-formula.example.com
