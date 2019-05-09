class tftp::install inherits tftp {

  if($tftp::manage_package)
  {
    package { $tftp::params::package_name:
      ensure => $tftp::package_ensure,
    }
  }

}
