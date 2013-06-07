# == Class: nagios
#
# === Parameters
#
# === Examples
#
# === Authors
#
# === Copyright
#
# Copyright 2013 New Relic, Inc. All rights reserved.
#
class nagios (
  $cfg_files                                      = $nagios::params::cfg_files,
  $cfg_dirs                                       = $nagios::params::cfg_dirs,
  $cfg_command_check_interval                     = $nagios::params::cfg_command_check_interval,
  $cfg_use_retained_scheduling_info               = $nagios::params::cfg_use_retained_scheduling_info,
  $cfg_enable_flap_detection                      = $nagios::params::cfg_enable_flap_detection,
  $cgi_authorized_for_system_information          = $nagios::params::cgi_authorized_for_system_information,
  $cgi_authorized_for_configuration_information   = $nagios::params::cgi_authorized_for_configuration_information,
  $cgi_authorized_for_system_commands             = $nagios::params::cgi_authorized_for_system_commands,
  $cgi_authorized_for_all_services                = $nagios::params::cgi_authorized_for_all_services,
  $cgi_authorized_for_all_hosts                   = $nagios::params::cgi_authorized_for_all_hosts,
  $cgi_authorized_for_all_service_commands        = $nagios::params::cgi_authorized_for_all_service_commands,
  $cgi_authorized_for_all_host_commands           = $nagios::params::cgi_authorized_for_all_host_commands,
  $resource_user                                  = { },
) inherits nagios::params {

  package {
    'nagios':
      ensure  => installed,
  } -> package {
    'nagios-common':
      ensure  => installed,
  } -> package {
    'nagios-plugins-all':
      ensure  => installed,
  }

  package { 'perl-Net-SNMP':
    ensure => installed,
  }

  # Nuke the default objects dir in CentOS 6
  file { '/etc/nagios/objects/':
    ensure  => absent,
    force   => true,
    require => Package['nagios'],
  }

  # link lib64 plugins to lib so the pathing works right
  file { '/usr/lib/nagios/':
    ensure  => link,
    target  => '/usr/lib64/nagios/',
    require => Package['nagios-plugins-all'],
  }


  class { 'nagios::cgi_cfg':
    authorized_for_configuration_information => $cgi_authorized_for_configuration_information,
    authorized_for_system_commands           => $cgi_authorized_for_system_commands,
    authorized_for_all_services              => $cgi_authorized_for_all_services,
    authorized_for_all_hosts                 => $cgi_authorized_for_all_hosts,
    authorized_for_all_service_commands      => $cgi_authorized_for_all_service_commands,
    authorized_for_all_host_commands         => $cgi_authorized_for_all_host_commands,
    require                                  => Package['nagios'],
  }

  class { 'nagios::nagios_cfg':
    cfg_files                    => $cfg_files,
    cfg_dirs                     => $cfg_dirs,
    command_check_interval       => $cfg_command_check_interval,
    use_retained_scheduling_info => $cfg_use_retained_scheduling_info,
    enable_flap_detection        => $cfg_enable_flap_detection,
    require                      => Package['nagios'],
  }

  class { 'nagios::resource_cfg':
    resource_user => $resource_user,
    require       => Package['nagios'],
  }
}

