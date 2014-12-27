# Puppet HAProxy

## Build status

[![Build Status](https://travis-ci.org/arioch/puppet-haproxy.png?branch=master)](https://travis-ci.org/arioch/puppet-haproxy)

## Requirements

* [concat module](https://github.com/ripienaar/puppet-concat)
* [stdlib module](https://github.com/puppetlabs/puppetlabs-stdlib)

## Tested on...

* Debian 6 (Squeeze)
* Debian 7 (Wheezy)

## Example usage

### Install HAProxy

```
node /box/ {
  include haproxy
}
```

### Adjust configuration settings

```
node /box/ {
  class { 'haproxy':
    defaults_maxconn => '32768',
    global_chroot    => '/usr/share/haproxy',
    global_nbproc    => '2',
    global_ulimit    => '65548',
  }
}
```

### Create split frontend instance

```
haproxy::instance { 'http-in':
  instance        => 'frontend',
  bind            => '*:80',
  default_backend => 'pool1',
}
```

### Create split frontend instance, with ACL

```
haproxy::instance { 'http-in':
  instance        => 'frontend',
  bind            => '*:80',
  default_backend => 'pool1',
  acl             => 'acl_pool1',
  acl_header      => 'example.org',
  acl_backend     => 'pool1',
}
```

### Create split backend instance

```
haproxy::instance { 'pool1':
  instance => 'backend',
  balance  => 'roundrobin',
  option   => [ 'http-server-close', 'checkcache' ],
  server   => [
    'inst1 10.0.1.10:80'
    'inst2 10.0.1.20:80'
  ],
}
```

### Create combined listen instance

```
haproxy::instance { 'pool2':
  instance => 'listen',
  bind     => '0.0.0.0:80',
  mode     => 'http',
  option   => 'persist',
  balance  => 'roundrobin',
  server   => [
    'inst1 10.0.2.10:80',
    'inst2 10.0.2.20:80',
  ],
}
```

### Enable HAProxy stats page

```
class { 'haproxy':
  stats_enable         => true,
  stats_listen_address => '0.0.0.0',
  stats_listen_port    => '8000',
}
```

### Enable HAProxy stats page with authentication

```
class { 'haproxy':
  stats_enable      => true,
  stats_auth_enable => true,
  stats_auth_user   => 'haproxy',
  stats_auth_pass   => 'haproxy',
}
```

### Specify a different command for reloading HAProxy instead of restarting.

```
class { 'haproxy':
  service_hasrestart => false,
  service_restart    => '/usr/sbin/service haproxy reload'
}
```

### Add custom logging options to manage log fields

```
haproxy::instance { 'pool2':
  instance => 'listen',
  capture  => [
    'request header Host len 40',
    'request header X-Forwarded-For len 50',
    'request header Accept-Language len 50',
    'request header Referer len 200',
    'request header User-Agent len 200',
    'response header Content-Type len 30',
    'response header Content-Encoding len 10',
    'response header Cache-Control len 200',
    'response header Last-Modified len 200',
  ],
```

### Redirect rules on frontend instance

First, make http frontend with redirect rules:

```
haproxy::instance { 'http_in':
  listen   => '*:80',
  mode     => 'http',
  instance => 'frontend',
  redirect => [ 
    'scheme https if { hdr(Host) -i www.example.com } !{ ssl_fc }',
    'scheme https if { hdr(Host) -i example.com } !{ ssl_fc }',
    'location https://www.example.com',
  ]
}
```

Then, make an https frontend for redirect to:

```
haproxy::instance { 'https_in':
  listen          => '*:443 ssl crt /etc/haproxy/ssl/example.com.pem',
  mode            => 'http',
  instance        => 'frontend',
  default_backend => 'backend'
}
```

### Manage package repository

```
class { 'haproxy':
  manage_repo => true,
}
```

## Unit testing

Plain RSpec:

```
$ rake spec
```

Using bundle:

```
$ bundle exec rake spec
```

Test against a specific Puppet or Facter version:

```
$ PUPPET_VERSION=3.2.1  bundle update && bundle exec rake spec
$ PUPPET_VERSION=2.7.19 bundle update && bundle exec rake spec
$ FACTER_VERSION=1.6.8  bundle update && bundle exec rake spec
```

