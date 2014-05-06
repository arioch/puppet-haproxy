require 'spec_helper'

describe 'haproxy::instance', :type => :define do
  let (:pre_condition) { '$concat_basedir = "/tmp"' }

  describe 'without parameters' do
    let (:facts) { debian_facts }
    let (:title) { '_VALUE_' }

    it do
      expect { should create_class('haproxy') }.to raise_error(Puppet::Error)
    end
  end

  describe 'with parameter: ensure' do
    context 'ensure => present' do
      let (:facts) { debian_facts }
      let (:title) { '_NAME_' }
      let (:params) {
        {
          :default_backend => '',
          :server => [],
          :ensure => 'present',
        }
      }

      it { should create_haproxy__instance('_NAME_') }
      it { should contain_concat__fragment('haproxy.cfg_instance__NAME_') }
    end

    context 'ensure => present' do
      let (:facts) { debian_facts }
      let (:title) { '_NAME_' }
      let (:params) {
        {
          :default_backend => '',
          :server => [],
          :ensure => '_VALUE_',
        }
      }

      it { should create_haproxy__instance('_NAME_') }
      it { should_not contain_concat__fragment('haproxy.cfg_instance__NAME_') }
    end
  end

  describe 'with parameter: acl' do
    let (:facts) { debian_facts }
    let (:title) { '_NAME_' }
    let (:params) {
      {
        :acl => 'acl_pool1',
        :default_backend => '',
        :server => [],
      }
    }

    it { should create_haproxy__instance('_NAME_') }
    it { should_not contain_concat__fragment('haproxy.cfg_instance__NAME_').with(
        'content' => /acl_pool1/
      )
    }
  end

  describe 'with parameter: acl_backend' do
    let (:facts) { debian_facts }
    let (:title) { '_NAME_' }
    let (:params) {
      {
        :acl => 'acl_pool1',
        :acl_backend => '_BACKEND_',
        :default_backend => '',
        :server => [],
      }
    }

    it { should create_haproxy__instance('_NAME_') }
    it { should_not contain_concat__fragment('haproxy.cfg_instance__NAME_').with(
        'content' => /acl_pool1/,
        'content' => /_BACKEND_/
      )
    }
  end

  describe 'with parameter: acl_header' do
    let (:facts) { debian_facts }
    let (:title) { '_NAME_' }
    let (:params) {
      {
        :acl => 'acl_pool1',
        :acl_header => '_HEADER_',
        :default_backend => '',
        :server => [],
      }
    }

    it { should create_haproxy__instance('_NAME_') }
    it { should_not contain_concat__fragment('haproxy.cfg_instance__NAME_').with(
        'content' => /acl_pool1/,
        'content' => /_HEADER_/
      )
    }
  end

  describe 'with parameter: balance' do
    let (:facts) { debian_facts }
    let (:title) { '_NAME_' }
    let (:params) {
      {
        :balance => '_VALUE_',
        :default_backend => '',
        :server => [],
      }
    }

    it { should create_haproxy__instance('_NAME_') }
    it { should contain_concat__fragment('haproxy.cfg_instance__NAME_').with(
        'content' => /_VALUE_/
      )
    }
  end

  describe 'with parameter: bind' do
    let (:facts) { debian_facts }
    let (:title) { '_NAME_' }
    let (:params) {
      {
        :bind => '_VALUE_',
        :default_backend => '',
        :server => [],
      }
    }

    it { should create_haproxy__instance('_NAME_') }
    it { should contain_concat__fragment('haproxy.cfg_instance__NAME_').with(
        'content' => /_VALUE_/
      )
    }
  end

  describe 'with parameter: default_backend' do
    context 'instance => listen' do
      let (:facts) { debian_facts }
      let (:title) { '_NAME_' }
      let (:params) { {
        :default_backend => '_VALUE_',
        :instance => 'listen',
        :server => [],
      } }

      it { should create_haproxy__instance('_NAME_') }
      it { should_not \
        contain_concat__fragment('haproxy.cfg_instance__NAME_').with(
          'content' => /_VALUE_/
        )
      }
    end

    context 'instance => frontend' do
      let (:facts) { debian_facts }
      let (:title) { '_NAME_' }
      let (:params) {
        {
          :default_backend => '_VALUE_',
          :instance => 'frontend',
          :server => [],
        }
      }

      it { should create_haproxy__instance('_NAME_') }
      it { should contain_concat__fragment('haproxy.cfg_instance__NAME_').with(
          'content' => /_VALUE_/
        )
      }
    end

    context 'instance => backend' do
      let (:facts) { debian_facts }
      let (:title) { '_NAME_' }
      let (:params) { {
        :default_backend => '_VALUE_',
        :instance => 'backend',
        :server => [],
      } }

      it { should create_haproxy__instance('_NAME_') }
      it { should_not \
        contain_concat__fragment('haproxy.cfg_instance__NAME_').with(
          'content' => /_VALUE_/
        )
      }
    end
  end

  describe 'with parameter: mode' do
    let (:facts) { debian_facts }
    let (:title) { '_NAME_' }
    let (:params) { {
      :mode => '_VALUE_',
      :default_backend => '',
      :server => [],
    } }

    it { should create_haproxy__instance('_NAME_') }
    it { should contain_concat__fragment('haproxy.cfg_instance__NAME_').with(
        'content' => /_VALUE_/
      )
    }
  end

  describe 'with parameter: option' do
    let (:facts) { debian_facts }
    let (:title) { '_NAME_' }
    let (:params) { {
      :option => [ '_VALUE_' ],
      :default_backend => '',
      :server => [],
    } }

    it { should create_haproxy__instance('_NAME_') }
    it { should contain_concat__fragment('haproxy.cfg_instance__NAME_').with(
        'content' => /_VALUE_/
      )
    }
  end

  describe 'with parameter: server' do
    context 'instance => listen' do
      let (:facts) { debian_facts }
      let (:title) { '_NAME_' }
      let (:params) {
        {
          :instance => 'listen',
          :default_backend => '',
          :server => [ '_VALUE_' ],
        }
      }

      it { should create_haproxy__instance('_NAME_') }
      it { should contain_concat__fragment('haproxy.cfg_instance__NAME_').with(
          'content' => /_VALUE_/
        )
      }
    end

    context 'instance => frontend' do
      let (:facts) { debian_facts }
      let (:title) { '_NAME_' }
      let (:params) {
        {
          :instance => 'frontend',
          :default_backend => '',
          :server => [ '_VALUE_' ],
        }
      }

      it { should create_haproxy__instance('_NAME_') }
      it { should_not contain_concat__fragment('haproxy.cfg_instance__NAME_').with(
          'content' => /_VALUE_/
        )
      }
    end

    context 'instance => backend' do
      let (:facts) { debian_facts }
      let (:title) { '_NAME_' }
      let (:params) {
        {
          :instance => 'backend',
          :default_backend => '',
          :server => [ '_VALUE_' ],
        }
      }

      it { should create_haproxy__instance('_NAME_') }
      it { should contain_concat__fragment('haproxy.cfg_instance__NAME_').with(
          'content' => /_VALUE_/
        )
      }
    end
  end
end

