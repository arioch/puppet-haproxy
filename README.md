# Puppet HAProxy

## Requirements

* [concat module](https://github.com/ripienaar/puppet-concat)
* Puppetlabs [apt module](https://github.com/puppetlabs/puppetlabs-apt) or
* Camptocamp [apt module](https://github.com/camptocamp/puppet-apt)

## Tested on...

* Debian 6 (Squeeze)

## Example usage

### Install HAProxy

    node /box/ {
      include haproxy
    }

