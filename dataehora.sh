#!/bin/bash
unset LC_ALL

senha="Rsco#3083"
clear
echo
echo "Digite o endereço IP do carro:"
read -n10 -r choice

clear

echo
echo "Você escolheu a opção $choice"
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

sshpass -p "$senha" ssh -T -a -p 2222 root@"$choice" <<EOF
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

sshpass -p "$senha" ssh -T -a -p 2222 root@"$choice" /sbin/reboot
echo
clear

./menu.sh
