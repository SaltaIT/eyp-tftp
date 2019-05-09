class tftp::service inherits tftp {

  $is_docker_container_var=getvar('::eyp_docker_iscontainer')
  $is_docker_container=str2bool($is_docker_container_var)

  if( $is_docker_container==false or
      $tftp::manage_docker_service)
  {
    if($tftp::manage_service)
    {
      service { $tftp::service_name:
        ensure => $tftp::service_ensure,
        enable => $tftp::service_enable,
      }
    }
  }
}
