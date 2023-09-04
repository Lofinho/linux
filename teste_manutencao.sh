#!/bin/bash

clear

echo "----------------------------------------------------------------------------------------------------"
echo "                            Programa de testes de ping e velocidade de banda larga"
echo "----------------------------------------------------------------------------------------------------"
echo
echo "Digite o EndereÃ§o IP do carro:"
read -n12 -r carro

clear

echo
echo "                    Testando $carro"
echo

ping -c 5 "$carro" | grep 64 | head -n +6

speed=$(sudo ethtool eth1 | grep Speed)
duplex=$(sudo ethtool eth1 | grep Duplex)
echo 

echo
echo "Velocidade de banda larga:"
echo
echo "$speed"
echo "$duplex"
echo

senha=""
porta=""

senha1="rs#bus@3083"
porta1="4444"
senha2="Rsco#3083"
porta2="2222"

echo "Carregando dados do IP $carro..."

# Tentar combinaÃ§Ã£o senha1/porta1
sshpass -p "$senha1" ssh -o StrictHostKeyChecking=no root@"$carro" -p "$porta1" "date" >/dev/null 2>&1
if [ $? -eq 0 ]; then
  echo "ConexÃ£o bem-sucedida com senha1/porta1!"
  echo "Carregando data..."
  senha="$senha1"
  porta="$porta1"
else
  # Tentar combinaÃ§Ã£o senha2/porta2
  sshpass -p "$senha2" ssh -o StrictHostKeyChecking=no root@"$carro" -p "$porta2" "date" >/dev/null 2>&1
  if [ $? -eq 0 ]; then
    echo "ConexÃ£o bem-sucedida com senha2/porta2!"
    echo "Carregando data..."
    senha="$senha2"
    porta="$porta2"
  else
    echo "ConexÃ£o falhou com todas as combinaÃ§Ãµes."
  fi
fi

show_data=$(sshpass -p "$senha" ssh -o StrictHostKeyChecking=no root@"$carro" -p "$porta" "date")
echo "Data da máquina remota: $show_data"

read -n1 -r

./menu.sh
