require 'spec_helper'

describe 'haproxy', :type => :class do
  let(:pre_condition) { '$concat_basedir = "/tmp"' }
  let (:params) {
    {
      :config_dir => '/etc/haproxy'
    }
  }

  describe 'on Debian without parameters' do
    let (:facts) { debian_facts }

    it { should create_class('haproxy') }
    it { should include_class('haproxy::install') }
    it { should include_class('haproxy::config') }
    it { should include_class('haproxy::service') }

    it { should contain_package('haproxy').with_ensure('present') }

    it { should contain_file('/etc/haproxy/haproxy.cfg').with_ensure('present') }
    it { should contain_file('/etc/default/haproxy').with_ensure('present') }

    it { should contain_concat('/etc/haproxy/haproxy.cfg') }

    it { should contain_service('haproxy').with(
        'ensure'     => 'running',
        'enable'     => 'true',
        'hasrestart' => 'true'
      )
    }
  end

  describe 'on Debian with parameter: config_dir' do
    let (:facts) { debian_facts }
    let (:params) { { :config_dir => '_VALUE_' } }

    it { should contain_file('_VALUE_').with_ensure('directory') }
  end

  describe 'on Debian with parameter: config_dir_mode' do
    let (:facts) { debian_facts }
    let (:params) { { :config_dir_mode => '_VALUE_' } }

    it { should contain_file('/etc/haproxy').with_mode('_VALUE_') }
  end

  describe 'on Debian with parameter: config_dir_recurse' do
    let (:facts) { debian_facts }
    let (:params) { { :config_dir_recurse => '_VALUE_' } }

    it { should contain_file('/etc/haproxy').with_recurse('_VALUE_') }
  end

  describe 'on Debian with parameter: config_file_mode' do
    let (:facts) { debian_facts }
    let (:params) { { :config_file_mode => '_VALUE_' } }

    it { should contain_file('/etc/haproxy/haproxy.cfg').with_mode('_VALUE_') }
  end

  describe 'on Debian with parameter: config_group' do
    let (:facts) { debian_facts }
    let (:params) { { :config_group => '_VALUE_' } }

    it { should contain_file('/etc/haproxy').with_group('_VALUE_') }
  end

  describe 'on Debian with parameter: config_purge' do
    let (:facts) { debian_facts }
    let (:params) { { :config_purge => true } }

    it { should contain_file('/etc/haproxy').with_purge(true) }
  end

  describe 'on Debian with parameter: config_user' do
    let (:facts) { debian_facts }
    let (:params) { { :config_user => '_VALUE_' } }

    it { should contain_file('/etc/haproxy').with_owner('_VALUE_') }
  end

  describe 'on Debian with parameter: daemon_group' do
    let (:facts) { debian_facts }
    let (:params) {
      {
        :daemon_group => '_VALUE_',
        :log_dir => '_VALUE_'
      }
    }

    it { should contain_file('_VALUE_').with_group(/_VALUE_/) }
  end

  describe 'on Debian with parameter: daemon_user' do
    let (:facts) { debian_facts }
    let (:params) {
      {
        :daemon_user => '_VALUE_',
        :log_dir => '_VALUE_'
      }
    }

    it { should contain_file('_VALUE_').with_owner(/_VALUE_/) }
  end

  describe 'on Debian with parameter: log_dir' do
    let (:facts) { debian_facts }
    let (:params) { { :log_dir => '_VALUE_' } }

    it { should contain_file('_VALUE_').with_ensure('directory') }
  end

  describe 'on Debian with parameter: pkg_deps' do
    let (:facts) { debian_facts }
    let (:params) { { :pkg_deps => '_VALUE_' } }

    it { should contain_package('_VALUE_') }
  end

  describe 'on Debian with parameter: pkg_ensure' do
    let (:facts) { debian_facts }
    let (:params) { { :pkg_ensure => '_VALUE_' } }

    it { should contain_package('haproxy').with_ensure('_VALUE_') }
  end

  describe 'on Debian with parameter: pkg_list' do
    let (:facts) { debian_facts }
    let (:params) { { :pkg_list => '_VALUE_' } }

    it { should contain_package('_VALUE_') }
  end

  describe 'on Debian with parameter: service_dep' do
    let (:facts) { debian_facts }
    let (:params) { { :service_dep => '_VALUE_' } }

    it { should contain_service('_VALUE_') }
  end

  describe 'on Debian with parameter: service_enable' do
    let (:facts) { debian_facts }
    let (:params) { { :service_enable => '_VALUE_' } }

    it { should contain_service('haproxy').with_enable('_VALUE_') }
  end

  describe 'on Debian with parameter: service_ensure' do
    let (:facts) { debian_facts }
    let (:params) { { :service_ensure => '_VALUE_' } }

    it { should contain_service('haproxy').with_ensure('_VALUE_') }
  end

  describe 'on Debian with parameter: service_hasrestart' do
    let (:facts) { debian_facts }
    let (:params) { { :service_hasrestart => '_VALUE_' } }

    it { should contain_service('haproxy').with_hasrestart('_VALUE_') }
  end

  describe 'on Debian with parameter: service_hasstatus' do
    let (:facts) { debian_facts }
    let (:params) { { :service_hasstatus => '_VALUE_' } }

    it { should contain_service('haproxy').with_hasstatus('_VALUE_') }
  end

  describe 'on Debian with parameter: service_name' do
    let (:facts) { debian_facts }
    let (:params) { { :service_name => '_VALUE_' } }

    it { should contain_service('_VALUE_') }
  end

  describe 'on Debian with parameter: stats_auth_enable' do
    let (:facts) { debian_facts }
    let (:params) {
      {
        :stats_enable => true,
        :stats_auth_enable => '_VALUE_'
      }
    }

    it { should contain_concat__fragment('haproxy.cfg_stats').with_content(/stats auth/) }
  end

  describe 'on Debian with parameter: stats_auth_pass' do
    let (:facts) { debian_facts }
    let (:params) {
      {
        :stats_enable => true,
        :stats_auth_enable => '_VALUE_',
        :stats_auth_pass => '_VALUE_'
      }
    }

    it { should contain_concat__fragment('haproxy.cfg_stats').with_content(/stats auth.*:_VALUE_/) }
  end

  describe 'on Debian with parameter: stats_auth_user' do
    let (:facts) { debian_facts }
    let (:params) {
      {
        :stats_enable => true,
        :stats_auth_enable => '_VALUE_',
        :stats_auth_user => '_VALUE_'
      }
    }

    it { should contain_concat__fragment('haproxy.cfg_stats').with_content(/stats auth.*_VALUE_:/) }
  end

  describe 'on Debian with parameter: stats_enable' do
    let (:facts) { debian_facts }
    let (:params) { { :stats_enable => true } }

    it { should contain_concat__fragment('haproxy.cfg_stats') }
  end

  describe 'on Debian with parameter: stats_listen_address' do
    let (:facts) { debian_facts }
    let (:params) {
      {
        :stats_enable => true,
        :stats_auth_enable => '_VALUE_',
        :stats_listen_address => '_VALUE_'
      }
    }

    it { should contain_concat__fragment('haproxy.cfg_stats').with_content(/listen stats.*_VALUE_/) }
  end

  describe 'on Debian with parameter: stats_listen_port' do
    let (:facts) { debian_facts }
    let (:params) {
      {
        :stats_enable => true,
        :stats_auth_enable => '_VALUE_',
        :stats_listen_port => '_VALUE_'
      }
    }

    it { should contain_concat__fragment('haproxy.cfg_stats').with_content(/listen stats.*:_VALUE_$/) }
  end

  describe 'on Debian with parameter: stats_realm' do
    let (:facts) { debian_facts }
    let (:params) {
      {
        :stats_enable => true,
        :stats_auth_enable => '_VALUE_',
        :stats_realm => '_VALUE_'
      }
    }

    it { should contain_concat__fragment('haproxy.cfg_stats').with_content(/stats realm.*_VALUE_$/) }
  end

  describe 'on Debian with parameter: stats_url' do
    let (:facts) { debian_facts }
    let (:params) {
      {
        :stats_enable => true,
        :stats_auth_enable => '_VALUE_',
        :stats_url => '_VALUE_'
      }
    }

    it { should contain_concat__fragment('haproxy.cfg_stats').with_content(/stats uri.*_VALUE_$/) }
  end

  describe 'on Debian with parameter: defaults_clitimeout' do
    let (:facts) { debian_facts }
    let (:params) {
      {
        :defaults_clitimeout => '_VALUE_'
      }
    }

    it { should contain_concat__fragment('haproxy.cfg_defaults').with_content(/clitimeout.*_VALUE_$/) }
  end

  describe 'on Debian with parameter: defaults_contimeout' do
    let (:facts) { debian_facts }
    let (:params) {
      {
        :defaults_contimeout => '_VALUE_'
      }
    }

    it { should contain_concat__fragment('haproxy.cfg_defaults').with_content(/contimeout.*_VALUE_$/) }
  end

  describe 'on Debian with parameter: defaults_log' do
    let (:facts) { debian_facts }
    let (:params) {
      {
        :defaults_log => [ '_VALUE_' ]
      }
    }

    it { should contain_concat__fragment('haproxy.cfg_defaults').with_content(/log.*_VALUE_$/) }
  end

  describe 'on Debian with parameter: defaults_mode' do
    let (:facts) { debian_facts }
    let (:params) {
      {
        :defaults_mode => '_VALUE_'
      }
    }

    it { should contain_concat__fragment('haproxy.cfg_defaults').with_content(/mode.*_VALUE_$/) }
  end

  describe 'on Debian with parameter: defaults_option' do
    let (:facts) { debian_facts }
    let (:params) {
      {
        :defaults_option => [ '_VALUE_' ]
      }
    }

    it { should contain_concat__fragment('haproxy.cfg_defaults').with_content(/option.*_VALUE_$/) }
  end

  describe 'on Debian with parameter: defaults_retries' do
    let (:facts) { debian_facts }
    let (:params) {
      {
        :defaults_retries => '_VALUE_'
      }
    }

    it { should contain_concat__fragment('haproxy.cfg_defaults').with_content(/retries.*_VALUE_$/) }
  end

  describe 'on Debian with parameter: defaults_srvtimeout' do
    let (:facts) { debian_facts }
    let (:params) {
      {
        :defaults_srvtimeout => '_VALUE_'
      }
    }

    it { should contain_concat__fragment('haproxy.cfg_defaults').with_content(/srvtimeout.*_VALUE_$/) }
  end

  describe 'on Debian with parameter: global_chroot' do
    let (:facts) { debian_facts }

    context 'global_chroot => string' do
      let (:params) { { :global_chroot => '_VALUE_' } }

      it { should contain_concat__fragment('haproxy.cfg_global') }
      it { should contain_concat__fragment('haproxy.cfg_global').with_content(/chroot/) }
      it { should contain_file('_VALUE_').with_ensure('directory') }
    end

    context 'global_chroot => boolean' do
      let (:params) { { :global_chroot => true } }

      it do
        expect { should create_class('haproxy') }.to raise_error(Puppet::Error, /Wrong value for \$global_chroot/)
      end
    end
  end

  describe 'on Debian with parameter: global_daemon' do
    let (:facts) { debian_facts }
    let (:params) {
      {
        :global_chroot => '_VALUE_',
        :global_daemon => true
      }
    }

    it { should contain_concat__fragment('haproxy.cfg_global').with_content(/daemon/) }
  end

  describe 'on Debian with parameter: global_debug' do
    let (:facts) { debian_facts }
    let (:params) {
      {
        :global_chroot => '_VALUE_',
        :global_debug => true
      }
    }

    it { should contain_concat__fragment('haproxy.cfg_global').with_content(/debug/) }
  end

  describe 'on Debian with parameter: global_log' do
    let (:facts) { debian_facts }
    let (:params) {
      {
        :global_chroot => '_VALUE_',
        :global_log => [ '_VALUE_' ]
      }
    }

    it { should contain_concat__fragment('haproxy.cfg_global').with_content(/_VALUE_/) }
  end

  describe 'on Debian with parameter: global_maxconn' do
    let (:facts) { debian_facts }
    let (:params) {
      {
        :global_chroot => '_VALUE_',
        :global_maxconn => '_VALUE_'
      }
    }

    it { should contain_concat__fragment('haproxy.cfg_global').with_content(/maxconn.*_VALUE_/) }
  end

  describe 'on Debian with parameter: global_nbproc' do
    let (:facts) { debian_facts }
    let (:params) {
      {
        :global_chroot => '_VALUE_',
        :global_nbproc => '_VALUE_'
      }
    }

    it { should contain_concat__fragment('haproxy.cfg_global').with_content(/nbproc.*_VALUE_/) }
  end

  describe 'on Debian with parameter: global_quiet' do
    let (:facts) { debian_facts }
    let (:params) {
      {
        :global_chroot => '_VALUE_',
        :global_quiet => true
      }
    }

    it { should contain_concat__fragment('haproxy.cfg_global').with_content(/quiet/) }
  end

  describe 'on Debian with parameter: global_stats_socket' do
    let (:facts) { debian_facts }
    let (:params) {
      {
        :global_chroot => '_VALUE_',
        :global_stats_socket => '_VALUE_'
      }
    }

    it { should contain_concat__fragment('haproxy.cfg_global').with_content(/stats socket.*_VALUE_$/) }
  end
end

