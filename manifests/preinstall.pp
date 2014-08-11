# == Class: haproxy::preinstall
#
class haproxy::preinstall {
  if $::haproxy::manage_repo {
    case $::osfamily {
      'Debian': {
        $key = '353525F9'
        apt::key { $key:
          ensure => present,
          notify => Exec['haproxy::preinstall::apt-get update'],
        }

        if defined('apt::sources_list') {
          # Camp2Camp/apt module
          # apt::sources_list { 'haproxy':
          #   ensure  => present,
          #   content => template ("${module_name}/repo/sources.list.erb"),
          #   notify  => Exec['haproxy::preinstall::apt-get update'],
          #   require => Apt::Key[$key],
          #   source  => false,
          # }
        }

        if defined('apt::source') {
          # Puppetlabs/apt module
          apt::source { 'haproxy':
            ensure      => present,
            include_src => false,
            key         => $key,
            key_source  => 'http://haproxy.debian.net/bernat.debian.org.gpg',
            location    => 'http://haproxy.debian.net',
            notify      => Exec['haproxy::preinstall::apt-get update'],
            pin         => '200',
            release     => 'wheezy-backports',
            repos       => 'main',
            require     => Apt::Key[$key],
          }
        }

        exec { 'haproxy::preinstall::apt-get update':
          command     => 'apt-get update',
          path        => '/usr/bin',
          refreshonly => true,
        }
      }

      default: {
        fail "Preinstall enabled but ${::oparatingsystem} is not supported yet."
      }
    }
  }
}
