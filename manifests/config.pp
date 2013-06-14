# == Class haproxy::config
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
  }

  if $::haproxy::default_file {
    $service_enable = $::haproxy::service_enable

    file { $::haproxy::default_file:
      ensure  => present,
      content => template('haproxy/default_file.erb'),
    }
  }

  if $::haproxy::global_chroot {
    if ! is_string($::haproxy::global_chroot) {
      fail 'Wrong value for \$global_chroot. Should be a directory.'
    }

    validate_absolute_path($::haproxy::global_chroot)

    file { $::haproxy::global_chroot:
      ensure => directory,
      owner  => $::haproxy::daemon_user,
      group  => $::haproxy::daemon_group,
    }
  }

  concat { "${::haproxy::config_dir}/haproxy.cfg":
    owner   => $::haproxy::config_user,
    group   => $::haproxy::config_group,
    mode    => $::haproxy::config_file_mode,
  }

  concat::fragment { 'haproxy.cfg_header':
    target  => "${::haproxy::config_dir}/haproxy.cfg",
    content => "# Managed by Puppet\n",
    order   => 01,
  }

  concat::fragment { 'haproxy.cfg_global':
    target  => "${::haproxy::config_dir}/haproxy.cfg",
    content => template('haproxy/config_global.erb'),
    order   => 02,
  }

  concat::fragment { 'haproxy.cfg_defaults':
    target  => "${::haproxy::config_dir}/haproxy.cfg",
    content => template('haproxy/config_defaults.erb'),
    order   => 03,
  }

  if $::haproxy::stats_enable {
    concat::fragment { 'haproxy.cfg_stats':
      target  => "${::haproxy::config_dir}/haproxy.cfg",
      content => template('haproxy/config_stats.erb'),
      order   => 04,
    }
  }
}

