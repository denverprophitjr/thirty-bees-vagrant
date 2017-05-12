class { '::php':
-  include apt
    ensure         => latest,
    manage_repos   => false,
    fpm            => true,
    dev            => false,
    composer       => true,
    pear           => false,
    phpunit        => false,
    package_prefix =>'php7.0-',
    settings       => {
      'PHP/max_execution_time'  => '90',
      'PHP/max_input_time'      => '300',
      'PHP/memory_limit'        => '512M',
      'PHP/post_max_size'       => '32M',
      'PHP/upload_max_filesize' => '32M',
      'Date/date.timezone'      => 'America/New_York',
      'PHP/max_input_vars       => ' 1600',
    },
    extensions     => {
      xml      => {},
      xmlrpc   => {},
      xsl      => {},
      gd       => {},
      mcrypt   => {},
      mysqlnd  => {},
      mbstring => {},
      opcache  => {},
      redis    => {},
      soap     => {},
      bcmath   => {},
      zip      => {},
      imap     => {},
      curl     => {},
      },
    }

  php::fpm::pool { 'www1':
    listen => '/var/run/php7-fpm.sock1',
  }

  php::fpm::pool { 'www2':
    listen => '/var/run/php7-fpm.sock2',
  }
}
