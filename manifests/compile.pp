class hugo::compile(
    Hash[String, Hash] $sites = $hugo::sites,
    String $hugo_executable = "${hugo::installation_directory}/hugo"
) {
    $sites.each |String $path, Hash $site| {
        exec { "compile:${site[source]}":
            command => "${hugo_executable} -s ${site[source]} -d ${path}${site[additional_arguments]}",
            refreshonly => true
        }
    }
}