class nginx ($docroot = undef){
  $srcpath = 'puppet:///modules/nginx'
  File {
    owner => 'root',
    group => 'root',
    mode  => '0664',
  }

  package { 'nginx':
    ensure => present,
  }
  file { $docroot:
    ensure => directory,
  }
  file { "$docroot/index.html":
    ensure => file,
    source => "$srcpath/index.html",
  }
  file { '/etc/nginx/nginx.conf':
    ensure => file,
    source => "$srcpath/nginx.conf",
    require => Package['nginx'],
    notify => Service['nginx'],
  }
  file { '/etc/nginx/conf.d':
    ensure => directory,
  }
  file { '/etc/nginx/conf.d/default.conf':
    ensure => file,
    source => "$srcpath/default.conf",
    require => Package['nginx'],
    notify => Service['nginx'],
  }
  service { 'nginx':
    ensure => running,
    enable => true,
  }
}
