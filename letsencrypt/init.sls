# -*- coding: utf-8 -*-
# vim: ft=sls

include:
{% if salt['pillar.get']('letsencrypt:git', False) %}
  - letsencrypt.git
{% endif %}
  - letsencrypt.install
  - letsencrypt.config
  - letsencrypt.domains
