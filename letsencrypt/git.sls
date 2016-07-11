{% from "letsencrypt/map.jinja" import letsencrypt with context %}

{%- set letsencrypt_git = salt['pillar.get']('letsencrypt:git', False) %}
 
{% if letsencrypt_git != False %}
install-letsencrypt-git:
  pkg.installed:
    - name: {{ letsencrypt_git }}
{% endif %}
