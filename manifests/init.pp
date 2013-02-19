# = Class haproxy
#
class haproxy (
  $config_dir         = $::haproxy::params::config_dir,
  $config_dir_mode    = $::haproxy::params::config_dir_mode,
  $config_dir_recurse = $::haproxy::params::config_dir_recurse,
  $config_file_mode   = $::haproxy::params::config_file_mode,
  $config_group       = $::haproxy::params::config_group,
  $config_purge       = $::haproxy::params::config_purge,
  $config_user        = $::haproxy::params::config_user,
  $daemon_group       = $::haproxy::params::daemon_group,
  $daemon_user        = $::haproxy::params::daemon_user,
  $log_dir            = $::haproxy::params::log_dir,
  $manage_repo        = $::haproxy::params::manage_repo,
  $pid_file           = $::haproxy::params::pid_file,
  $pkg_deps           = $::haproxy::params::pkg_deps,
  $pkg_ensure         = $::haproxy::params::pkg_ensure,
  $pkg_list           = $::haproxy::params::pkg_list,
  $service_dep        = $::haproxy::params::service_dep,
  $service_enable     = $::haproxy::params::service_enable,
  $service_ensure     = $::haproxy::params::service_ensure,
  $service_hasrestart = $::haproxy::params::service_hasrestart,
  $service_hasstatus  = $::haproxy::params::service_hasstatus,
  $service_name       = $::haproxy::params::service_name,
) inherits haproxy::params {
  class { 'haproxy::install': } ->
  class { 'haproxy::config': } ~>
  class { 'haproxy::service': } ->
  Class['haproxy']
}

