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
        '/tmp/compiled' => {
            'source' => $repo_path,
        }
    }
}

vcsrepo { $repo_path:
  ensure   => present,
  provider => git,
  source   => 'https://github.com/ZloeSabo/hugo-testdrive.git',
  revision => 'master'
}

Vcsrepo[$repo_path] ~> Hugo::Resource::Website["hugo:website:${repo_path}"]