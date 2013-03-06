class vagrant::git() {
  package { 'git' :
    ensure => present
  }

  # Git configuration
  exec { 'symlink-gitconfig':
    cwd			=> "/home/vagrant",
    command => "ln -sf /home/host/.gitconfig .gitconfig",
    path 		=> "/bin:/usr/bin:/usr/sbin",
  }
}