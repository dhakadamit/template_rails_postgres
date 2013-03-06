class platform::support() {
  package {
    # required for mounting smb shares
    # e.g skytap shared drives
    'smbfs':
      ensure => installed;

    'python-software-properties':
      ensure => installed;

    'curl':
      ensure => installed;
  }
}
