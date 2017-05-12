class nginx($upstream) {
 package { "nginx":
        ensure      => latest,
        require     => Anchor['nginx::apt_repo'],
    }
    
    anchor { 'nginx::apt_repo' : }
    
    apt::source { 'nginx':
        location    => 'http://nginx.org/packages/mainline/ubuntu/',
        release     => $lsbdistcodename,
        repos       => 'nginx',
        key         => '7BD9BF62',
        key_source  => 'http://nginx.org/keys/nginx_signing.key',
        notify      => Exec['apt_get_update_for_nginx'],
    }
    
    exec { 'apt_get_update_for_nginx':
        command     => '/usr/bin/apt-get update',
        timeout     => 240,
        returns     => [ 0, 100 ],
        refreshonly => true,
        before      => Anchor['nginx::apt_repo'],
    }

  service { 'nginx':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Package['nginx'],
  }

 file { "/etc/nginx/conf.d/upstream.conf":
        owner       => root,
        group       => root,
        mode        => 644,
        content     => template("nginx/upstream.conf.erb"),
        notify      => Service["nginx"],
        require     => Package["nginx"]
    }

  file { '/etc/nginx/nginx.conf':
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
    notify  => Service['nginx'],
  }

  file { '/etc/nginx/sites-enabled/default':
    ensure => absent,
    notify => Service['nginx'],
  }
  
  file { "/etc/nginx/conf.d/example_ssl.conf":
        ensure      => absent,
        notify      => Service["nginx"],
        require     => Package["nginx"]
    }

  exec { 'add-vagrant-to-www-data':
    path    => '/bin:/usr/bin:/usr/sbin',
    unless  => "grep -q 'www-data\\S*vagrant' /etc/group",
    command => 'usermod -aG www-data vagrant',
  }

  vhost { $hostname:
    name    => $hostname,
    wwwroot => $::wwwroot,
    notify  => Service['nginx'],
  }
}

