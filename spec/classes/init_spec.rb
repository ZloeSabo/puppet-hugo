require 'spec_helper'

# Those are not in context of current test
RSpec::Puppet::Coverage.filters.push('Exec[compile:/tmp/somesource:/tmp/compiled]')
RSpec::Puppet::Coverage.filters.push('File[version_lock:/tmp/somesource:/tmp/compiled:someversion]')

describe 'hugo', type: :class do
  context 'with default values for all parameters' do
    it { is_expected.to contain_class('hugo') }
    it { is_expected.to compile }
    it { is_expected.to contain_class('hugo::packages') }
    it { is_expected.to contain_class('hugo::install').that_requires('Class[hugo::packages]') }
  end

  context 'creates compilation resources' do
    let(:params) do
      {
        sites: {
          'site1' => {
            'target' => '/tmp/compiled',
            'source'  => '/tmp/somesource',
            'version' => 'someversion'
          }
        },
        compile_defaults: {
          'hugo_executable' => '/a/b/hugo',
          'refreshonly' => false
        }
      }
    end

    it do
      is_expected.to contain_hugo__resource__compile('site1').with(
        hugo_executable: '/a/b/hugo',
        refreshonly: false,
        target: '/tmp/compiled',
        source: '/tmp/somesource'
      )
    end
  end
end
