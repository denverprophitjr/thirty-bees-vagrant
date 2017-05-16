class redis {
    package { 'apt':
        ensure    => latest,
        require   => Anchor['redis::apt_repo'],
    }

    anchor { 'redis::apt_repo' : }

    apt::source { 'redis':
        location    => 'http://nginx.org/packages/mainline/ubuntu/',
        release     => $lsbdistcodename,
        repos       => 'redis',
        key         => '7BD9BF62',
        key_source  => 'http://nginx.org/keys/nginx_signing.key',
        notify      => Exec['apt_get_update_for_redis'],
    }

    package {'redis-server':
        ensure => latest,
        require => Apt::Ppa["ppa:rwky/redis"],
    }

    file {'/etc/redis/redis.conf':
        ensure => file,
        content => template("redis/redis.conf.erb"),
        require => Package['redis-server'],
    }

    service {'redis-server':
        ensure => running,
        subscribe => File['/etc/redis/redis.conf'],
        require => Package['redis-server']
    }
}
