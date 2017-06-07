class hugo::packages(
    Boolean $manage_dependencies = $hugo::manage_dependencies,
    Enum['latest','present','absent'] $dependencies_ensure = $hugo::dependencies_ensure,
    Array[String] $dependencies = $hugo::dependencies
) {
    if ($manage_dependencies) {
        ensure_packages($dependencies, {'ensure' => $dependencies_ensure})
    }
}