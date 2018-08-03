# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "letsencrypt/map.jinja" import letsencrypt with context %}

letsencrypt-client:
  {% if letsencrypt.use_package %}
  pkg.installed:
    - pkgs: {{ letsencrypt.pkgs }}
  {% else %}
  git.latest:
    - name: https://github.com/letsencrypt/letsencrypt
    - target: {{ letsencrypt.cli_install_dir }}
    - force_reset: True
  {% endif %}
