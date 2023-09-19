#!/bin/bash
unset LC_ALL

senha2="Rsco#3083"
senha1="rs#bus@3083"
porta2="2222"
porta1="4444"

clear
echo
echo "Digite o endereço IP do carro:"
read -n12 -r choice

clear

echo
echo "Você escolheu o IP: $choice"
echo
echo "----------------------------------------------------"
echo "              Atualiza Data e Hora                  "
echo "----------------------------------------------------"
echo

data=$(date +"%m/%d/%Y %R")
senha=""
porta=""

sshpass -p "$senha1" ssh -T -o StrictHostKeyChecking=no -p "$porta1" root@"$choice" <<EOF
hwclock --set --date "$data"
hwclock -s
EOF

if [ $? -eq 0 ]; then
  echo "Conexão bem-sucedida com senha1/porta1!"
  senha="$senha1"
  porta="$porta1"
else
  echo "Conexão falhou com senha1/porta1. Tentando senha2/porta2..."
  sshpass -p "$senha2" ssh -T -o StrictHostKeyChecking=no -p "$porta2" root@"$choice" <<EOF
  hwclock --set --date "$data"
  hwclock -s
EOF

  if [ $? -eq 0 ]; then
    echo "Conexão bem-sucedida com senha2/porta2!"
    senha="$senha2"
    porta="$porta2"
  else
    echo "Conexão falhou com todas as combinações."
  fi
fi

clear
echo
echo "----------------------------------------------------"
echo "              Data e Hora atualizados"
echo "----------------------------------------------------"
echo

read -r -p "Pressione qualquer tecla para reiniciar o equipamento e voltar ao menu..."
echo

sshpass -p "$senha" ssh -T -o StrictHostKeyChecking=no -p "$porta" root@"$choice" /sbin/reboot
echo
clear

./menu.sh
