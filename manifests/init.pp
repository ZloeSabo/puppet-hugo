# Class: hugo
# ===========================
#
# Full description of class hugo here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'hugo':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
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
