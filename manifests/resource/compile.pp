define hugo::resource::compile (
    String $target,
    String $source = $name,    
    Boolean $refreshonly = false,
    String $additional_arguments = '',
    String $hugo_executable = "${hugo::installation_directory}/hugo"
) {
    exec { "compile:${source}":
        command     => "${hugo_executable} -s ${source} -d ${target} ${additional_arguments}",
        refreshonly => $refreshonly
    }
}