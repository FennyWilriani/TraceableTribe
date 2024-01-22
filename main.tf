terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.9.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.5.7"
}

provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "rg-sessionhosts" {
    name = "rg-${var.prefix}-avd-session-hosts"
}

resource "azurerm_resource_group" "rg-vnet" {
  name     = "rg-${var.prefix}-vnet-01"
  location = var.location
}

resource "azurerm_virtual_network" "vnet-avd" {
  name                = "${var.prefix}-vnet"
  address_space       = var.vnet_range
  location            = var.location
  resource_group_name = azurerm_resource_group.rg-vnet.name
}

# Create subnets
resource "azurerm_subnet" "subnet" {
  name                 = "${var.prefix}-public-subnet"
  resource_group_name  = azurerm_resource_group.rg-vnet.name
  virtual_network_name = azurerm_virtual_network.vnet-avd.name
  address_prefixes     = var.subnet_range
}

resource "azurerm_network_security_group" "nsg" {
  name                = "${var.prefix}-NSG"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg-vnet.name
  security_rule {
    name                       = "allow-rdp"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  depends_on = [data.azurerm_resource_group.rg-sessionhosts]
}

resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# Create public IP
resource "azurerm_public_ip" "pub-ip" {
  name                = "${var.prefix}-Public-IP"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg-vnet.name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = [1]
}

#Nat Gateway
resource "azurerm_nat_gateway" "NAT" {
  name                    = "${var.prefix}-NAT"
  location                = var.location
  resource_group_name     = azurerm_resource_group.rg-vnet.name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  zones                   = [1]
}

# Nat - Public IP Association
resource "azurerm_nat_gateway_public_ip_association" "NAT-ip" {
 nat_gateway_id       = azurerm_nat_gateway.NAT.id
 public_ip_address_id = azurerm_public_ip.pub-ip.id
}

# NAT - Subnets association
resource "azurerm_subnet_nat_gateway_association" "nat-assoc" {
 subnet_id      = azurerm_subnet.subnet.id
 nat_gateway_id = azurerm_nat_gateway.NAT.id
}

# Route Table
resource "azurerm_route_table" "avd" {
  name                          = "rt-${var.prefix}-avd"
  location                      = azurerm_resource_group.rg-vnet.location
  resource_group_name           = azurerm_resource_group.rg-vnet.name
  disable_bgp_route_propagation = false

  route {
    name                   = "rt-avd"
    address_prefix         = "10.2.0.0/24"
    next_hop_type          = "VirtualNetworkGateway"
  }

  tags = {
    Solution = "AVD"
  }
}