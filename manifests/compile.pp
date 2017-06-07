class hugo::compile(
    Hash[String, Hash] $sites = $hugo::sites,
    String $installation_directory = $hugo::installation_directory
) {
    $executable_path = "${installation_directory}/hugo"

    $sites.each |String $path, Hash $site| {
        exec { "compile:${site[source]}":
            command => "${$executable_path} -s ${site[source]} -d ${path}",
            refreshonly => true
        }
    }
}