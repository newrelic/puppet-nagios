# == Class: nagios::params
#
# === Parameters
#
# None.
#
# === Examples
#
#  class { 'nagios::params': }
#
# === Authors
#
# === Copyright
#
# Copyright 2013 New Relic, Inc. All rights reserved.
#
class nagios::params {
  # NAGIOS.CFG PARAMS
  $base_dir = '/etc/nagios'

  # Default to just the puppet types
  $cfg_files = [
    "${base_dir}/nagios_host.cfg",
    "${base_dir}/nagios_hostgroup.cfg",
    "${base_dir}/nagios_hostdependency.cfg",
    "${base_dir}/nagios_hostescalation.cfg",
    "${base_dir}/nagios_hostextinfo.cfg",
    "${base_dir}/nagios_service.cfg",
    "${base_dir}/nagios_servicegroup.cfg",
    "${base_dir}/nagios_servicedependency.cfg",
    "${base_dir}/nagios_serviceescalation.cfg",
    "${base_dir}/nagios_serviceextinfo.cfg",
    "${base_dir}/nagios_timeperiod.cfg",
    "${base_dir}/nagios_command.cfg",
    "${base_dir}/nagios_contact.cfg",
    "${base_dir}/nagios_contactgroup.cfg",
  ]

  $cfg_dirs                           = [ ]
  $cfg_command_check_interval         = '-1'
  $cfg_use_retained_scheduling_info   = '1'
  $cfg_enable_flap_detection          = '0'

  # CGI PARAMS
  $cgi_authorized_for_system_information          = 'nagiosadmin'
  $cgi_authorized_for_configuration_information   = 'nagiosadmin'
  $cgi_authorized_for_system_commands             = 'nagiosadmin'
  $cgi_authorized_for_all_services                = 'nagiosadmin'
  $cgi_authorized_for_all_hosts                   = 'nagiosadmin'
  $cgi_authorized_for_all_service_commands        = 'nagiosadmin'
  $cgi_authorized_for_all_host_commands           = 'nagiosadmin'
}
