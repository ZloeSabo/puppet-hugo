#require 'beaker-rspec'
require 'voxpupuli/acceptance/spec_helper_acceptance'

configure_beaker do |host|
  if fact_on(host, 'os.family') == %r{freebsd}
    install_package(host, 'ruby-gems')
    %w[ruby irb gem].each do |executable|
      on host, "ln -sf /usr/local/bin/#{executable}#{version} /usr/local/bin/#{executable}"
    end
  end

end

# options = {
#   default_action: 'gem_install'
# }

# block_on hosts, run_in_parallel: false do |host|
#   on host, 'pkg install -y devel/ruby-gems' if host['platform'] =~ %r{freebsd}
#   if host['platform'] =~ %r{openbsd}
#     version = ''
#     if host['platform'] =~ %r{openbsd-6}
#       on host, '. /root/.profile && pkg_add ruby-2.3.1p1'
#       version = '23'
#     end

#     %w[ruby irb gem].each do |executable|
#       on host, "ln -sf /usr/local/bin/#{executable}#{version} /usr/local/bin/#{executable}"
#     end
#   end
# end

# # Install Puppet on all hosts
# install_puppet_agent_on(hosts, options) unless ENV['BEAKER_provision'] == 'no'

# RSpec.configure do |c|
#   module_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

#   c.formatter = :documentation

#   c.before :suite do
#     # Install module to all hosts
#     hosts.each do |host|
#       install_dev_puppet_module_on(host, source: module_root, module_name: 'hugo')
#       # Install dependencies
#       on host, puppet('module', 'install', 'puppetlabs-stdlib'), acceptable_exit_codes: [0]
#       on host, puppet('module', 'install', 'lwf-remote_file'), acceptable_exit_codes: [0]
#     end
#   end
# end
