data-journal
============

Web based demonstrator for SCAPE Data Journal.

### What does data-journal do?

This project is used to set up the SCAPE Data Journal demonstrator on a web server.  The official demonstrator can be
found at https://http://datajournal-preprod.scd.stfc.ac.uk/.

The project can also be used to easily set up a local VM instance of the Data Journal, for developers or curious users.

### Intended Audience

The project is for:
 * Users looking to try the SCAPE Data Journal on a local VM, see [Getting Started](#starting).

## <a name="starting"></a>Getting Started

This section describes how to use [VirtualBox](https://www.virtualbox.org/) and [Vagrant](http://www.vagrantup.com/) to
quickly set up a local VM that runs the SCAPE Data Journal.

### Requirements

You'll need to have [VirtualBox](https://www.virtualbox.org/wiki/Downloads) and
[Vagrant](http://www.vagrantup.com/downloads.html) installed, these are available for Windows, OS X, and most common
Linux distros.

You'll also need TCP/IP port 2020 free on your local machine, this is configurable in the [Vagrantfile](Vagrantfile).

### Installation

First clone this repository, if you've not already done so, and move into your local directory copy:
```
git clone git://github.com/openplanets/data-journal.git
cd data-journal
```

If this is the first time you're running the local data-journal VM you'll need to install a
[Vagrant box](http://docs.vagrantup.com/v2/boxes.html), in this case an Ubuntu 12.04 LTS box.  A box is a template
image from which VMs are created by Vagrant. Issue the following command:
```
vagrant box add precise64 http://files.vagrantup.com/precise64.box
```
It may take a few minutes for the box to download. If you're unsure about whether you have the appropriate Vagrant box
downloaded, issue the command:
```
vagrant box list
```
and look for the line:
```
precise64 (virtualbox)
```
amongst the listed boxes, on a linux box ```vagrant box list | grep precise64``` can be used to thin the output if
necessary.

### Proxy Settings

If you are running behind a proxy server then install the vagrant proxyconf:
```
vagrant plugin install vagrant-proxyconf
```
and then edit the config.proxy settings in the [Vagrantfile](Vagrantfile) file to point to your proxy server.

### Usage

After installing the box, from your local project directory issue the command ```vagrant up```. This will start the
headless VM.  If this is the first time you've run the command the it will provision the VM, that is install the
appropriate software for the Data Journal. This is achieved by running the [bootstrap.sh](./provision/bootstrap.sh)
shell script. Open a browser and visit [http://localhost:2020/datajournal/](http://localhost:2020/datajournal/) which
should show the Data Journal home page.

To stop the Data Journal, from your local project directory issue the command ```vagrant halt```.  This will shut down
the VM however the Vagrant box will continue to take up local resources, i.e. disk space, in the ```.vagrant```
sub-directory of the project.  See [Uninstall](#destroying) to see how to free up resources.

To restart the VM at any time issue the ```vagrant up``` command from the project directory.

### <a name="destroying"></a>Uninstall

To completely remove all trace of your Data Journal VM issue the command ```vagrant destroy``` from the local project
directory.  Issuing ```vagrant up``` will still re-create the machine, and will re-run
[bootstrap.sh](./provision/bootstrap.sh).  Issuing these commands effectively resets the machine to a pristine state.

## More Information

The [Vagrant Getting Started Guide](http://docs.vagrantup.com/v2/getting-started/index.html) is unsurprisingly a good
introduction to using Vagrant.

