# -*- coding: utf-8 -*-
# vim: ft=sls
{% from "letsencrypt/map.jinja" import letsencrypt with context %}
letsencrypt_dependencies:
  pkg.installed:
    - name: {{ letsencrypt.git_package }}

letsencrypt-client:
  {% if letsencrypt.use_package %}
  pkg.installed:
    - pkgs: {{ letsencrypt.pkgs }}
  {% else %}
  git.latest:
    - name: https://github.com/letsencrypt/letsencrypt
    - target: {{ letsencrypt.cli_install_dir }}
    - force_reset: True
    - require:
      - pkg: {{ letsencrypt.git_package }}
  {% endif %}
