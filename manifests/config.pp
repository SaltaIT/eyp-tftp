class tftp::config inherits tftp {

  include ::systemd

  file { $tftp::basedir:
    ensure => 'directory',
    owner  => $tftp::user,
    group  => $tftp::group,
    mode   => $tftp::basedir_mode,
  }

  # [root@ip-172-31-17-149 ~]# cat /usr/lib/systemd/system/tftp.socket
  # [Unit]
  # Description=Tftp Server Activation Socket
  #
  # [Socket]
  # ListenDatagram=69
  #
  # [Install]
  # WantedBy=sockets.target
  # [root@ip-172-31-17-149 ~]#

  systemd::socket { 'tftp':
    description     => 'TFTP Server Activation Socket',
    listen_datagram => [ '69' ],
    wantedby        => [ 'sockets.target' ],
  }

  # [root@ip-172-31-17-149 ~]# cat /usr/lib/systemd/system/tftp.service
  # [Unit]
  # Description=Tftp Server
  # Requires=tftp.socket
  # Documentation=man:in.tftpd
  #
  # [Service]
  # ExecStart=/usr/sbin/in.tftpd -s /var/lib/tftpboot
  # StandardInput=socket
  #
  # [Install]
  # Also=tftp.socket
  # [root@ip-172-31-17-149 ~]#

  systemd::service { 'tftp':
    description    => 'TFTP server',
    requires       => [ 'tftp.socket' ],
    documentation  => 'man:in.tftpd',
    execstart      => [ "/usr/sbin/in.tftpd -s -c -v -u ${tftp::user} -p -U ${tftp::umask} -s ${tftp::basedir}" ],
    standard_input => 'socket',
    also           => [ 'tftp.socket' ],
  }


  # wtf? - notes varies

  # xinetd::daemon { 'tftp':
  #   disable     => false,
  #   description => 'TFTP daemon',
  #   protocol    => 'udp',
  #   user        => 'root',
  #   server      => '/usr/sbin/in.tftpd',
  #   server_args => "-c -v -u ${tftp::user} -p -U ${tftp::umask} -s ${tftp::basedir}",
  #   per_source  => $tftp::max_instances_per_source,
  #   max_cps     => $tftp::max_cps,
  #   cps_bantime => $tftp::cps_bantime,
  #   flags       => 'IPv4',
  # }

}
