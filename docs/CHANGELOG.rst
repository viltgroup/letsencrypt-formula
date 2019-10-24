
Changelog
=========

`0.20.0 <https://github.com/saltstack-formulas/letsencrypt-formula/compare/v0.19.1...v0.20.0>`_ (2019-10-24)
----------------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **map.jinja:** fix ``salt-lint`` errors (\ ` <https://github.com/saltstack-formulas/letsencrypt-formula/commit/55b3b31>`_\ )
* **repo:** provide EPEL repo configuration for ``amazon-2`` (\ ` <https://github.com/saltstack-formulas/letsencrypt-formula/commit/25196c8>`_\ )
* **rubocop:** add fixes using ``rubocop --safe-auto-correct`` (\ ` <https://github.com/saltstack-formulas/letsencrypt-formula/commit/94e8abe>`_\ )
* **rubocop:** fix remaining errors manually (\ ` <https://github.com/saltstack-formulas/letsencrypt-formula/commit/f313483>`_\ )
* **yamllint:** fix all errors (\ ` <https://github.com/saltstack-formulas/letsencrypt-formula/commit/9aaec41>`_\ )

Code Refactoring
^^^^^^^^^^^^^^^^


* **kitchen:** prefer ``kitchen.yml`` to ``.kitchen.yml`` (\ ` <https://github.com/saltstack-formulas/letsencrypt-formula/commit/950b95d>`_\ )
* **kitchen:** use ``pillar_from_files`` throughout (\ ` <https://github.com/saltstack-formulas/letsencrypt-formula/commit/65ee41d>`_\ )

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **kitchen:** remove redundant settings (all covered under the suites) (\ ` <https://github.com/saltstack-formulas/letsencrypt-formula/commit/37a3a56>`_\ )

Documentation
^^^^^^^^^^^^^


* **readme:** modify according to standard structure (\ ` <https://github.com/saltstack-formulas/letsencrypt-formula/commit/fcaa79c>`_\ )
* **readme:** move to ``docs/`` directory (\ ` <https://github.com/saltstack-formulas/letsencrypt-formula/commit/550b56d>`_\ )

Features
^^^^^^^^


* **semantic-release:** implement for this formula (\ ` <https://github.com/saltstack-formulas/letsencrypt-formula/commit/1a6c486>`_\ )

Tests
^^^^^


* **inspec:** fix typo in ``git`` test filename (\ ` <https://github.com/saltstack-formulas/letsencrypt-formula/commit/83f1cac>`_\ )
* **inspec:** move tests to relevant ``controls`` sub-directory (\ ` <https://github.com/saltstack-formulas/letsencrypt-formula/commit/71bd8c1>`_\ )
