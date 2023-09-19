#!/bin/bash
unset LC_ALL

clear
echo
echo "Digite o endereço IP do carro:"
read -n12 -r choice

senha1="Rsco#3083"
senha2="rs#bus@3083"
porta1=2222
porta2=4444
clear

echo
echo "Você escolheu a opção $choice"
echo

senha=""
porta=""

sshpass -p "$senha1" ssh -T -a -p "$porta1" root@"$choice" <<EOF
echo '00 3 * * * /sbin/reboot' >> /var/spool/cron/crontabs/root
EOF

if [ $? -eq 0 ]; then
  echo "Conexão bem-sucedida com senha1/porta1!"
  senha="$senha1"
  porta="$porta1"
else
  echo "Conexão falhou com senha1/porta1. Tentando senha2/porta2..."
  sshpass -p "$senha2" ssh -T -a -p "$porta2" root@"$choice" <<EOF
  echo '00 3 * * * /sbin/reboot' >> /var/spool/cron/crontabs/root
EOF

  if [ $? -eq 0 ]; then
    echo "Conexão bem-sucedida com senha2/porta2!"
    senha="$senha2"
    porta="$porta2"
  else
    echo "Conexão falhou com todas as combinações."
  fi
fi

echo
echo "----------------------------------------------------------------------------------"
echo "                            Atualização concluída"
echo "----------------------------------------------------------------------------------"
echo

read -n1 -r -s -p "Pressione qualquer tecla para reiniciar o sistema e voltar para o menu.."

sshpass -p "$senha" ssh -T -a -p "$porta" root@"$choice" <<EOF
/sbin/reboot
EOF
clear

./menu.sh
