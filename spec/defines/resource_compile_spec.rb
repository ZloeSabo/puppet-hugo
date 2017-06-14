require 'spec_helper'
describe 'hugo::resource::compile', type: :define do
    let(:title) { 'compile static website' }

    let(:params) do
        {
            :source => '/a/b/source',
            :target => '/a/b/target',
            :refreshonly => true,
            :additional_arguments => 'arguments',
            :hugo_executable => '/a/b/hugo'
        }
    end

    context 'executes compilation using provided hugo executable' do
      it { is_expected.to contain_exec('compile:/a/b/source').with_command('/a/b/hugo -s /a/b/source -d /a/b/target arguments') }
    end

    [true, false].each do |refreshonlyflag|
        context 'makes compilation refreshonly => #{refreshonlyflag}' do
            let(:params) do 
                super().merge({:refreshonly => refreshonlyflag})
            end
            it { is_expected.to contain_exec('compile:/a/b/source').with_refreshonly(refreshonlyflag) }
        end
    end
end
