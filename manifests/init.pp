# Class: hugo
# ===========================
#
# Manages installation of hugo executable and compilation of repos.
#
# Parameters
# ----------
#
# Document parameters here.
#
# Here you should define a list of variables that this module would require.
#
# * `manage_dependencies`
# Should module manage system dependencies? Type: Boolean Default: true
#
# * `dependencies_ensure`
# Should module ensure that dependencies are present? Type: Boolean Default: 'latest'
#
# * `dependencies`
# Package names, which required for module to function. Type: Array[String] Default: platform dependent
#
# * `manage_package`
# Should module manage installation of Hugo executable? Type: Boolean Default: true
#
# * `package_ensure`
# Should module ensure that Hugo executable is present? Type: Boolean Default: true
#
# * `installation_directory`
# Directory to install Hugo executable. Type: String Default: '/usr/local/bin'
#
# * `version`
# Version of Hugo executable to install. Type: String Default: '0.20.7'
#
# * `owner`
# User ownership of Hugo executable. Type: String Default: 'root'
#
# * `group`
# Group ownership of Hugo executable. Type: String Default: 'root'
#
# * `mode`
# Access permissions of Hugo executable. Type: String Default: 'ug=rw,o=r,a=x'
#
# * `repositories`
# Repositories with Hugo sources to clone. Key is a target directory, value is settings, accepted by puppet-vcsrepo. Type: Hash Default: {}
#
# * `sites`
# Mapping between Hugo source directories and targets for static generation. Type: Hash Default: {}
#
# Variables
# ----------
#
#
# Examples
# --------
#
# @example
#    class {'::hugo':
#        repositories => {
#            '/tmp/test' => {
#                'ensure'   => 'present',
#                'provider' => 'git',
#                'source' => 'https://github.com/ZloeSabo/hugo-testdrive.git',
#                'revision' => 'master',
#            }
#        },
#        sites => {
#            '/var/www/test.org' => {
#                'source' => '/tmp/test',
#            }
#        }
#    }
#
# Authors
# -------
#
# Evgeny Soynov <saboteur@saboteur.me>
#
# Copyright
# ---------
#
# Copyright 2017 Evgeny Soynov.
#
class hugo(
    Boolean $manage_dependencies,
    Enum['latest','present','absent'] $dependencies_ensure,
    Array[String] $dependencies,
    Boolean $manage_package,
    Enum['present', 'absent'] $package_ensure,
    String $installation_directory,
    String $version,
    String $owner,
    String $group,
    String $mode,
    Hash[String, Hash] $repositories,
    Hash[String, Hash] $sites
) {
    contain ::hugo::packages
    contain ::hugo::install
    contain ::hugo::repository
    contain ::hugo::compile

    Class['::hugo::packages']
    ->Class['::hugo::install']
    ->Class['::hugo::repository']
    ->Class['::hugo::compile']

    $repositories.each |String $path, Hash $_| {
        Vcsrepo[$path] ~> Exec["compile:${path}"]
    }
}
