# == Class haproxy
#
class haproxy::service {
  if $::haproxy::service_dep {
    service { $::haproxy::service_dep:
      ensure     => $::haproxy::service_ensure,
      enable     => $::haproxy::service_enable,
      hasrestart => $::haproxy::service_hasrestart,
      hasstatus  => $::haproxy::service_hasstatus,
      require    => Class['::haproxy::config'];
    }

    service { $::haproxy::service_name:
      ensure     => $::haproxy::service_ensure,
      enable     => $::haproxy::service_enable,
      hasrestart => $::haproxy::service_hasrestart,
      hasstatus  => $::haproxy::service_hasstatus,
      require    => [
        Service['::haproxy::service_dep'],
        Class['::haproxy::config'],
      ];
    }
  } else {
    service { $::haproxy::service_name:
      ensure     => $::haproxy::service_ensure,
      enable     => $::haproxy::service_enable,
      hasrestart => $::haproxy::service_hasrestart,
      hasstatus  => $::haproxy::service_hasstatus,
      require    => Class['::haproxy::config'];
    }
  }
}

