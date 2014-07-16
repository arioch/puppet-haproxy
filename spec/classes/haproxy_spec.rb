require 'spec_helper'

describe 'haproxy', :type => :class do
  let(:pre_condition) { '$concat_basedir = "/tmp"' }
  let (:params) {
    {
      :config_dir => '/etc/haproxy'
    }
  }

  describe 'without parameters' do
    let (:facts) { debian_facts }

    it { should create_class('haproxy') }
    it { should contain_class('haproxy::install') }
    it { should contain_class('haproxy::config') }
    it { should contain_class('haproxy::service') }

    it { should contain_package('haproxy').with_ensure('present') }

    it { should contain_concat('/etc/haproxy/haproxy.cfg') }
    it { should contain_file('/etc/default/haproxy').with_ensure('present') }
    it { should contain_file('/etc/haproxy/haproxy.cfg').with(
        'ensure' => 'present'
      )
    }

    it { should contain_service('haproxy').with(
        'ensure'     => 'running',
        'enable'     => 'true',
        'hasrestart' => 'true'
      )
    }
  end

  describe 'with parameter: config_dir' do
    let (:facts) { debian_facts }
    let (:params) { { :config_dir => '/config/dir' } }

    it { should contain_file('/config/dir').with_ensure('directory') }
  end

  describe 'with parameter: config_dir_mode' do
    let (:facts) { debian_facts }
    let (:params) { { :config_dir_mode => '0777' } }

    it { should contain_file('/etc/haproxy').with_mode('0777') }
  end

  describe 'with parameter: config_dir_recurse' do
    let (:facts) { debian_facts }
    let (:params) { { :config_dir_recurse => '_VALUE_' } }

    it { should contain_file('/etc/haproxy').with_recurse('_VALUE_') }
  end

  describe 'with parameter: config_file_mode' do
    let (:facts) { debian_facts }
    let (:params) { { :config_file_mode => '_VALUE_' } }

    it { should contain_file('/etc/haproxy/haproxy.cfg').with_mode('_VALUE_') }
  end

  describe 'with parameter: config_group' do
    let (:facts) { debian_facts }
    let (:params) { { :config_group => '_VALUE_' } }

    it { should contain_file('/etc/haproxy').with_group('_VALUE_') }
  end

  describe 'with parameter: config_purge' do
    let (:facts) { debian_facts }
    let (:params) { { :config_purge => true } }

    it { should contain_file('/etc/haproxy').with_purge(true) }
  end

  describe 'with parameter: config_user' do
    let (:facts) { debian_facts }
    let (:params) { { :config_user => '_VALUE_' } }

    it { should contain_file('/etc/haproxy').with_owner('_VALUE_') }
  end

  describe 'with parameter: daemon_group' do
    let (:facts) { debian_facts }
    let (:params) {
      {
        :daemon_group => '_VALUE_',
        :log_dir => '_VALUE_'
      }
    }

    it { should contain_file('_VALUE_').with_group(/_VALUE_/) }
  end

  describe 'with parameter: daemon_user' do
    let (:facts) { debian_facts }
    let (:params) {
      {
        :daemon_user => '_VALUE_',
        :log_dir => '_VALUE_'
      }
    }

    it { should contain_file('_VALUE_').with_owner(/_VALUE_/) }
  end

  describe 'with parameter: log_dir' do
    let (:facts) { debian_facts }
    let (:params) { { :log_dir => '_VALUE_' } }

    it { should contain_file('_VALUE_').with_ensure('directory') }
  end

  describe 'with parameter: pkg_deps' do
    let (:facts) { debian_facts }
    let (:params) { { :pkg_deps => '_VALUE_' } }

    it { should contain_package('_VALUE_') }
  end

  describe 'with parameter: pkg_ensure' do
    let (:facts) { debian_facts }
    let (:params) { { :pkg_ensure => '_VALUE_' } }

    it { should contain_package('haproxy').with_ensure('_VALUE_') }
  end

  describe 'with parameter: pkg_list' do
    let (:facts) { debian_facts }
    let (:params) { { :pkg_list => '_VALUE_' } }

    it { should contain_package('_VALUE_') }
  end

  describe 'with parameter: service_dep' do
    let (:facts) { debian_facts }
    let (:params) { { :service_dep => '_VALUE_' } }

    it { should contain_service('_VALUE_') }
  end

  describe 'with parameter: service_enable' do
    let (:facts) { debian_facts }
    let (:params) { { :service_enable => '_VALUE_' } }

    it { should contain_service('haproxy').with_enable('_VALUE_') }
  end

  describe 'with parameter: service_ensure' do
    let (:facts) { debian_facts }
    let (:params) { { :service_ensure => '_VALUE_' } }

    it { should contain_service('haproxy').with_ensure('_VALUE_') }
  end

  describe 'with parameter: service_hasrestart' do
    let (:facts) { debian_facts }
    let (:params) { { :service_hasrestart => '_VALUE_' } }

    it { should contain_service('haproxy').with_hasrestart('_VALUE_') }
  end

  describe 'with parameter: service_hasstatus' do
    let (:facts) { debian_facts }
    let (:params) { { :service_hasstatus => '_VALUE_' } }

    it { should contain_service('haproxy').with_hasstatus('_VALUE_') }
  end

  describe 'with parameter: service_name' do
    let (:facts) { debian_facts }
    let (:params) { { :service_name => '_VALUE_' } }

    it { should contain_service('_VALUE_') }
  end

  describe 'with parameter: stats_auth_enable' do
    let (:facts) { debian_facts }
    let (:params) {
      {
        :stats_enable => true,
        :stats_auth_enable => '_VALUE_'
      }
    }

    it { should contain_concat__fragment('haproxy.cfg_stats').with(
        'content' => /stats auth/
      )
    }
  end

  describe 'with parameter: stats_auth_pass' do
    let (:facts) { debian_facts }
    let (:params) {
      {
        :stats_enable => true,
        :stats_auth_enable => '_VALUE_',
        :stats_auth_pass => '_VALUE_'
      }
    }

    it { should contain_concat__fragment('haproxy.cfg_stats').with(
        'content' => /stats auth.*:_VALUE_/
      )
    }
  end

  describe 'with parameter: stats_auth_user' do
    let (:facts) { debian_facts }
    let (:params) {
      {
        :stats_enable => true,
        :stats_auth_enable => '_VALUE_',
        :stats_auth_user => '_VALUE_'
      }
    }

    it { should contain_concat__fragment('haproxy.cfg_stats').with(
        'content' => /stats auth.*_VALUE_:/
      )
    }
  end

  describe 'with parameter: stats_enable' do
    let (:facts) { debian_facts }
    let (:params) { { :stats_enable => true } }

    it { should contain_concat__fragment('haproxy.cfg_stats') }
  end

  describe 'with parameter: stats_listen_address' do
    let (:facts) { debian_facts }
    let (:params) {
      {
        :stats_enable => true,
        :stats_auth_enable => '_VALUE_',
        :stats_listen_address => '_VALUE_'
      }
    }

    it { should contain_concat__fragment('haproxy.cfg_stats').with(
        'content' => /listen stats.*_VALUE_/
      )
    }
  end

  describe 'with parameter: stats_listen_port' do
    let (:facts) { debian_facts }
    let (:params) {
      {
        :stats_enable => true,
        :stats_auth_enable => '_VALUE_',
        :stats_listen_port => '_VALUE_'
      }
    }

    it { should contain_concat__fragment('haproxy.cfg_stats').with(
        'content' => /listen stats.*:_VALUE_$/
      )
    }
  end

  describe 'with parameter: stats_realm' do
    let (:facts) { debian_facts }
    let (:params) {
      {
        :stats_enable => true,
        :stats_auth_enable => '_VALUE_',
        :stats_realm => '_VALUE_'
      }
    }

    it { should contain_concat__fragment('haproxy.cfg_stats').with(
        'content' => /stats realm.*_VALUE_$/
      )
    }
  end

  describe 'with parameter: stats_url' do
    let (:facts) { debian_facts }
    let (:params) {
      {
        :stats_enable => true,
        :stats_auth_enable => '_VALUE_',
        :stats_url => '_VALUE_'
      }
    }

    it { should contain_concat__fragment('haproxy.cfg_stats').with(
        'content' => /stats uri.*_VALUE_$/
      )
    }
  end

  describe 'with parameter: defaults_clitimeout' do
    let (:facts) { debian_facts }
    let (:params) { { :defaults_clitimeout => '_VALUE_' } }

    it { should contain_concat__fragment('haproxy.cfg_defaults').with(
        'content' => /timeout.*_VALUE_$/
      )
    }
  end

  describe 'with parameter: defaults_contimeout' do
    let (:facts) { debian_facts }
    let (:params) { { :defaults_contimeout => '_VALUE_' } }

    it { should contain_concat__fragment('haproxy.cfg_defaults').with(
        'content' => /timeout.*_VALUE_$/
      )
    }
  end

  describe 'with parameter: defaults_log' do
    let (:facts) { debian_facts }
    let (:params) { { :defaults_log => [ '_VALUE_' ] } }

    it { should contain_concat__fragment('haproxy.cfg_defaults').with(
        'content' => /log.*_VALUE_$/
      )
    }
  end

  describe 'with parameter: defaults_option' do
    let (:facts) { debian_facts }
    let (:params) { { :defaults_option => [ '_VALUE_' ] } }

    it { should contain_concat__fragment('haproxy.cfg_defaults').with(
        'content' => /option.*_VALUE_$/
      )
    }
  end

  describe 'with parameter: defaults_retries' do
    let (:facts) { debian_facts }
    let (:params) { { :defaults_retries => '_VALUE_' } }

    it { should contain_concat__fragment('haproxy.cfg_defaults').with(
        'content' => /retries.*_VALUE_$/
      )
    }
  end

  describe 'with parameter: defaults_srvtimeout' do
    let (:facts) { debian_facts }
    let (:params) { { :defaults_srvtimeout => '_VALUE_' } }

    it { should contain_concat__fragment('haproxy.cfg_defaults').with(
        'content' => /timeout.*_VALUE_$/
      )
    }
  end

  describe 'with parameter: global_chroot' do
    let (:facts) { debian_facts }

    context 'global_chroot => valid path' do
      let (:params) { { :global_chroot => '/chroot' } }

      it { should contain_file('/chroot').with_ensure('directory') }
      it { should contain_concat__fragment('haproxy.cfg_global') }
      it { should contain_concat__fragment('haproxy.cfg_global').with(
          'content' => /chroot/
        )
      }
    end

    context 'global_chroot => boolean' do
      let (:params) { { :global_chroot => true } }

      it do
        expect { should create_class('haproxy') }.to \
          raise_error(Puppet::Error, /Wrong value/)
      end
    end

    context 'global_chroot => erroneous path' do
      let (:params) { { :global_chroot => '_VALUE_' } }

      it do
        expect { should create_class('haproxy') }.to \
          raise_error(Puppet::Error, /.*not an absolute path.*/)
      end
    end
  end

  describe 'with parameter: global_daemon' do
    let (:facts) { debian_facts }
    let (:params) {
      {
        :global_chroot => '/chroot',
        :global_daemon => true
      }
    }

    it { should contain_concat__fragment('haproxy.cfg_global').with(
        'content' => /daemon/
      )
    }
  end

  describe 'with parameter: global_debug' do
    let (:facts) { debian_facts }
    let (:params) {
      {
        :global_chroot => '/chroot',
        :global_debug => true
      }
    }

    it { should contain_concat__fragment('haproxy.cfg_global').with(
        'content' => /debug/
      )
    }
  end

  describe 'with parameter: global_log' do
    let (:facts) { debian_facts }
    let (:params) {
      {
        :global_chroot => '/chroot',
        :global_log => [ '_VALUE_' ]
      }
    }

    it { should contain_concat__fragment('haproxy.cfg_global').with(
        'content' => /_VALUE_/
      )
    }
  end

  describe 'with parameter: global_maxconn' do
    let (:facts) { debian_facts }
    let (:params) {
      {
        :global_chroot => '/chroot',
        :global_maxconn => '_VALUE_'
      }
    }

    it { should contain_concat__fragment('haproxy.cfg_global').with(
        'content' => /maxconn.*_VALUE_/
      )
    }
  end

  describe 'with parameter: global_nbproc' do
    let (:facts) { debian_facts }
    let (:params) {
      {
        :global_chroot => '/chroot',
        :global_nbproc => '_VALUE_'
      }
    }

    it { should contain_concat__fragment('haproxy.cfg_global').with(
        'content' => /nbproc.*_VALUE_/
      )
    }
  end

  describe 'with parameter: global_quiet' do
    let (:facts) { debian_facts }
    let (:params) {
      {
        :global_chroot => '/chroot',
        :global_quiet => true
      }
    }

    it { should contain_concat__fragment('haproxy.cfg_global').with(
        'content' => /quiet/
      )
    }
  end

  describe 'with parameter: global_stats_socket' do
    let (:facts) { debian_facts }
    let (:params) {
      {
        :global_chroot => '/chroot',
        :global_stats_socket => '_VALUE_'
      }
    }

    it { should contain_concat__fragment('haproxy.cfg_global').with(
        'content' => /stats.*socket.*_VALUE_$/
      )
    }
  end

  describe 'with parameter: global_ulimit' do
    let (:facts) { debian_facts }
    let (:params) { { :global_ulimit => '_VALUE_' } }

    it { should contain_concat__fragment('haproxy.cfg_global').with(
        'content' => /ulimit-n.*_VALUE_$/
      )
    }
  end
end

