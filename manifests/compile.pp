class hugo::compile(
    Hash[String, Hash] $sites = $hugo::sites,
    String $hugo_executable = "${hugo::installation_directory}/hugo"
) {
    $sites.each |String $target, Hash $site| {
        $source = $site[source]
        hugo::resource::website {"hugo:website:${source}":
            source               => $source,
            target               => $target,
            additional_arguments => $site[additional_arguments],
            refreshonly          => true,
        }
    }
}