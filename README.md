# Trusty64/Ubuntu LEMP Vagrant / Puppet
<figure align="center">![thirty bees shopping cart](https://raw.github.com/thirtybees/thirtybees/1.0.x/admin-dev/themes/default/img/thirty-bees-avatar-header_shopname.png)
<figcaption>[**thirty bees shopping cart**](http://thirtybees.com)</figcaption>
</figure>

## Overview
### What is Included
+ Ubuntu 17.04
+ Nginx
+ PHP 7.0
+ MariaDB 10.1.23
+ phpMyAdmin
+ [WP-CLI](http://wp-cli.org/)

### Configuration
Configuration is mostly done inside the `Vagrantfile`. Key items are as follows:

+ `config.vm.hostname` - the hostname of the VM. With the Vagrant Hostsupdater plugin, it will be accessible at `http://<hostname>.dev/` when setup is complete.
+ `config.vm.network` - a static IP address for the VM
+ `config.vm.provider` block - contains modifications for the VM (right now just the RAM but this can be updated to suit your needs)
+ `config.vm.provision` block and `puppet.facter` hash - contains details for Puppet, which will provision the VM. The `facter` hash is used for various details for WordPress and MySQL.

### How to Use
Modify `Vagrantfile` to suite your needs. Optionally, install [Vagrant Hostsupdater](https://github.com/cogitatio/vagrant-hostsupdater) to automatically add the VM to your `hosts` file.

When completed, simply run `vagrant up` and if all goes well the environment should be ready to use in just a few minutes. phpMyAdmin will also be accessible at `/phpmyadmin`.

The document root of the webserver is the `/var/www/html` directory at the root of this project and is mapped to shared folder `/www` on the VM.

#### Default Credentials
Account     | Username  | Password
------------|-----------|---------
MariaDB       | root      | vagrant
thirty bees | thirtybees | thirtybees
WordPress Admin | no_reply@thirtybees.com | thirtybees

#Contributors
Name     | Github User  | Website
------------|-----------|---------
Denver Prophit Jr.       | [inetbiz](https://github.com/inetbiz)      | https://www.denverprophit.us/
