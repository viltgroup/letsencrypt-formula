# -*- coding: utf-8 -*-
# vim: ft=sls
{% from "letsencrypt/map.jinja" import letsencrypt with context %}

letsencrypt-client-git:
  git.latest:
    - name: https://github.com/letsencrypt/letsencrypt
    - target: {{ letsencrypt.cli_install_dir }}
    - force_reset: True
{% if salt['pillar.get']('letsencrypt:extra_pkg', False) %}
    - requires:
       - pkg: {{ letsencrypt.extra_pkg }}
{% endif %}
{% if salt['pillar.get']('letsencrypt:extra_pkg', False) %}
letsencrypt_extra_package_install:
 pkg.latest:
    - pkg: {{ letsencrypt.extra_pkg }}
{% endif %}


