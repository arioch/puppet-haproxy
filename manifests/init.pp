# == Class haproxy
#
# === Parameters:
#
# $config_dir::             Location of the main configuration directory.
#                           Default: operating system specific.
#
# $config_dir_mode::        Posix file mode for configuration directory.
#                           Default: operating system specific.
#
# $config_dir_recurse::     Enforce permissions in files and directories below?
#                           Default: false.
#
# $config_file_mode::       Posix file mode for configuration files.
#                           Default: operating system specific.
#
# $config_group::           Unprivileged group to run daemon.
#                           Default: operating system specific.
#
# $config_purge::           Enable/disable purging unmanaged files.
#                           Default: false.
#
# $config_user::            Posix user for configuration files.
#                           Default: operating system specific.
#
# $daemon_group::           Unprivileged group to run daemon.
#                           Default: operating system specific.
#
# $daemon_user::            Unprivileged user to run daemon.
#                           Default: operating system specific.
#
# $defaults_clitimeout::    Set client time-out.
#                           Default: '50000'.
#
# $defaults_contimeout::    Set connection time-out.
#                           Default: '5000'.
#
# $defaults_log::           Set log mode for defaults section.
#                           Default: [ 'global' ].
#
# $defaults_maxconn::       Set max number of connections for defaults section.
#                           Default: '2000'.
#
# $defaults_option::        Specify additional options for defaults section.
#                           Default:
#                           [ 'httplog', 'redispatch', 'dontlognull' ]
#
# $defaults_retries::       Set retry limit for defaults section.
#                           Default: '3'.
#
# $defaults_srvtimeout::    Set server timeout for defaults section.
#                           Default: '50000'.
#
# $global_chroot::          Specify directory where to chroot the daemon.
#                           Default: undef.
#
# $global_daemon::          Enable/disable daemon mode.
#                           Default: true.
#
# $global_debug::           Enable/disable debug messages.
#                           Default: false.
#
# $global_log::             Set log mode for global section.
#                           Default:
#                           [ '127.0.0.1 local0', '127.0.0.1 local1 notice' ]
#
# $global_maxconn::         Set max number of connections for global section.
#                           Default: '4096'.
#
# $global_nbproc::          Set number of daemon processes.
#                           Default: equals the number of available cpu cores.
#
# $global_quiet::           Enable/disable quiet startup mode.
#                           Default: false.
#
# $global_stats_socket::    Specify stats socket file.
#                           Default: '/var/run/haproxy.sock'.
#
# $global_ulimit::          Set a per process ulimit for haproxy.
#
# $log_dir::                Determine where to send logging information.
#                           Default: operating system specific.
#
# $pkg_deps::               Any dependencies that need to be resolved before
#                           installing the main package.
#                           Default: operating system specific.
#
# $pkg_ensure::             Ensure state for packages.
#                           Default: 'present'.
#
# $pkg_list::               An array containing the main package and possibly
#                           a number of dependencies.
#                           Default: operating system specific.
#
# $service_dep::            Specify dependant services that need to be started
#                           before starting the default daemon.
#                           Default: operating system specific.
#
# $service_enable::         Enable/disable the daemon at boot time.
#                           Default: true.
#
# $service_ensure::         Ensure daemon state.
#                           Default: 'running'.
#
# $service_hasrestart::     Specify whether or not the init script has restart.
#                           Default: operating system specific.
#
# $service_hasstatus::      Specify whether or not the init script has status.
#                           Default: operating system specific.
#
# $service_name::           Specify the name of the init script.
#                           Default: operating system specific.
#
# $stats_auth_enable::      Enable/disable authentication for stats page.
#                           Default: false.
#
# $stats_auth_pass::        Set authentication password for stats page.
#                           Default: 'secret'.
#
# $stats_auth_user::        Set authentication user for stats page.
#                           Default: 'haproxy'.
#
# $stats_enable::           Enable/disable stats page.
#                           Default: false.
#
# $stats_listen_address::   Set default listen address for stats page.
#                           Default: '127.0.0.1'.
#
# $stats_listen_port::      Set default listen port for stats page.
#                           Default: '8000'.
#
# $stats_realm::            Define which name should appear when browser asks
#                           for a password on the stats page.
#                           Default: 'HAProxy'.
#
# $stats_url::              Specify which URI prefix to intercept.
#                           Default: '/haproxy'.
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
  $defaults_clitimeout  = $::haproxy::params::defaults_clitimeout,
  $defaults_contimeout  = $::haproxy::params::defaults_contimeout,
  $defaults_log         = $::haproxy::params::defaults_log,
  $defaults_maxconn     = $::haproxy::params::defaults_maxconn,
  $defaults_option      = $::haproxy::params::defaults_option,
  $defaults_retries     = $::haproxy::params::defaults_retries,
  $defaults_srvtimeout  = $::haproxy::params::defaults_srvtimeout,
  $global_chroot        = $::haproxy::params::global_chroot,
  $global_daemon        = $::haproxy::params::global_daemon,
  $global_debug         = $::haproxy::params::global_debug,
  $global_log           = $::haproxy::params::global_log,
  $global_maxconn       = $::haproxy::params::global_maxconn,
  $global_nbproc        = $::haproxy::params::global_nbproc,
  $global_quiet         = $::haproxy::params::global_quiet,
  $global_stats_socket  = $::haproxy::params::global_stats_socket,
  $global_ulimit        = $::haproxy::params::global_ulimit,
  $log_dir              = $::haproxy::params::log_dir,
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
) inherits haproxy::params {
  class { 'haproxy::install': } ->
  class { 'haproxy::config': } ~>
  class { 'haproxy::service': } ->
  Class['haproxy']
}

