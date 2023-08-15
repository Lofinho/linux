#!/bin/bash
unset LC_ALL

clear
echo
echo "Digite o endereço IP do carro:"
read -n10 -r choice

senha="Rsco#3083"

clear

echo
echo "Você escolheu a opção $choice"
echo

sshpass -p "$senha" ssh -T -a -p 2222 root@"$choice" <<EOF
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

sshpass -p "$senha" ssh -T -a -p 2222 root@"$choice" <<EOF
/sbin/reboot
EOF
clear

./menu.sh
