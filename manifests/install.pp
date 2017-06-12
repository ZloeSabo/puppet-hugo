class hugo::install(
    Boolean $manage_package = $hugo::manage_package,
    Enum['present', 'absent'] $package_ensure = $hugo::package_ensure,
    String $installation_directory = $hugo::installation_directory,
    String $version = $hugo::version,
    String $owner = $hugo::owner,
    String $group = $hugo::group,
    String $mode = $hugo::mode
) {
    if ($manage_package) {
        case $facts['architecture'] {
            /(amd64)/: {
                $arch = '64'
            }
            /(x86)/: {
                $arch = '32'
            }
            default: {
                $arch = $facts['architecture']
            }
        }

        $source = "https://github.com/spf13/hugo/releases/download/v${version}/hugo_${version}_${facts[kernel]}-${arch}bit.tar.gz"
        $tmp_path = '/tmp/hugo.tar.gz'
        $executable_path = "${installation_directory}/hugo"

        remote_file { 'hugo':
            ensure => $package_ensure,
            path   => $executable_path,
            source => $source,
            notify => [
                Exec["install:${executable_path}"]
            ],
        }
    }

    exec {"install:${executable_path}":
        command     => "mv ${executable_path} ${tmp_path} && tar xf ${tmp_path} -C ${installation_directory} hugo && rm -f ${tmp_path}",
        path        => '/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
        refreshonly => true,
    }

    file { $executable_path:
        ensure  => present,
        owner   => $owner,
        group   => $group,
        mode    => $mode,
        require => Exec["install:${executable_path}"],
    }
}