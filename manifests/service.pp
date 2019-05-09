class tftp::service inherits tftp {

  #
  validate_bool($tftp::manage_docker_service)
  validate_bool($tftp::manage_service)
  validate_bool($tftp::service_enable)

  validate_re($tftp::service_ensure, [ '^running$', '^stopped$' ], "Not a valid daemon status: ${tftp::service_ensure}")

  $is_docker_container_var=getvar('::eyp_docker_iscontainer')
  $is_docker_container=str2bool($is_docker_container_var)

  if( $is_docker_container==false or
      $tftp::manage_docker_service)
  {
    if($tftp::manage_service)
    {
      service { $tftp::params::service_name:
        ensure => $tftp::service_ensure,
        enable => $tftp::service_enable,
      }
    }
  }
}
