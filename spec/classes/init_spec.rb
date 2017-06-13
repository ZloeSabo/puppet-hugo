require 'spec_helper'

describe 'hugo', type: :class do
    context 'with default values for all parameters' do
        it { is_expected.to contain_class('hugo') }
        it { is_expected.to compile }
        it { is_expected.to contain_class('hugo::packages') }
        it { is_expected.to contain_class('hugo::install').that_requires('Class[hugo::packages]') }
        it { is_expected.to contain_class('hugo::compile').that_requires('Class[hugo::install]') }
    end
end
