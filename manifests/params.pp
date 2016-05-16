# class: grub2::params: See README for documentation
class grub2::params {

  $background_image       = ''
  $badram                 = ''
  $config_template        = 'grub2/default_grub.erb'
  $cmdline_linux          = ''
  $cmdline_linux_default  = ''
  $cmdline_linux_recovery = ''
  $cmdline_xen            = ''
  $default_entry          = '0'
  $device_install         = ''
  $disable_os_prober      = false
  $disable_recovery       = false
  $disable_submenu        = false
  $disable_uuid           = false
  $gfxmode                = ''
  $hidden_timeout         = undef
  $hidden_timeout_quiet   = false
  $install_grub           = false
  $package_ensure         = 'present'
  $password_md5               = '$1$s.lVn$k4oNYLbuIeQoqy1vEDZIL0'
  $recordfail_timeout     = 5
  $save_default           = false
  $serial_command         = ''
  $terminal               = ''
  $timeout                = 5
  $tune                   = ''
  $update_grub            = true

  case $::osfamily {
    'Debian': {
      $config_file       = '/etc/default/grub'
      $distributor       = '$(lsb_release -i -s 2> /dev/null || echo Debian)'
      $install_binary    = '/usr/sbin/grub-install'
      $package_name      = [ 'grub-pc', 'grub-common' ]
      $update_binary     = '/usr/sbin/update-grub'
    }
    'Redhat': {
      $config_file       = '/etc/default/grub'
      $distributor       = "$(sed 's, release .*$,,g' /etc/system-release)"
      $install_binary    = '/usr/sbin/grub2-install'
      $package_name      = [ 'grub2', 'grub2-tools' ]
      $update_binary     = '/usr/sbin/grub2-mkconfig -o /boot/grub2/grub.cfg'
    }
    'Gentoo': {
      $config_file       = '/etc/default/grub'
      $distributor       = 'Gentoo'
      $install_binary    = '/usr/sbin/grub2-install'
      $package_name      = [ 'sys-boot/grub' ]
      $update_binary     = '/usr/sbin/grub2-mkconfig -o /boot/grub/grub.cfg'
    }
    'Suse': {
      $config_file       = '/etc/default/grub'
      $distributor       = '$(lsb_release -i -r -s 2> /dev/null || echo SUSE)'
      $install_binary    = '/usr/sbin/grub2-install'
      $package_name      = 'grub2'
      $update_binary     = '/usr/sbin/grub2-mkconfig -o /boot/grub2/grub.cfg'
    }
    default: {
      fail("The ${module_name} module is not supported on ${::operatingsystem}")
    }
  }

}
