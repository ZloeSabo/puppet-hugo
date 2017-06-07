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

Class {'::hugo':
    repositories => {
        '/tmp/test' => {
            'ensure'   => 'present',
            'provider' => 'git',
            'source' => 'https://github.com/ZloeSabo/hugo-testdrive.git',
            'revision' => '105311bd72858603a278c723b79a9027798b7eca',
            # 'revision' => 'e842ba8cdeac6e2bacc9c58697b4e80bab10c26e',
        }
    },
    sites => {
        '/var/www/static.saboteur.vm' => {
            'source' => '/tmp/test',
        }
    }
}