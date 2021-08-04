require 'spec_helper_acceptance'

describe 'hugo class:' do
  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'works idempotently with no errors' do
      pp = <<-EOS
      class { 'hugo': }
      EOS

      idempotent_apply(pp)
    end

    describe file('/usr/local/bin/hugo') do
      it { is_expected.to be_executable }
    end

    describe command('hugo version') do
      its(:stdout) { is_expected.to match %r{Hugo Static Site Generator} }
      its(:exit_status) { is_expected.to eq 0 }
    end
  end
end
