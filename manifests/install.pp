# = Class haproxy::install
#
class haproxy::install {
  package { $::haproxy::pkg_list:
    ensure => $::haproxy::pkg_ensure,
  }

  if $::haproxy::pkg_deps {
    package { $::awstats::pkg_deps:
      ensure => $::awstats::pkg_ensure,
      before => Package[$::haproxy::pkg_list],
    }
  }
}

