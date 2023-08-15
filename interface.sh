#!/bin/bash
clear

libs=(dialog sshpass ethtool)

for program in $libs; do
  if ! command -v "$program" &>/dev/null; then
    sudo apt install "$program"
  fi
done

# Diretório onde se encontram os scripts
diretorio_scripts="/home/matias/"

# Função para exibir o menu principal
menu() {
  dialog --backtitle "                           RioService - Programas de teste manutenção" \
         --title "Menu de Scripts" \
         --cancel-label "Sair" \
         --menu "Escolha uma opção:" 12 50 5 \
         1 "Atualização Data e Hora" \
         2 "Agendamento de reinicialização 3 da manhã" \
         3 "Acessar IP (em desenvolvimento)" \
         4 "Ferramentas de teste da manutenção" \
         0 "Sair" 2> opcao

  if [ $? -eq 1 ]; then
    clear
    echo "Operação cancelada pelo usuário."
    clear
    exit 1
  fi

  opcao=$(cat opcao)
}

# Função para exibir o código Bash correspondente à opção selecionada
exibir_codigo_bash() {
  case "$1" in
    1)
      cat "$diretorio_scripts/dataehora.sh"
      ;;
    2)
      cat "$diretorio_scripts/reboot_3am.sh"
      ;;
    3)
      cat "$diretorio_scripts/altera_ip.sh"
      ;;
    4)
      cat "$diretorio_scripts/teste_manutencao.sh"
      ;;
  esac
}

# Função para executar os scripts baseados na escolha do usuário
executar_script() {
  case "$1" in
    1)
      exibir_codigo_bash "$1"
      bash "$diretorio_scripts/dataehora.sh"
      ;;
    2)
      exibir_codigo_bash "$1"
      bash "$diretorio_scripts/reboot_3am.sh"
      ;;
    3)
      exibir_codigo_bash "$1"
      bash "$diretorio_scripts/altera_ip.sh"
      ;;
    4)
      exibir_codigo_bash "$1"
      bash "$diretorio_scripts/teste_manutencao.sh"
      ;;
  esac
}

# Loop para manter a interface aberta até que o usuário escolha sair (opção 0)
while true; do
  menu
  [ "$opcao" == 0 ] && break
  executar_script "$opcao"
  clear
done

clear
exit