=====
trot
=====

.. image:: https://travis-ci.com/ucpr/trot.svg?branch=master
    :target: https://travis-ci.com/ucpr/trot

trot is a CLI Application that expresses grass of GitHub at terminal.

.. image:: Screenshot.png

requires
-----------
::

  nim >= 0.18.0
  Terminal supporting True Color

build
-----
::

  $ nimble build

install
-------
::

  $ git clone https://github.com/ucpr/trot
  $ cd trot
  $ nimble install

usage
-----
::

    trot is a CLI Application that expresses grass of GitHub at terminal.
    Usage: trot [OPTION] [username]
           trot -h | --help
           trot -v | --version
    Option:
      -h --help      show this screen.
      -v --version   show version.

::

  # show repository contributions
  $ trot
  # show ucpr's contributions
  $ trot ucpr

author
------
taichi uchihara (@u_chi_ha_ra_)

license
-------
MIT
