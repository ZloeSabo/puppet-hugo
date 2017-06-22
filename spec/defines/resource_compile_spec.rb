require 'spec_helper'
describe 'hugo::resource::compile', type: :define do
  let(:title) { 'compile static website' }

  let(:params) do
    {
      source: '/a/b/source',
      target: '/a/b/target',
      version: 'someversion',
      refreshonly: true,
      additional_arguments: 'arguments',
      hugo_executable: '/a/b/hugo'
    }
  end

  context 'executes compilation using provided hugo executable' do
    it { is_expected.to contain_exec('compile:/a/b/source:/a/b/target').with_command('/a/b/hugo -s /a/b/source -d /a/b/target arguments') }
  end

  context 'has a source and target dependent version lock' do
    it do
      is_expected.to contain_file('version_lock:/a/b/source:/a/b/target:someversion').with(
        content: 'someversion',
        path: '/tmp/hugo-lock-_a_b_source-_a_b_target'
      ).that_notifies('Exec[compile:/a/b/source:/a/b/target]')
    end
  end

  [true, false].each do |refreshonlyflag|
    context 'makes compilation refreshonly => #{refreshonlyflag}' do
      let(:params) do
        super().merge(refreshonly: refreshonlyflag)
      end

      it { is_expected.to contain_exec('compile:/a/b/source:/a/b/target').with_refreshonly(refreshonlyflag) }
    end
  end
end
