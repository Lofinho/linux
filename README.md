# linux

# interfaces(5) file used by ifup(8) and ifdown(8)
# Include files from /etc/network/interfaces.d:
source /etc/network/interfaces.d/*

# IP ACESSO SMART
auto eth1:0
iface eth1:0 inet static
        address 10.1.1.200
        netmask 255.0.0.0

# IP ACESSO RIO DOURO
auto eth1:1
iface eth1:1 inet static
        address 100.70.0.200
        netmask 255.0.0.0

# IP ACESSO FLORES
auto eth1:2
iface eth1:2 inet static
        address 100.128.0.200
        netmask 255.0.0.0

# IP ACESSO REAL RIO
auto eth1:3
iface eth1:3 inet static
        address 100.133.0.200
        netmask 255.0.0.0

# IP ACESSO MAGELI
auto eth1:4
iface eth1:4 inet static
        address 100.167.0.200
        netmask 255.0.0.0

# IP ACESSO BEIRA MAR
auto eth1:5
iface eth1:5 inet static
        address 100.171.0.200
        netmask 255.0.0.0

# IP ACESSO ROBUSTO (DEFAULT)
auto eth1:6
iface eth1:6 inet static
        address 172.1.1.200
        netmask 255.0.0.0

auto wlan0:0
iface wlan0:0 inet static
        address 10.0.0.1
        netmask 255.0.0.0

auto wlan1:1
iface wlan1:1 inet static
        address 10.0.0.1
        netmask 255.0.0.0

