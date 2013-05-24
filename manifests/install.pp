# == Class haproxy::install
#
class haproxy::install {
  package { $::haproxy::pkg_list:
    ensure => $::haproxy::pkg_ensure,
  }

  if $::haproxy::pkg_deps {
    package { $::haproxy::pkg_deps:
      ensure => $::haproxy::pkg_ensure,
      before => Package[$::haproxy::pkg_list],
    }
  }
}

