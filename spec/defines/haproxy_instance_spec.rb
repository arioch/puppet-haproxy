require 'spec_helper'

describe 'haproxy::instance', :type => :define do
  let (:pre_condition) { '$concat_basedir = "/tmp"' }

  context 'on Debian without parameters' do
    let (:facts) { debian_facts }
    let (:title) { '_VALUE_' }

    it do
      expect { should create_class('haproxy') }.to raise_error(Puppet::Error)
    end
  end

  context 'on Debian with parameter: ensure' do
    let (:facts) { debian_facts }
    let (:title) { '_NAME_' }
    let (:params) { {
      :ensure => '_VALUE_',
      :default_backend => '',
      :server => [],
    } }

    it { should create_haproxy__instance('_NAME_') }
    it { should contain_concat__fragment('haproxy.cfg_instance__NAME_').with_ensure(/_VALUE_/) }
  end

end

