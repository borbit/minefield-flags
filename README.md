Minefield Flags
===============

The idea of this project it to enable Minefield's players draw their own custom flags. For the timebeing it works pretty simple - you draw a flag, submit it, then I add it to the game if it corresponds to the Minefield's general style and simply looks good. This process can take some time since it is not automated yet.

Server architecture is based on [Blank](https://github.com/borbit/blank).

Development
-----------

### Requirements

* [Vagrant](http://www.vagrantup.com/)
* [Ansible](http://docs.ansible.com/)


### Workflow

1. Clone the repository:

        git clone git@github.com:borbit/minefield-flags.git
        cd minefield-flags

2. Provision a VM using Vagrant and SSH inside:

        vagrant up
        vagrant ssh
        cd /opt/minefield-flags

3. Run minefield-flags using Foreman:

        foreman start


Production
----------

### Requirements

* Ansible


### Workflow

1. Clone the repository:

        git clone git@github.com:borbit/minefield-flags.git
        cd minefield-flags

2. Go into `ansible` directory:

        cd ansible

3. Run Ansible:

        ansible-playbook -i production --ask-sudo-pass all.yml


License
-------

[Do WTF You Want to Public License](http://www.wtfpl.net/)
