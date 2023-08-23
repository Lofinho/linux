#!/bin/bash
unset LC_ALL

senha="Rsco#3083"
clear
echo
echo "Escolha uma opção de conexão:"
echo
echo "1) Wifi 5G -- Endereço IP: 10.1.1.1"
echo "2) Adaptador Gigabit LAN -- Endereço IP: 192.168.0.1"
echo
echo "Digite o número da sua escolha:"
read -r choice


if [ $choice = 1 ]; then
  host="10.1.1.1"
elif [ $choice = 2 ]; then
  host="192.168.0.1"
else
  echo "Opção inválida"
exit
fi

clear

echo
echo "Você escolheu a opção $choice, Endereço IP: $host"
echo
echo "----------------------------------------------------"
echo "              Atualiza Data e Hora                  "
echo "----------------------------------------------------"
echo

<<EOF
/bin/rm /etc/localtime 2>/dev/null
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
echo America/Sao_Paulo > /etc/localtime

/etc/init.d/cron restart
/etc/init.d/ntp restart
EOF

data=$(date +"%m/%d/%Y %R")

sshpass -p "$senha" ssh -T -a -p 2222 root@"$host" <<EOF
hwclock --set --date "$data"
hwclock -s
EOF

if [ $? -ne 0 ]; then
  echo " ----------------------------------------------------------------------------------- "
  echo "| A mensagem acima mostra que o computador não conseguiu conectar-se ao equipamento |"
  echo "|   Por favor verifique o cabo de rede conectado, e o Endereço IP do equipamento    |"
  echo " ----------------------------------------------------------------------------------- "
  read -n1 -r -s
  exit 1
fi

clear
echo
echo "----------------------------------------------------"
echo "              Data e Hora atualizados"
echo "----------------------------------------------------"
echo

read -r -p "Pressione qualquer tecla para reiniciar o equipamento e voltar ao menu..."
echo

sshpass -p "$senha" ssh -T -a -p 2222 root@"$host" /sbin/reboot
echo
clear

./menu.sh
