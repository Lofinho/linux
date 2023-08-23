#!/bin/bash

clear


echo "----------------------------------------------------------------------------------------------------"
echo "                            Programa de testes de ping e velocidade de banda larga"
echo "----------------------------------------------------------------------------------------------------"
echo
echo "Digite o Endereço IP do carro:"
read carro

clear

echo
echo "					Testando $carro"
echo

ping -c 5 $carro | grep 64 | head -n +6

speed=$(ethtool eth0 | grep Speed)
duplex=$(ethtool eth0 | grep Duplex)

echo
echo "Velocidade de banda larga:"
echo
echo "$speed"
echo "$duplex"
echo

read -n1 -r

./menu.sh
