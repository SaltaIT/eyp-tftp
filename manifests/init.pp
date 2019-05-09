class tftp(
            $manage_service           = true,
            $manage_docker_service    = true,
            $service_ensure           = 'running',
            $service_enable           = true,
            $manage_package           = true,
            $package_ensure           = 'installed',
            $basedir                  = '/var/ftp',
            $basedir_mode             = '0755',
            $user                     = 'ftp',
            $group                    = 'ftp',
            $umask                    = '117',
            $max_cps                  = '100',
            $cps_bantime              = '2',
            $max_instances_per_source = '10',
          ) inherits tftp::params{

  class { '::tftp::install': }
  -> class { '::tftp::config': }
  ~> class { '::tftp::service': }
  -> Class['::tftp']

}
