require 'spec_helper'
describe 'hugo::install', type: :class do
  let(:params) do
    {
      manage_package: true,
      package_ensure: 'present',
      installation_directory: '/usr/local/bin',
      version: '1.2.3',
      owner: 'owner',
      group: 'group',
      mode: 'ug=rw,o=r,a=x'
    }
  end

  context 'installs hugo executable' do
    it { is_expected.to contain_class('hugo::install') }
    it { is_expected.to compile }
    it { is_expected.to contain_exec('install:/usr/local/bin/hugo').with_refreshonly(true) }
    it { is_expected.to contain_file('/usr/local/bin/hugo').that_requires('Exec[install:/usr/local/bin/hugo]') }
    it { is_expected.to contain_remote_file('hugo').that_notifies('Exec[install:/usr/local/bin/hugo]') }
  end

  context 'does not manage hugo executable when asked' do
    let(:params) do
      super().merge(manage_package: false)
    end

    it { is_expected.not_to contain_remote_file('hugo') }
  end

  on_supported_os(hardwaremodels: %w[x86_64 x86]).each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      context 'installs os specific executable' do
        kernel = facts[:kernel]
        arch = facts[:hardwaremodel] == 'x86' ? '32' : '64'
        source = "https://github.com/spf13/hugo/releases/download/v1.2.3/hugo_1.2.3_#{kernel}-#{arch}bit.tar.gz"
        it { is_expected.to contain_remote_file('hugo').with_source(source) }
      end
    end
  end
end
