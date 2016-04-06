memcached {
   
  package { 'memcached':
    ensure => present,
  }

  file { '/etc/sysconfig/memcached':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
    source => 'puppet:///modules/memcached/memcacheconfig',
    require => Package['memcached'],
  }

  service { 'memcached':
    ensure => running,
    enable => true,
    require => Package['memcached'],
    subscribe => File['/etc/sysconfig/memcached'],
  } 
}
