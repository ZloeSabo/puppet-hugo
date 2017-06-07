class hugo::repository(
    Hash[String, Hash] $repositories = $hugo::repositories
) {
    $repositories.each |String $path, Hash $repository| {
        vcsrepo { $path:
          * => $repository,
        }
    }
}