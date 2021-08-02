# -*- coding: utf-8 -*-
# vim: ft=yaml
---
letsencrypt:
  install_method: package
  config: |
    server = https://acme-staging.api.letsencrypt.org/directory
    email = saltstack-letsencrypt-formula@example.com
    authenticator = webroot
    webroot-path = /var/www/html
    agree-tos = true
    renew-by-default = true
  domainsets:
    www:
      - letsencrypt-formula.example.com
