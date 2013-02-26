# = Class haproxy
#
class haproxy (
  $config_dir           = $::haproxy::params::config_dir,
  $config_dir_mode      = $::haproxy::params::config_dir_mode,
  $config_dir_recurse   = $::haproxy::params::config_dir_recurse,
  $config_file_mode     = $::haproxy::params::config_file_mode,
  $config_group         = $::haproxy::params::config_group,
  $config_purge         = $::haproxy::params::config_purge,
  $config_user          = $::haproxy::params::config_user,
  $daemon_group         = $::haproxy::params::daemon_group,
  $daemon_user          = $::haproxy::params::daemon_user,
  $log_dir              = $::haproxy::params::log_dir,
  $manage_repo          = $::haproxy::params::manage_repo,
  $pid_file             = $::haproxy::params::pid_file,
  $pkg_deps             = $::haproxy::params::pkg_deps,
  $pkg_ensure           = $::haproxy::params::pkg_ensure,
  $pkg_list             = $::haproxy::params::pkg_list,
  $service_dep          = $::haproxy::params::service_dep,
  $service_enable       = $::haproxy::params::service_enable,
  $service_ensure       = $::haproxy::params::service_ensure,
  $service_hasrestart   = $::haproxy::params::service_hasrestart,
  $service_hasstatus    = $::haproxy::params::service_hasstatus,
  $service_name         = $::haproxy::params::service_name,
  $stats_auth_enable    = $::haproxy::params::stats_auth_enable,
  $stats_auth_pass      = $::haproxy::params::stats_auth_pass,
  $stats_auth_user      = $::haproxy::params::stats_auth_user,
  $stats_enable         = $::haproxy::params::stats_enable,
  $stats_listen_address = $::haproxy::params::stats_listen_address,
  $stats_listen_port    = $::haproxy::params::stats_listen_port,
  $stats_realm          = $::haproxy::params::stats_realm,
  $stats_url            = $::haproxy::params::stats_url,

  $defaults_clitimeout = $::haproxy::params::defaults_clitimeout,
  $defaults_contimeout = $::haproxy::params::defaults_contimeout,
  $defaults_log        = $::haproxy::params::defaults_log,
  $defaults_maxconn    = $::haproxy::params::defaults_maxconn,
  $defaults_mode       = $::haproxy::params::defaults_mode,
  $defaults_option     = $::haproxy::params::defaults_option,
  $defaults_retries    = $::haproxy::params::defaults_retries,
  $defaults_srvtimeout = $::haproxy::params::defaults_srvtimeout,

  $global_chroot       = $::haproxy::params::global_chroot,
  $global_daemon       = $::haproxy::params::global_daemon,
  $global_debug        = $::haproxy::params::global_debug,
  $global_log          = $::haproxy::params::global_global_log,
  $global_maxconn      = $::haproxy::params::global_maxconn,
  $global_nbproc       = $::haproxy::params::global_nbproc,
  $global_quiet        = $::haproxy::params::global_quiet,
  $global_stats_socket = $::haproxy::params::global_stats_socket,
) inherits haproxy::params {
  class { 'haproxy::install': } ->
  class { 'haproxy::config': } ~>
  class { 'haproxy::service': } ->
  Class['haproxy']
}

