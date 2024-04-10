# Bootc Image with PyTorch and GPU support

## Resources

* https://bootc-org.gitlab.io/documentation/
* https://github.com/osbuild/bootc-image-builder

## Prerequisites

* RHSM subscription - org ID and activation key
* A non-root user with sudo permissions
* Optional for running a VM:
    * Install KVM for running a VM
        ```console
        $ sudo dnf install -y qemu-kvm libvirt virt-install virt-viewer
        $ sudo systemctl enable libvirtd --now
        ```
    * Enable PCI pass-through to allow attaching a GPU to a VM - add `intel_iommu=on` to the host's [boot arguments](https://access.redhat.com/solutions/6668601).
    * [Update KVM/libvirt permission](https://ostechnix.com/solved-cannot-access-storage-file-permission-denied-error-in-kvm-libvirt/).

## Attaching a host PCI device to a VM

Attaching a PIC device to a running VM can be done either via the VM manager GUI (`Add Hardware` > `PCI Host Device`), or using the CLI:

1. Create an XML file, e.g. _pci-device.xml_:

    ```xml
    <hostdev mode='subsystem' type='pci' managed='yes'>
    <driver name='vfio'/>
    ​  <source>
    ​    <address domain='0x<domain>'
    ​             bus='0x<bus>'
    ​             slot='0x<slot>'
    ​             function='0x<function>'/>
    ​  </source>
    ​</hostdev>

    ```

2. Attach the device to the VM:

    ```console
    $ sudo virsh attach-device <domain> pci-device.xml
    ```

**Note**: A host PCI device can be attached when creating a VM, but I never tried that:

* [Assigning a PCI Device with virt-install](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/virtualization_host_configuration_and_guest_installation_guide/sect-pci_adding_with_virtinstall).
* [Managing GPU devices in virtual machines](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9/html/configuring_and_managing_virtualization/assembly_managing-gpu-devices-in-virtual-machines_configuring-and-managing-virtualization).

## Verifying

One of the ways to verify that the GPU is being used, after booting into a bootable image:

```console
$ curl -O https://raw.githubusercontent.com/waggle-sensor/gpu-stress-test/main/stress.py
$ python stress.py
```

and observe `nvidia-smi`.

Triggering utilization of multiple GPUs (e.g. 0 through 2):

```console
$ curl -O https://raw.githubusercontent.com/waggle-sensor/gpu-stress-test/main/stress.py
$ for i in $(seq 0 2); do (CUDA_VISIBLE_DEVICES=$i python stress.py &) ; done
```