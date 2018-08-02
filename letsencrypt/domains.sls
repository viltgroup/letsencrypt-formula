# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "letsencrypt/map.jinja" import letsencrypt with context %}

{% if letsencrypt.use_package %}
  {% set check_cert_cmd = '/usr/bin/certbot' %}
  {% set renew_cert_cmd = '/usr/bin/certbot renew' %}
  {% set create_cert_cmd = '/usr/bin/certbot' %}

{% else %}
  {% set check_cert_cmd = '/usr/local/bin/check_letsencrypt_cert.sh' %}
  {% set renew_cert_cmd = '/usr/local/bin/renew_letsencrypt_cert.sh' %}
  {% set create_cert_cmd = letsencrypt.cli_install_dir ~ '/letsencrypt-auto' %}

{{ check_cert_cmd }}:
  file.managed:
    - mode: 755
    - contents: |
        #!/bin/bash

        FIRST_CERT=$1

        for DOMAIN in "$@"
        do
            openssl x509 -in /etc/letsencrypt/live/$1/cert.pem -noout -text | grep DNS:${DOMAIN} > /dev/null || exit 1
        done
        CERT=$(date -d "$(openssl x509 -in /etc/letsencrypt/live/$1/cert.pem -enddate -noout | cut -d'=' -f2)" "+%s")
        CURRENT=$(date "+%s")
        REMAINING=$((($CERT - $CURRENT) / 60 / 60 / 24))
        [ "$REMAINING" -gt "30" ] || exit 1
        echo Domains $@ are in cert and cert is valid for $REMAINING days

{{ renew_cert_cmd }}:
  file.managed:
    - template: jinja
    - source: salt://letsencrypt/files/renew_letsencrypt_cert.sh.jinja
    - mode: 755
    - require:
      - file: {{ check_cert_cmd }}
{% endif %}

{% for setname, domainlist in letsencrypt.domainsets.items() %}

create-initial-cert-{{ setname }}-{{ domainlist | join('+') }}:
  cmd.run:
    - unless: {{ check_cert_cmd }} {{ domainlist|join(' ') }}
    - name: {{ create_cert_cmd }} --quiet -d {{ domainlist|join(' -d ') }} certonly --non-interactive
    - cwd: {{ letsencrypt.cli_install_dir }}
    - require:
      {% if letsencrypt.use_package %}
      - pkg: letsencrypt-client
      {% else %}
      - file: {{ check_cert_cmd }}
      {% endif %}
      - file: letsencrypt-config

# Letsencrpyt package uses a systemd service/timer combination
# or recommends to renew twice a day 
  {% if not letsencrypt.use_package %}

# domainlist[0] represents the "CommonName", and the rest
# represent SubjectAlternativeNames
letsencrypt-crontab-{{ setname }}-{{ domainlist[0] }}:
  cron.present:
    - name: {{ renew_cert_cmd }} {{ domainlist|join(' ') }}
    - month: '*'
    - minute: random
    - hour: random
    - dayweek: '*'
    - identifier: letsencrypt-{{ setname }}-{{ domainlist[0] }}
    - require:
      - cmd: create-initial-cert-{{ setname }}-{{ domainlist | join('+') }}
      {% if letsencrypt.use_package %}
      - pkg: letsencrypt-client
      {% else %}
      - file: {{ renew_cert_cmd }}
      {% endif %}
  {% endif %}

create-fullchain-privkey-pem-for-{{ domainlist[0] }}:
  cmd.run:
    - name: |
        cat /etc/letsencrypt/live/{{ domainlist[0] }}/fullchain.pem \
            /etc/letsencrypt/live/{{ domainlist[0] }}/privkey.pem \
            > /etc/letsencrypt/live/{{ domainlist[0] }}/fullchain-privkey.pem && \
        chmod 600 /etc/letsencrypt/live/{{ domainlist[0] }}/fullchain-privkey.pem
    - creates: /etc/letsencrypt/live/{{ domainlist[0] }}/fullchain-privkey.pem
    - require:
      - cmd: create-initial-cert-{{ setname }}-{{ domainlist | join('+') }}

{% endfor %}
