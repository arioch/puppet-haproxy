# == Define: haproxy::instance
#
# === Parameters:
#
# $ensure::                 Default: present
#
# $acl::
#                           Default: undef
#
# $acl_backend::
#                           Default: undef
#
# $acl_header::
#                           Default: undef
#
# $balance::                Define the load balancing algorithm to be used
#                           in a backend.
#                           Default: source
#
# $bind::                   Define one or several listening addresses
#                           and/or ports in a frontend.
#                           Default: '*:80'
#
# $capture:                 Add custom logging options to manage log fields.
#                           Default: undef
#
# $redirect:                Redirect rules, for example http to https.
#                           If specified, removes 'default_backend' option.
#                           Default: undef
#                           Example:
#                              redirect => [ 
#                                'scheme https if { hdr(Host) -i www.example.com } !{ ssl_fc }',
#                                'scheme https if { hdr(Host) -i example.com } !{ ssl_fc }',
#                                'location https://www.example.com',
#                              ]
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
#                           Default: [ 'httpclose' ]
#
# $server::                 Declare a server in a backend.
#                           Default: undef
#                           Example:
#                             [
#                               'server first  10.1.1.1:1080 cookie first',
#                               'server second 10.1.1.2:1080 cookie second'
#                             ]
#
define haproxy::instance (
  $ensure          = present,
  $acl             = undef,
  $acl_backend     = undef,
  $acl_header      = undef,
  $balance         = 'source',
  $bind            = '*:80',
  $capture         = undef,
  $redirect        = undef,
  $default_backend = undef,
  $instance        = 'listen',
  $mode            = 'http',
  $option          = [ 'httpclose' ],
  $server          = undef,
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

  if $ensure == 'present' {
    concat::fragment { "haproxy.cfg_instance_${name}":
      target  => "${haproxy::config_dir}/haproxy.cfg",
      content => template("haproxy/instance_${instance}.erb"),
      order   => $order,
    }
  }
}

