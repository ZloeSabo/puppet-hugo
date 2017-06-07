require 'spec_helper'
describe 'hugo' do
  context 'with default values for all parameters' do
    it { should contain_class('hugo') }
  end
end
