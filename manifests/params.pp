# = Class haproxy::params
#
class haproxy::params {
  $manage_repo = false

  case $::osfamily {
    'RedHat': {
      $config_dir         = '/etc/haproxy'
      $config_dir_mode    = '0755'
      $config_dir_recurse = false
      $config_group       = 'root'
      $config_mode        = '0644'
      $config_purge       = false
      $config_user        = 'root'
      $daemon_group       = ''
      $daemon_user        = ''
      $log_dir            = ''
      $pid_file           = ''
      $pkg_deps           = undef
      $pkg_ensure         = present
      $pkg_list           = ''
      $service_dep        = undef
      $service_enable     = true
      $service_ensure     = running
      $service_hasrestart = ''
      $service_hasstatus  = ''
      $service_name       = 'haproxy'
    }

    'Debian': {
      $config_dir         = '/etc/haproxy'
      $config_dir_mode    = '0755'
      $config_dir_recurse = false
      $config_file_mode   = '0644'
      $config_group       = 'root'
      $config_user        = 'root'
      $daemon_group       = 'haproxy'
      $daemon_user        = 'haproxy'
      $default_file       = '/etc/default/haproxy'
      $log_dir            = '/var/log/haproxy'
      $pid_file           = '/var/run/haproxy.pid'
      $pkg_deps           = undef
      $pkg_ensure         = present
      $pkg_list           = 'haproxy'
      $service_dep        = undef
      $service_enable     = true
      $service_ensure     = running
      $service_hasrestart = true
      $service_hasstatus  = true
      $service_name       = 'haproxy'
    }

    default: {
      fail "Operating system ${::operatingsystem} is not supported yet."
    }
  }
}

