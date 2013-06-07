# == Class: nagios::nagios_cfg
#
# === Parameters
#
# [*cfg_files*]                    -
# [*cfg_dirs*]                     -
# [*command_check_interval*]       -
# [*use_retained_scheduling_info*] -
# [*enable_flap_detection*]        -
#
# === Examples
#
# === Authors
#
# === Copyright
#
# Copyright 2013 New Relic, Inc. All rights reserved.
#
class nagios::nagios_cfg (
  $cfg_files                    = $nagios::params::cfg_files,
  $cfg_dirs                     = $nagios::params::cfg_dirs,
  $command_check_interval       = $nagios::params::cfg_command_check_interval,
  $use_retained_scheduling_info = $nagios::params::cfg_use_retained_scheduling_info,
  $enable_flap_detection        = $nagios::params::cfg_enable_flap_detection,
) inherits nagios::params {

  file { '/etc/nagios/nagios.cfg':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0664',
    content => template("${module_name}/nagios.cfg.erb"),
  }
}

