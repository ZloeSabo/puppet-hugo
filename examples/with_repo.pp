#Requires you to install git and puppetlabs-vcsrepo first

$repo_path = '/tmp/test'

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
    sites => {
        $repo_path => {
            'target' => '/tmp/compiled'
        }
    }
}

vcsrepo { $repo_path:
    ensure   => present,
    provider => git,
    source   => 'https://github.com/ZloeSabo/hugo-testdrive.git',
    # revision => 'e842ba8cdeac6e2bacc9c58697b4e80bab10c26e',
    revision => 'master'
}

Vcsrepo[$repo_path] ~> Hugo::Resource::Compile[$repo_path]