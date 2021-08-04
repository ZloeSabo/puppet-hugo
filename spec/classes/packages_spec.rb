require 'spec_helper'
describe 'hugo::packages', type: :class do
  let(:params) do
    {
      manage_dependencies: true,
      dependencies: ['tar', 'other'],
      dependencies_ensure: 'present',
    }
  end

  it { is_expected.to contain_class('hugo::packages') }
  it { is_expected.to compile }

  context 'does not manage packages' do
    let(:params) do
      super().merge(manage_dependencies: false)
    end

    it { is_expected.not_to contain_package('tar') }
  end

  context 'installs packages' do
    it { is_expected.to contain_package('tar').with_ensure('present') }
    it { is_expected.to contain_package('other').with_ensure('present') }
  end

  context 'installs latest versions' do
    let(:params) do
      super().merge(dependencies_ensure: 'latest')
    end

    it { is_expected.to contain_package('tar').with_ensure('latest') }
    it { is_expected.to contain_package('other').with_ensure('latest') }
  end
end
