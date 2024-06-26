# Argonauti ALM local Virtual Machine

**WORK IN PROGRESS**

The following repository describes the provisioning of a Virtual Machine to Application Lifecycle Managements purposes.

Since we do not have enough resources, the aim is to standardise the CI/CD and other operations processes for Project Argonauti.

This will be until dedicated resources are available to centralize the processes.

---

### Prerequisites

- Git-Client installed
- Vagrant installed
- VirtualBox installed
- Windows Hyper-v enabled (to use Hyper-v instead VBox)
- Access to Project Argonauti's Git repositories
- Bash environment (Linux, MacOS, or Windows with Git Bash)
- Availability of 4vCPUS, 8GB RAM and 50GB Storage

### Usage

[`run.sh`](./run.sh) script is designed to automate the management of virtual machines and Git repositories related to the Project Argonauti. It provides functionalities for starting and stopping virtual machines with Vagrant, managing Git repository synchronization, and setting up the necessary environments for local development.

```bash
./argnoauti_alm_run.sh [command]
```

Where `[command]` can be:
- `start`: Start or provision the virtual machine if it's already running.
- `stop`: Stop the virtual machine.
- `destroy`: Stop the virtual machine.

If no command is provided, the script defaults to `start`.

To use another provider, set as system var `VAGRANT_DEFAULT_PROVIDER` [(by default is set to `virtualbox`)](./argnoauti_alm_run.sh).

At the moment this vagrant project is ready only for `virtualbox` (work in progress on `hyperv`)

For more details, see [official documentation](https://developer.hashicorp.com/vagrant/docs/providers/basic_usage#default-provider)


---

### Important Notes

- The idea is to have the Virtual Machine running on-demand, better after OS startup.
- The script should be run from a directory where it has permissions to create directories and write files, as it may need to clone repositories and create directories.
- Ensure your SSH keys are set up correctly for accessing private repositories on GitHub.
- Ensure your SSH client is properly configured (see [ssh_config manual](https://linux.die.net/man/5/ssh_config))
- When dedicated resources are available, this project will archive.
- For hyper-v/vagrant integration, see requirements in [vagrant documentation](https://developer.hashicorp.com/vagrant/docs/providers/hyperv)

---

### Contributing

Contributors are welcome to propose improvements or add new features via pull requests. Please ensure that you test the changes locally before submitting.
