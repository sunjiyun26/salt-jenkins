{%- if grains['os_family'] == 'RedHat' %}
  {% set apache = 'httpd' %}
{%- else %}
  {% set apache = 'apache2' %}
{%- endif %}

{{ apache }}:
  pkg:
    - installed
  service:
    - running
    {%- if grains['os_family'] == 'RedHat' %}
    - file: /etc/httpd/conf/httpd.conf
    {%- endif %}
    - require:
      - pkg: {{ apache }}
  force_reload: true

{%- if grains['os_family'] == 'RedHat' %}
/etc/httpd/conf/httpd.conf:
  file.managed:
    - source: salt://apache/httpd.conf
    - user: root
    - group: root
    - mode: 644
{%- endif %}
