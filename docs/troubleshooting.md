# 🛠️ Troubleshooting & Hurdles

Setting up Windows Server 2022 on an optimized Arch-based system like CachyOS isn't always a "next-next-finish" process. Here is how I solved the major roadblocks.

## 1. Network Isolation (The Firewall Wall)
**The Problem:** The VM had no internet access. While the virtual network was "active" in Virt-Manager, the CachyOS host was dropping traffic at the firewall level.



**The Fix:** I had to tell the Uncomplicated Firewall (UFW) to allow and route traffic specifically for the virtual bridge (`virbr0`). 
```bash
# Allow traffic to flow out to the internet
sudo ufw route allow in on virbr0 out on wlan0
# Allow return traffic back to the VM
sudo ufw route allow in on wlan0 out on virbr0
# Ensure the bridge itself can accept connections
sudo ufw allow in on virbr0
```
## 2. Shared Folders (VirtIO-FS Setup)
**The Problem**: I needed to move files between CachyOS and the Windows VM. Simply adding a "shared folder" in Virt-Manager settings resulted in errors or the drive not appearing in Windows Explorer.

**The Fix**:
Windows Server doesn't natively understand the VirtIO-FS protocol without external help.

- Drivers: Mounted the virtio-win.iso and installed the guest tools.

- WinFsp: Installed WinFsp (Windows File System Proxy). This is the "bridge" that allows Windows to treat the VirtIO-FS share as a local disk.

- Services: Once WinFsp was installed, the Virtio-FS Service in Windows finally started, and my shared folder appeared instantly.
