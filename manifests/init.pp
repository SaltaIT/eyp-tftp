class tftp(
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
  -> Class['::tftp']

}
