# Bootc Image with PyTorch and GPU support

## Resources

* https://bootc-org.gitlab.io/documentation/
* https://github.com/osbuild/bootc-image-builder

# Prerequisites

* RHSM subscription - org ID and activation key
* A non-root user with sudo permissions
* Optional for running a VM:
    * Install KVM for running a VM
        ```console
        sudo dnf install -y qemu-kvm libvirt virt-install virt-viewer
        sudo systemctl enable libvirtd --now
        ```
    * Enable PCI pass-through to allow attaching a GPU to a VM - add `intel_iommu=on` to the host's [boot arguments](https://access.redhat.com/solutions/6668601).
    * [Update KVM/libvirt permission](https://ostechnix.com/solved-cannot-access-storage-file-permission-denied-error-in-kvm-libvirt/).
