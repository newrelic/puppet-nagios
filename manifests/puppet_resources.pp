# == Class: nagios::puppet_resources
#
# === Parameters
#
# [*auto_collect*] - Enable automatic collection of exported resources to create the configs
# [*auto_purge*]   - Enable the automatic purging of resources that are no longer exported
#
# === Examples
#
# === Authors
#
# === Copyright
#
# Copyright 2013 New Relic, Inc. All rights reserved.
#
class nagios::puppet_resources (
  $auto_collect = $nagios::params::puppet_resources_collect,
  $auto_purge   = $nagios::params::puppet_resources_purge,
  $base_dir     = $nagios::params::base_dir,
  $nagios_user  = $nagios::params::user,
  $nagios_group = $nagios::params::group,
) inherits nagios::params {

  # These are the filenames that Puppet uses, and you can not
  # change the target AND have them automatically purged.
  file {
    [
      "${base_dir}/nagios_command.cfg",
      "${base_dir}/nagios_contact.cfg",
      "${base_dir}/nagios_contactgroup.cfg",
      "${base_dir}/nagios_host.cfg",
      "${base_dir}/nagios_hostdependency.cfg",
      "${base_dir}/nagios_hostescalation.cfg",
      "${base_dir}/nagios_hostextinfo.cfg",
      "${base_dir}/nagios_hostgroup.cfg",
      "${base_dir}/nagios_hostgroupescalation.cfg",
      "${base_dir}/nagios_service.cfg",
      "${base_dir}/nagios_servicedependency.cfg",
      "${base_dir}/nagios_serviceescalation.cfg",
      "${base_dir}/nagios_serviceextinfo.cfg",
      "${base_dir}/nagios_servicegroup.cfg",
      "${base_dir}/nagios_timeperiod.cfg",
    ]:
      ensure  => 'file',
      replace => false,
      mode    => '0644',
      owner   => $nagios_user,
      group   => $nagios_group,
  }

  if ($auto_purge) {
    # Set purge => true on exported nagios resources so they get cleaned up
    resources {
      [
       'Nagios_command',
       'Nagios_contact',
       'Nagios_contactgroup',
       'Nagios_host',
       'Nagios_hostdependency',
       'Nagios_hostescalation',
       'Nagios_hostextinfo',
       'Nagios_hostgroup',
       'Nagios_service',
       'Nagios_servicedependency',
       'Nagios_serviceescalation',
       'Nagios_serviceextinfo',
       'Nagios_servicegroup',
       'Nagios_timeperiod',
      ]:
        purge => true,
    }
  }

  if ($auto_collect) {
    # collect resources and populate /etc/nagios/nagios_*.cfg
    Nagios_host <<||>>
    Nagios_hostgroup <<||>>
    Nagios_hostdependency <<||>>
    Nagios_hostescalation <<||>>
    Nagios_hostextinfo <<||>>
    Nagios_service <<||>>
    Nagios_servicegroup <<||>>
    Nagios_servicedependency <<||>>
    Nagios_serviceescalation <<||>>
    Nagios_serviceextinfo <<||>>
    Nagios_timeperiod <<||>>
    Nagios_command <<||>>
    Nagios_contact <<||>>
    Nagios_contactgroup <<||>>
  }

}

