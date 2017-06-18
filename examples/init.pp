# The baseline for module testing used by Puppet Labs is that each manifest
# should have a corresponding test manifest that declares that class or defined
# type.
#
# Tests are then run by using puppet apply --noop (to check for compilation
# errors and view a log of events) or by fully applying the test in a virtual
# environment (to compare the resulting system state to the desired state).
#
# Learn more about module testing here:
# https://docs.puppet.com/guides/tests_smoke.html
#
# include ::hugo

class {'::hugo':
    manage_dependencies    => true,
    dependencies_ensure    => 'latest',
    dependencies           => ['tar', 'git'],
    manage_package         => true,
    package_ensure         => 'present',
    installation_directory => '/usr/local/bin',
    version                => '0.20.7',
    owner                  => 'root',
    group                  => 'root',
    mode                   => 'ug=rw,o=r,a=x',
    sites                  => {
        'test.org' => {
            'source' => '/tmp/test',
            'target' => '/tmp/test.org',
            'version' => 'aaa'
        },
        'test2.org' => {
            'source' => '/tmp/test',
            'target' => '/tmp/test2.org',
            'version' => 'bbb'
        }
    },
    compile_defaults       => {
        'hugo_executable' => '/usr/local/bin/hugo',
        'refreshonly'     => true
    }
}