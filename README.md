# puppet-hugo

[![Build Status](https://travis-ci.org/ZloeSabo/puppet-hugo.svg?branch=master)](https://travis-ci.org/ZloeSabo/puppet-hugo)

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
    sites => {
        '/tmp/test' => {
            'target'  => '/tmp/generated',
            'version' => 'someversion'
        }
    }
}
```

## Reference

### Class: `hugo`

```puppet
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

### Resource: `hugo::resource::compile`

```puppet
hugo::resource::compile {'human.test.org':
    target               => '/tmp/human.test.org',
    version              => 'someversion',
    source               => '/tmp/test',
    refreshonly          => true,
    additional_arguments => '',
    hugo_executable      => '/usr/local/bin/hugo'
}
```

## Limitations

See [metadata.json](metadata.json) for supported platforms.

## Development

### Running tests

```bash
gem install bundler
bundle install --path vendor
bundle exec rake test
```

### Contributing

Please make sure that test cases, syntax and documentation checks are passing.

[hugo]: https://gohugo.io/
[puppetlabs-stdlib]: https://github.com/puppetlabs/puppetlabs-stdlib
[lwf-remote_file]: https://github.com/lwf/puppet-remote_file
