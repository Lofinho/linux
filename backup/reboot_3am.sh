#!/bin/bash
unset LC_ALL

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

senha="Rsco#3083"

clear

echo
echo "Você escolheu a opção $choice, Endereço IP: $host"
echo

sshpass -p "$senha" ssh -T -a -p 2222 root@"$host" <<EOF
echo '00 3 * * * /sbin/reboot' >> /var/spool/cron/crontabs/root
EOF

if [ $? -ne 0 ]; then
  echo "----------------------------------------------------------------------------------"
  echo "A mensagem acima mostra que o computador não conseguiu conectar-se ao equipamento"
  echo "  Por favor verifique o cabo de rede conectado, e o Endereço IP do equipamento   "
  echo "----------------------------------------------------------------------------------"
  read -n1 -r -s
  exit 1
fi

echo
echo "----------------------------------------------------------------------------------"
echo "                            Atualização concluída"
echo "----------------------------------------------------------------------------------"
echo

read -n1 -r -s -p "Pressione qualquer tecla para reiniciar o sistema e voltar para o menu.."

sshpass -p "$senha" ssh -T -a -p 2222 root@"$host" <<EOF
/sbin/reboot
EOF
clear

./menu.sh
