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

A Puppet module for managing [Hugo](https://gohugo.io/) (A static website engine).

This module installs Hugo using pre-built binaries and does not need external package repositories. It's also capable of site generation from VCS (version control system) repositories (see [puppet-vcsrepo][puppetlabs-vcsrepo] for list of supported repository types).

## Setup

### Setup requirements

With the default settings the hugo module **does not install any VCS** software for you. You must specify a package name of preferred VCS before you can use full workflow of this module.

The hugo module does not automatically create parent directories for the files it manages. Set up any needed directory structures before you start.

### What hugo affects

* module `puppet-hugo` depends on:
    * [puppetlabs-stdlib][puppetlabs-stdlib];
    * [puppetlabs-vcsrepo][puppetlabs-vcsrepo];
    * [lwf-remote_file][lwf-remote_file].
* system dependencies: `tar`;
* installs `hugo` executable to `/usr/local/bin` by default.

## Usage

Only install hugo:

```puppet
include ::hugo
```

Install executable, clone git repository and generate website out of it:

```puppet
class {'::hugo':
    dependencies => ['tar', 'git'],
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

### Class: `hugo::repository`

```puppet
class {'::hugo::repository':
    repositories => {
        '/tmp/test' => {
            'ensure'   => 'present',
            'provider' => 'git',
            'source'   => 'https://github.com/ZloeSabo/hugo-testdrive.git',
            'revision' => 'master',
        }
    }
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

- [ ] avoid specifying vcsrepo for notifications (separate resource or subscribe to directory changes);
- [ ] supported platforms;
- [ ] tests;
- [ ] describe development workflow.
