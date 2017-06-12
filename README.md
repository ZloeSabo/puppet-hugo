# hugo

#### Table of Contents

1. [Description](#description)
1. [Setup](#setup)
    * [What hugo affects](#what-hugo-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with hugo](#beginning-with-hugo)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)
1. [TODOs - What still needs to be done](#todos)

## Description

A Puppet module for managing [Hugo][hugo]) (A static website engine).

This module installs Hugo using pre-built binaries and does not need external package repositories.

## Setup

### Setup requirements

The hugo module does not automatically create parent directories for the files it manages. Set up any needed directory structures before you start.

### What hugo affects

* module `puppet-hugo` depends on:
    * [puppetlabs-stdlib][puppetlabs-stdlib];
    * [lwf-remote_file][lwf-remote_file].
* system dependencies: `tar`;
* installs `hugo` executable to `/usr/local/bin` by default.

## Usage

Only install hugo:

```puppet
include ::hugo
```

Install executable generate website out of it:

```puppet
class {'::hugo':
    dependencies => ['tar'],
    sites => {
        '/var/www/test.org' => {
            'source' => '/tmp/test',
        }
    }
}
```

## Reference

### Class: `hugo`

```puppet
class {'::hugo':
    manage_dependencies => true,
    dependencies_ensure => 'latest',
    dependencies => ['tar', 'git'],
    manage_package => true,
    package_ensure => 'present',
    installation_directory => '/usr/local/bin',
    version => '0.20.7',
    owner => 'root',
    group => 'root',
    mode => 'ug=rw,o=r,a=x',
    repositories => {
        '/tmp/test' => {
            'ensure'   => 'present',
            'provider' => 'git',
            'source'   => 'https://github.com/ZloeSabo/hugo-testdrive.git',
            'revision' => 'master',
        }
    },
    sites => {
        '/var/www/test.org' => {
            'source' => '/tmp/test',
        }
    }
}
```

### Class: `hugo::packages`

```puppet
class {'::hugo::packages':
    manage_dependencies => true,
    dependencies_ensure => 'latest',
    dependencies        => ['git', 'tar']
}
```

### Class: `hugo::install`

```puppet
class {'::hugo::install':
    manage_package         => true,
    package_ensure         => 'present',
    installation_directory => '/usr/local/bin',
    version                => '0.20.7',
    owner                  => 'root',
    group                  => 'root',
    mode                   => 'ug=rw,o=r,a=x'
}
```

### Class: `hugo::compile`

```puppet
class {'::hugo::compile':
    hugo_executable => '/usr/local/bin/hugo',
    sites => {
        '/var/www/test.org' => {
            'source' => '/tmp/test',
        }
    }
}
```

## Limitations

See [metadata.json](metadata.json) for supported platforms.

## Development

TODO.

## TODOs

- [ ] supported platforms;
- [ ] tests;
- [ ] describe development workflow.

[hugo]: https://gohugo.io/
[puppetlabs-stdlib]: https://github.com/puppetlabs/puppetlabs-stdlib
[lwf-remote_file]: https://github.com/lwf/puppet-remote_file
