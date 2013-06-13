# == Define: haproxy::instance
#
# === Parameters:
#
# $ensure::                 Default: present
#
# $balance::                Define the load balancing algorithm to be used
#                           in a backend.
#                           Default: source
#
# $bind::                   Define one or several listening addresses
#                           and/or ports in a frontend.
#                           Default: '*:80'
#
# $default_backend:         Specify the backend to use when no "use_backend"
#                           rule has been matched.
#                           Default: undef
#
# $instance::               Specify the kind of instance to use.
#                           Available options: listen, frontend, backend.
#                           Default: 'listen'
#
# $mode::                   Set the running mode or protocol of the instance.
#                           Default: 'http'
#
# $option::                 Enable a number of instance options.
#                           Please refer to the link below for a list of
#                           valid options:
#                           https://code.google.com/p/haproxy-docs/wiki/mode
#                           Default: [ 'httpcose', 'checkcache' ]
#
# $server::                 Declare a server in a backend.
#                           Default: undef
#                           Example:
#                             [
#                               'server first  10.1.1.1:1080 cookie first  check inter 1000',
#                               'server second 10.1.1.2:1080 cookie second check inter 1000'
#                             ]
#
define haproxy::instance (
  $default_backend,
  $server,
  $ensure          = present,
  $balance         = 'source',
  $bind            = '*:80',
  $instance        = 'listen',
  $mode            = 'http',
  $option          = [ 'httpcose', 'checkcache' ],
) {
  case $instance {
    'listen': {
      $order = '110'
    }

    'frontend': {
      $order = '120'
    }

    'backend': {
      $order = '130'
    }

    default: {
      fail "Wrong value for \$instance: ${instance}."
    }
  }

  concat::fragment { "haproxy.cfg_instance_${name}":
    ensure  => $ensure,
    target  => "${haproxy::config_dir}/haproxy.cfg",
    content => template("haproxy/instance_${instance}.erb"),
    order   => $order,
  }
}

