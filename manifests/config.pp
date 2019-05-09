class tftp::config inherits tftp {

  include ::xinetd

  file { $tftp::basedir:
    ensure => 'directory',
    owner  => $tftp::user,
    group  => $tftp::group,
    mode   => $tftp::basedir_mode,
  }

  xinetd::daemon { 'tftp':
    disable     => false,
    description => 'TFTP daemon',
    protocol    => 'udp',
    user        => 'root',
    server      => '/usr/sbin/in.tftpd',
    server_args => "-c -v -u ${tftp::user} -p -U ${tftp::umask} -s ${tftp::basedir}",
    per_source  => $tftp::max_instances_per_source,
    max_cps     => $tftp::max_cps,
    cps_bantime => $tftp::cps_bantime,
    flags       => 'IPv4',
  }

  # wtf?

  # # vi /usr/lib/systemd/system/tftp.service
  # [Unit]
  # Description=Tftp Server
  # Requires=tftp.socket
  # Documentation=man:in.tftpd
  #
  # [Service]
  # ExecStart=/usr/sbin/in.tftpd -c -v -u tftp -p -U 117 -s /tftpdata
  # StandardInput=socket
  #
  # [Install]
  # Also=tftp.socket

  # systemd::service { 'tftp':
  #   description => 'TFTP server'
  #   requires      => [ 'tftp.socket' ],
  #   documentation => 'man:in.tftpd'
  #
  # }

}
