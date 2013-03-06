class vagrant() {

  user { 'vagrant':
    home => '/home/vagrant',
  }

  include vagrant::git, build::deb_support, build::ruby_support

  exec { 'checkout-bash-preferences' :
    cwd => '/home/vagrant',
    command => 'https://github.com/dhakadamit/bash_preferences.git',
    user => 'vagrant',
    creates => '/home/vagrant/bash_preferences',
    require => Class['vagrant::git'],
  }

  exec { 'update-bash-preferences' :
    cwd => '/home/vagrant/bash_preferences',
    command => 'git pull origin master',
    user => 'vagrant',
    require => Exec['checkout-bash-preferences'],
  }

  exec { 'symlink-bash-profile':
    cwd			=> '/home/vagrant',
    command => 'ln -sf /home/vagrant/bash_preferences/.bash_profile .bash_profile',
    require => Exec['checkout-bash-preferences'],
  }

}



