# = Class haproxy::config
#
class haproxy::config {
  File {
    require => Class['::haproxy::install'],
    notify  => Service[$::haproxy::service_name],
    owner   => $::haproxy::config_user,
    group   => $::haproxy::config_group,
    mode    => $::haproxy::config_file_mode,
  }

  file {
    $::haproxy::config_dir:
      ensure  => directory,
      mode    => $::haproxy::config_dir_mode,
      purge   => $::haproxy::config_purge,
      recurse => $::haproxy::config_dir_recurse;

    $::haproxy::log_dir:
      ensure => directory,
      owner  => $::haproxy::daemon_user,
      group  => $::haproxy::daemon_group;

    "${::haproxy::config_dir}/haproxy.cfg":
      ensure  => present,
      content => template('module/haproxy.cfg.erb');
  }

  if $::haproxy::default_file {
    $service_enable = $::haproxy::service_enable

    file { $::haproxy::default_file:
      ensure  => present,
      content => template('module/default_file.erb'),
    }
  }
}

