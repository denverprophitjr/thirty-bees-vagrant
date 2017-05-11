# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = 'ubuntu/trusty32'

  # The hostname for the VM
  config.vm.hostname = 'vagrant-thirtybees'

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network 'private_network', ip: '10.0.10.1'

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  config.vm.network 'public_network, ip: '192.168.1.25'

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  # config.ssh.forward_agent = true

  # Create an entry in the /etc/hosts file for #{hostname}.dev
  if defined? VagrantPlugins::HostsUpdater
    config.hostsupdater.aliases = ["#{config.vm.hostname}.dev"]
  end

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Don't boot with headless mode
  #   vb.gui = true
  #
  #   # Use VBoxManage to customize the VM. For example to change memory:
  #   vb.customize ["modifyvm", :id, "--memory", "1024"]
  # end
  config.vm.provider 'virtualbox' do |v,override|
    v.gui=false
    v.customize ["modifyvm", :id, "--memory", 1024]
    v.customize ["modifyvm", :id, "--cpus", "2"]
    v.customize ["modifyvm", :id, "--vram", "128"]
    v.customize ["setextradata", "global", "GUI/MaxGuestResolution", "any"]
    v.customize ["setextradata", :id, "CustomVideoMode1", "1024x768x32"]
    v.customize ["modifyvm", :id, "--ioapic", "on"]
    v.customize ["modifyvm", :id, "--rtcuseutc", "on"]
    v.customize ["modifyvm", :id, "--accelerate3d", "on"]
    v.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
    v.customize ["modifyvm", :id, "--audio", "none"]
    v.customize ["modifyvm", :id, "--draganddrop", "hosttoguest"]
  end
["vmware_fusion", "vmware_workstation"].each do |provider|
      config.vm.provider provider do |v, override|
        v.gui = true
        v.vmx["memsize"] = "1048"
        v.vmx["numvcpus"] = "2"
        v.vmx["cpuid.coresPerSocket"] = "4"
        v.vmx["ethernet0.virtualDev"] = "vmxnet3"
        v.vmx["RemoteDisplay.vnc.enabled"] = "false"
        v.vmx["RemoteDisplay.vnc.port"] = "5900"
        v.vmx["scsi0.virtualDev"] = "lsilogic"
        v.vmx["mks.enable3d"] = "TRUE"
  end
  

  config.vm.synced_folder '//user//public//www', '/var/www/html'

  # View the documentation for the provider you're using for information on available options.

  config.vm.provision 'shell', inline: 'test -d /etc/puppet/modules/apt || puppet module install puppetlabs/apt'

  # Provision the VM using Puppet
  config.vm.provision 'puppet' do |puppet|
    puppet.manifests_path = 'puppet/manifests'
    puppet.manifest_file  = 'site.pp'
    puppet.module_path    = 'puppet/modules'
    puppet.options        = '--verbose --debug'
    puppet.facter         = {
      'mysql_root_password'      => 'vagrant',
      'mysql_wordpress_user'     => 'thirtybees',
      'mysql_wordpress_dbname'   => 'thirtybees',
      'mysql_wordpress_password' => 'thirtybees',
      'thirtybees_url'            => "http://#{config.vm.hostname}.dev",
      'thirtybees_title'          => 'The Title',
      'thirtybees_admin_user'     => 'no_reply@thirtybees.com',
      'thirtybees_admin_password' => 'vagrant',
      'wordpress_admin_email'    => "vagrant@#{config.vm.hostname}.dev",
      'wwwroot'                  => '/var/www/html'
    }
  end
end
