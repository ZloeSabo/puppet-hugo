define hugo::resource::compile (
    String $target,
    String $version,
    String $source = $name,
    Boolean $refreshonly = true,
    String $additional_arguments = '',
    String $hugo_executable = "${hugo::installation_directory}/hugo"
) {
    $fixed_source = regsubst($source, '/', '_', 'G')
    $fixed_target = regsubst($target, '/', '_', 'G')

    file { "version_lock:${source}:${target}:${version}":
        ensure  => 'file',
        path    => "/tmp/hugo-lock-${fixed_source}-${fixed_target}",
        content => $version,
    }

    exec { "compile:${source}:${target}":
        command     => "${hugo_executable} -s ${source} -d ${target} ${additional_arguments}",
        refreshonly => $refreshonly,
    }

    File["version_lock:${source}:${target}:${version}"] ~> Exec["compile:${source}:${target}"]
}