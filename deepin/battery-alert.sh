#!/bin/bash

#Função validar se o percentual de bateria é menor que 10%
function verificaBateria(){

  export DISPLAY=:0

  #variaveis de comparacao
  batAlert=15
  batResult=$(getBateriaPercentual)
  stsResult=$(getStatusCarregamento)

  #se o computador ja esta sendo carregado
  if [ $stsResult == 'Discharging' ]
  then
    #achei magic no index.html baixado?
    if [ $batResult -lt $batAlert ]
    then
      notify-send "Sua bateria está muito fraca ($batResult%)." "Plugue seu carregador agora."
    fi
  fi
}

#Funcao para recuperar o percentual da bateria do computador
function getStatusCarregamento(){
	stsCharg=$(cat /sys/class/power_supply/BAT0/status)
	echo $stsCharg
}

#Funcao para recuperar o percentual da bateria do computador
function getBateriaPercentual(){
	batPercent=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0| grep -E 'percentage' | awk '{print $2}' | sed 's/%//g')
	echo $batPercent
}

#chamar funcao forticlientLogin
verificaBateria
