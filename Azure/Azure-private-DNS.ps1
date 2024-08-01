


$grp1 = "rg-kasmServer"
$grp2 = "rg-Bastion"
$grp3 = "rg-Vnet1"
$grp4 = "rg-kasm-backup"
$grp4 = "rg-mgt"
$locationWe = "westeurope"
$locationChNorh = "switzerlandnorth"
$locationWE = "westeurope"
$VNetName1 = "vnet-1"
$subnetName1 = "FrontEnd"
$subnetName2 = "LanEnd"
$vmName1 = "Kasm"
$vmName2 = "mgt"
$NSGName1 = "KasmNSG"
$NSGName2 = "BastionNSG"
$PubIP1 = "KasmPublicIP"
$PubIP2 = "BastionPublicIP"

# DEKETE RESOURCE GROUPs and its content
Remove-AzResourceGroup -Name $grp1 -Force -AsJob
Remove-AzResourceGroup -Name $grp2 -Force -AsJob
Remove-AzResourceGroup -Name $grp3 -Force -AsJob

# CREATE RESOURCE GROUPs
New-AzResourceGroup -Name $grp1 -Location $locationWE
New-AzResourceGroup -Name $grp2 -Location $locationWE
New-AzResourceGroup -Name $grp3 -Location $locationWE

# CREATE VIRTUAL NETWORK
$vnet1 = @{
    Name              = $VNetName1
    ResourceGroupName = $grp3
    Location          = $locationWE
    AddressPrefix     = "10.10.0.0/16"
}
$virtualNetwork = New-AzVirtualNetwork @vnet1

# ADDING FrontEnd SUBNET
$subnet = @{
    Name           = $subnetName1
    VirtualNetwork = $virtualNetwork
    AddressPrefix  = "10.10.10.0/24"
}
$subnetConfig = Add-AzVirtualNetworkSubnetConfig @subnet
# Associate this subnet to the Virtual Network
$virtualNetwork | Set-AzVirtualNetwork

# ADDING LAN SUBNET
$subnet = @{
    Name           = $subnetName2
    VirtualNetwork = $virtualNetwork
    AddressPrefix  = "10.10.20.0/24"
}
$subnetConfig = Add-AzVirtualNetworkSubnetConfig @subnet
# Associate this subnet to the Virtual Network
$virtualNetwork | Set-AzVirtualNetwork

########### BASTION ###########
# ADDING Bastion SUBNET to the VNET
$subnet = @{
    Name           = "AzureBastionSubnet" #standard name. This name can not be customised
    VirtualNetwork = $virtualNetwork
    AddressPrefix  = "10.10.30.0/24"
}
$subnetConfig = Add-AzVirtualNetworkSubnetConfig @subnet
# Associate this subnet to the Virtual Network
$virtualNetwork | Set-AzVirtualNetwork

# CREATE A PUBLIC IP FOR BASTION
$ip = @{
    ResourceGroupName = $grp2
    Name              = $PubIP2
    Location          = $locationWE
    AllocationMethod  = 'Static'
    Sku               = 'Standard'
    Zone              = 1, 2, 3
}
New-AzPublicIpAddress @ip

# ADD A BASTION SKU
$bastion = @{
    Name                  = 'bastion'
    ResourceGroupName     = $grp2
    PublicIpAddressRgName = $grp2
    PublicIpAddressName   = $PubIP2
    VirtualNetworkRgName  = $grp3
    VirtualNetworkName    = $VNetName1
    Sku                   = "Basic"
}
New-AzBastion @bastion


# CREATING VMs IN EACH SUBNET
# CREATING A KASM Server VM
# Set the administrator and password for the VM. ##
$cred = Get-Credential

## Place the virtual network into a variable. ##
$vnet = Get-AzVirtualNetwork -Name $VNetName1 -ResourceGroupName $grp3

## Create a network interface for the VM. ##
$nic = @{
    Name = "nic-1"
    ResourceGroupName = $grp1
    Location = $locationWE
    Subnet = $vnet.Subnets[0]
}
$nicVM = New-AzNetworkInterface @nic

## Create a virtual machine configuration. ##
$vmsz = @{
    VMName = $vmName1
    VMSize = "Standard_L32as_v3"
}
$vmos = @{
    ComputerName = $vmName1
    Credential   = $cred
}
$vmimage = @{
    PublisherName = 'Canonical'
    Offer         = '0001-com-ubuntu-server-jammy'
    Skus          = '22_04-lts-gen2'
    Version       = 'latest'    
}
$vmConfig = New-AzVMConfig @vmsz | Set-AzVMOperatingSystem @vmos -Linux | Set-AzVMSourceImage @vmimage | Add-AzVMNetworkInterface -Id $nicVM.Id

## Create the VM. ##
$vm = @{
    ResourceGroupName = $grp1
    Location          = $locationWE
    VM                = $vmConfig
}
New-AzVM @vm -AsJob # J'ai ajouté AsJob pour ne pas bloquer la console pendant la creation du vm


# CREATE A PUBLIC IP FOR Kasm
$ip = @{
    ResourceGroupName = $grp1
    Name              = $PubIP1
    Location          = $locationWE
    AllocationMethod  = 'Static'
    Sku               = 'Standard'
    Zone              = 1, 2, 3
}
New-AzPublicIpAddress @ip





# CREATING A KASM Server VM 
New-AzVm -ResourceGroupName $grp1 -Name $vmName1 -Location $locationWE -Image 'xxx' -VirtualNetworkName $vnetName -SubnetName $subnetName1 -SecurityGroupName $NSGName1 -OpenPorts 80, 443, 22

# CREATING A Windowws Server BASTION VM 
New-AzVm -ResourceGroupName $grp4 -Name $vmName2 -Location $locationWE -Image 'MicrosoftWindowsServer:WindowsServer:2022-datacenter-azure-edition:latest' -VirtualNetworkName $VNetName1 -SubnetName $subnetName1 -OpenPorts 80, 3389


apt-get update -y
apt-get upgrade -y
apt-get install apache2 -y

echo "Hello Business Logic VM!" > /var/www/html/index.html

jpm@kyos.ch
# INSTALL KASM SERVER ON SIGNLE SERVER
# 1. Install Kasm
cd /tmp
curl -O https://kasm-static-content.s3.amazonaws.com/kasm_release_1.14.0.3a7abb.tar.gz
tar -xf kasm_release_1.14.0.3a7abb.tar.gz
sudo bash kasm_release/install.sh
sudo bash kasm_release/install.sh -L [your own port]

# 2. Install Caddy for Reverse Proxy
sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https curl && curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key'
sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg && curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt'
sudo tee /etc/apt/sources.list.d/caddy-stable.list && sudo apt update && sudo apt install caddy
# Edit the Caddyfile
sudo nano /etc/caddy/Caddyfile
# Paste config
kasm.cybercrime-atlas.net {
    # change the port
	reverse_proxy https://127.0.0.1:443 {
		transport http {
			tls_insecure_skip_verify
		}
	}
}
# Restart Caddy
sudo systemctl reload caddy

# 3.
https://kasmweb.com/docs/latest/how_to/reverse_proxy.html


+C4rp3e13m@-