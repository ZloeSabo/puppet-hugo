require 'spec_helper'

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
                :sites => {
                    'site1' => {
                        'target' => '/tmp/compiled',
                        'source' => '/tmp/somesource'
                    }
                },
                :compile_defaults => {
                    'hugo_executable' => '/a/b/hugo',
                    'refreshonly'     => false
                }
            }
        end

        it do 
            is_expected.to contain_hugo__resource__compile('site1').with(
                {
                    :hugo_executable => '/a/b/hugo',
                    :refreshonly     => false,
                    :target          => '/tmp/compiled',
                    :source          => '/tmp/somesource'
                }
            )
        end
    end
end
