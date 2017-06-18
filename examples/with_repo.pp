#Requires you to install git and puppetlabs-vcsrepo first

$repo_path = '/tmp/test'
$revision = 'master'
# $revision = 'e842ba8cdeac6e2bacc9c58697b4e80bab10c26e'

class {'::hugo':
    manage_dependencies => true,
    dependencies_ensure => 'latest',
    dependencies => ['tar'],
    manage_package => true,
    package_ensure => 'present',
    installation_directory => '/usr/local/bin',
    version => '0.20.7',
    owner => 'root',
    group => 'root',
    mode => 'ug=rw,o=r,a=x',
    sites                  => {
        $repo_path => {
            'target' => '/tmp/test.org',
            'version' => $revision
        },
        'test2.org' => {
            'source' => '/tmp/test',
            'target' => '/tmp/test2.org',
            'version' => $revision
        }
    },
    compile_defaults       => {
        'hugo_executable' => '/usr/local/bin/hugo',
        'refreshonly'     => true
    }
}

vcsrepo { $repo_path:
    ensure   => present,
    provider => git,
    source   => 'https://github.com/ZloeSabo/hugo-testdrive.git',
    revision => $revision
}

Vcsrepo[$repo_path] -> Class['::hugo']