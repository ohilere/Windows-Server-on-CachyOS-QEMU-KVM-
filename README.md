# High-Performance Windows Server on CachyOS (QEMU/KVM)

This repository documents the setup of a Windows Server 2022 virtual machine on CachyOS (Arch Linux) using the QEMU/KVM stack. It focuses on performance tuning and overcoming common virtualization hurdles like network routing and file sharing.

## 💻 Environment
* **Host:** CachyOS (Linux 6.x Kernel, Optimized for Performance)
* **Guest:** Windows Server 2022
* **Hypervisor:** QEMU/KVM
* **Frontend:** Virt-Manager / Libvirt



## 🛠️ Installation & Setup

### 1. The Virtualization Stack
To ensure a full feature set (including networking and UEFI support), I installed the following dependencies:
| Package | Description |
| :--- | :--- |
| `qemu-full` | The core emulator and virtualizer |
| `virt-manager` | GUI for managing VMs |
| `libvirt` | The API daemon for virtualization |
| `dnsmasq` | Required for virtual network DHCP/DNS |

Using this command;
```bash
sudo pacman -S --needed qemu-full virt-manager libvirt dnsmasq iptables-nft virt-viewer vde2
```

### 2. Permissions
In Linux, certain hardware features (like the KVM accelerator) are protected by default Only the "root" (super-user) can touch them. To manage the hypervisor without using sudo every time, I added my user to the relevant groups by running this command, giving myself a "VIP badge" so that user account can talk directly to the CPU's virtualization features without needing to ask for a password every five seconds.
```bash
sudo usermod -aG libvirt,kvm $USER
```
Running Windows Server Virtual machine
![image alt](https://github.com/ohilere/Windows-Server-on-CachyOS-QEMU-KVM-/blob/131bc9cc1af621f8da0119f45339e925067266f6/Vm%20screenshot.png)

### 3. Drivers
In order to install all the drivers necessary to run windows server on qemu-kvm,Viortio drivers were downloaded from the official github repository [virtio-win-pkg-scripts](https://github.com/virtio-win/virtio-win-pkg-scripts/blob/master/README.md). Thereafter installed the virtio-win drivers and the virt-win-guest-tools
![image alt](https://github.com/ohilere/Windows-Server-on-CachyOS-QEMU-KVM-/blob/769b303aa03b3c1b0dcaadec33de04bd55c8e7a3/Installing%20virtio%20screenshot.png)

### 4.Fileshare 
After completely setting up the vm, i wanted to also share a storage drive between the host and the virtual machine
![image alt](https://github.com/ohilere/Windows-Server-on-CachyOS-QEMU-KVM-/blob/131bc9cc1af621f8da0119f45339e925067266f6/Fileshare%20screenshot.png)

## 🚧 Challenges & Solutions
Virtualization is rarely "plug and play." Here are the two biggest hurdles I encountered and cleared:

- The internet connectivity wall - "No Internet": The virtual bridge (virbr0) was blocked by the host firewall.

- Shared Folder Struggle (VirtIO-FS): Windows Server doesn't natively speak VirtIO-FS without help.

Detailed steps for these are located in the [Troubleshooting Guide](https://github.com/ohilere/Windows-Server-on-CachyOS-QEMU-KVM-/blob/main/docs/troubleshooting.md).
