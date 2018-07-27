===================
letsencrypt-formula
===================

Creates certificates and manages renewal using the letsencrypt service.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``letsencrypt``
---------------

Installs and configures the letsencrypt cli from git, creates the requested certificates and installs renewal cron job.
This is a shortcut for letsencrypt.install letsencrypt.config and letsencrypt.domains .

If `use_package` is `True`, the formula will try to install the package from your Distro's repo. Keep in mind that most distros
don't have a package available by default: Ie, current Debian (Stretch) requires a backports repo installed. Centos 7 requires
EPEL, etc. This formula **DOES NOT** manage these repositories. Use the `apt-formula <https://github.com/saltstack-formulas/apt-formula>`_
or the `epel-formula <https://github.com/saltstack-formulas/epel-formula`_ to manage them.

If you set `use_package` to `True`, it will default to Python3's certbot package (where possible), with Apache as the default Webserver to manage.

To check dependencies to use the package for your distro, check https://certbot.eff.org/all-instructions.

``letsencrypt.install``
-----------------------

Only installs the letsencrypt client. Currently the letsencrypt-auto method is used. This will create a virtualenv in the /root/.config/ directory.
The installation method will be replaced by using packages, as default as soon as they ara stable and available for all major platforms.

``letsencrypt.config``
----------------------

Manages /etc/letsencrypt/cli.ini config file.

``letsencrypt.domains``
-----------------------

Creates a certificate with the domains in each domain set (letsencrypt:domainsets in pillar). Letsencrypt uses a relatively short validity of 90 days.
Therefore, a cron job for automatic renewal every 60 days is installed for each domain set as well.
