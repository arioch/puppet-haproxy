# Define: haproxy::instance
#
define haproxy::instance (
  $ensure          = present,
  $instance        = 'listen',
  $bind            = '*:80',
  $mode            = 'http',
  $option          = undef,
  $default_backend = undef,
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

  concat::fragment { "haproxy.conf_instance_${name}":
    ensure  => $ensure,
    target  => "${haproxy::config_dir}/haproxy.conf",
    content => template("haproxy/instance_${instance}.erb"),
    order   => $order,
  }
}

