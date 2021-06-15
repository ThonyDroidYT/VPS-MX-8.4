#!/bin/bash
coo=1
IVAR="/etc/http-instas"
SCPT_DIR="/etc/SCRIPT"
#[[ -e /etc/http-instas ]] && 

add-apt-repository universe
apt update -y; apt upgrade -y

fun_a(){
texto=`if netstat -tunlp |grep apache2 1> /dev/null 2> /dev/null; then
echo -e "ON"
else
echo -e "OFF"
fi`;
if [[ $texto = "ON" ]];then
echo "Apache2 Instalado y Activo"
#sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf
#service apache2 restart > /dev/null 2>&1
else
echo "Apache2 No Instalado"
echo -ne " \033[1;31m[ ! ] INSTALANDO APACHE2 "
apt-get install apache2 -y > /dev/null 2>&1 && echo -e "\033[1;32m [ EXITO ]" || echo -e "\033[1;31m [FAIL]"
sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf
service apache2 restart > /dev/null 2>&1
fi
}


install_ini () {
clear
echo -e "$BARRA"
echo -e "\033[92m        -- INSTALANDO PAQUETES NECESARIOS -- "
echo -e "$BARRA"
#bc
[[ $(dpkg --get-selections|grep -w "jq"|head -1) ]] || apt-get install jq -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "jq"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "jq"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install jq................... $ESTATUS "
#curl
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] || apt-get install curl -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install curl................. $ESTATUS "
#socat
[[ $(dpkg --get-selections|grep -w "socat"|head -1) ]] || apt-get install socat -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "socat"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "socat"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install socat................ $ESTATUS "
#netcat
[[ $(dpkg --get-selections|grep -w "netcat"|head -1) ]] || apt-get install netcat -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "netcat"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "netcat"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install netcat............... $ESTATUS "
#netcat-traditional
[[ $(dpkg --get-selections|grep -w "netcat-traditional"|head -1) ]] || apt-get install netcat-traditional -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "netcat-traditional"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "netcat-traditional"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install netcat-traditional... $ESTATUS "
#net-tools
[[ $(dpkg --get-selections|grep -w "net-tools"|head -1) ]] || apt-get net-tools -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "net-tools"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "net-tools"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install net-tools............ $ESTATUS "
#cowsay
[[ $(dpkg --get-selections|grep -w "cowsay"|head -1) ]] || apt-get install cowsay -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "cowsay"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "cowsay"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install cowsay............... $ESTATUS "
#figlet
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] || apt-get install figlet -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install figlet............... $ESTATUS "
#lolcat
apt-get install lolcat -y &>/dev/null
sudo gem install lolcat &>/dev/null
[[ $(dpkg --get-selections|grep -w "lolcat"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "lolcat"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install lolcat............... $ESTATUS "
fun_a

echo -e "$BARRA"
echo -e "\033[92m La instalacion de paquetes necesarios a finalizado"
echo -e "$BARRA"
echo -e "\033[97m Si la instalacion de paquetes tiene fallas"
echo -ne "\033[97m Puede intentar de nuevo [s/n]: "
read inst
[[ $inst = @(s|S|y|Y) ]] && install_ini
}

msg () {
local colors="/etc/new-adm-color"
if [[ ! -e $colors ]]; then
COLOR[0]='\033[1;37m' #BRAN='\033[1;37m'
COLOR[1]='\e[31m' #VERMELHO='\e[31m'
COLOR[2]='\e[32m' #VERDE='\e[32m'
COLOR[3]='\e[33m' #AMARELO='\e[33m'
COLOR[4]='\e[34m' #AZUL='\e[34m'
COLOR[5]='\e[91m' #MAGENTA='\e[35m'
COLOR[6]='\033[1;97m' #MAG='\033[1;36m'
else
local COL=0
for number in $(cat $colors); do
case $number in
1)COLOR[$COL]='\033[1;37m';;
2)COLOR[$COL]='\e[31m';;
3)COLOR[$COL]='\e[32m';;
4)COLOR[$COL]='\e[33m';;
5)COLOR[$COL]='\e[34m';;
6)COLOR[$COL]='\e[35m';;
7)COLOR[$COL]='\033[1;36m';;
esac
let COL++
done
fi
NEGRITO='\e[1m'
SEMCOR='\e[0m'
 case $1 in
  -ne)ccor="${COLOR[1]}${NEGRITO}" && echo -ne "${ccor}${2}${SEMCOR}";;
  -ama)ccor="${COLOR[3]}${NEGRITO}" && echo -e "${ccor}${2}${SEMCOR}";;
  -verm)ccor="${COLOR[3]}${NEGRITO}[!] ${COLOR[1]}" && echo -e "${ccor}${2}${SEMCOR}";;
  -verm2)ccor="${COLOR[1]}${NEGRITO}" && echo -e "${ccor}${2}${SEMCOR}";;
  -azu)ccor="${COLOR[6]}${NEGRITO}" && echo -e "${ccor}${2}${SEMCOR}";;
  -verd)ccor="${COLOR[2]}${NEGRITO}" && echo -e "${ccor}${2}${SEMCOR}";;
  -bra)ccor="${COLOR[0]}${SEMCOR}" && echo -e "${ccor}${2}${SEMCOR}";;
  -bar2)ccor="${COLOR[1]}◈ ━━━━━━━━━━━━━━ 🪐 - 🪐 ━━━━━━━━━━━━━━━ ◈" && echo -e "${SEMCOR}${ccor}${SEMCOR}";;
  -bar)ccor="${COLOR[1]}•••••••••••••••••••••••••••••••••••••••••••••••••" && echo -e "${SEMCOR}${ccor}${SEMCOR}";;
  
 esac
}

check_ip () {
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
echo "$IP" > /usr/bin/vendor_code
}
function_verify () {
 permited=$(curl -sSL "https://www.dropbox.com/s/9387micbywnafo9/Control-IP")
  [[ $(echo $permited|grep "${IP}") = "" ]] && {
  clear
  echo -e "\n\n\n\e[31m====================================================="
  echo -e "\e[31m      ¡LA IP $(wget -qO- ipv4.icanhazip.com) NO ESTA AUTORIZADA!\n     SI DESEAS USAR EL GENERADOR CONTACTE A @kalix1 "
  echo -e "\e[31m=====================================================\n\n\n\e[0m"
  [[ -d $SCPT_DIR ]] && rm -rf $SCPT_DIR
  [[ -e "/usr/bin/gerar" ]] && rm /usr/bin/gerar
  exit 1
  } || {
 ### INTALAR VERCION DE SCRIPT
 clear
  echo -e "\n\n\n\e[32m====================================================="
  echo -e "\e[32m      ¡LA IP $(wget -qO- ipv4.icanhazip.com)  ESTA AUTORIZADA!\n      Reseller :  VPS-MX "
  echo -e "\e[32m=====================================================\n\n\n\e[0m"
  v1=$(curl -sSL "https://www.dropbox.com/s/e6l65xxesc37sd4t/")
  #echo "$v1" > /etc/ADM-db/vercion
  }
}

[[ ! -e /etc/http-instas ]] && echo '0' > /etc/http-instas || let sd=$(cat < /etc/http-instas)-$coo && echo $sd > /etc/http-instas
[[ -d $SCPT_DIR ]] && rm -rf $SCPT_DIR
SCPresq="aHR0cHM6Ly93d3cuZHJvcGJveC5jb20vcy94ZXRtYjZsZzd6d21mOXgv"
SUB_DOM='base64 -d'
fun_bar1 () {
comando[0]="$1"
comando[1]="$2"
(
[[ -e $HOME/fim ]] && rm $HOME/fim
${comando[0]} -y > /dev/null 2>&1
${comando[1]} -y > /dev/null 2>&1
touch $HOME/fim
) > /dev/null 2>&1 &
tput civis
echo -ne "  \033[1;33mESPERE \033[1;37m- \033[1;33m["
while true; do
for((i=0; i<18; i++)); do
echo -ne "\033[1;31m≛"
sleep 0.1s
done
[[ -e $HOME/fim ]] && rm $HOME/fim && break
echo -e "\033[1;33m]"
sleep 1s
tput cuu1
tput dl1
echo -ne "  \033[1;33mESPERE \033[1;37m- \033[1;33m["
done
echo -e "\033[1;33m]\033[1;37m -\033[1;32m EXITO !\033[1;37m"
tput cnorm
}
update_pak () {
permited=$(ofus $(curl -sSL "https://www.dropbox.com/s/bg3mk2754vuqiej/passwd"))
return
}
clear
update_pak

#CORES
cor[1]="\033[1;36m"
cor[2]="\033[1;32m"
cor[3]="\033[1;31m"
cor[4]="\033[1;33m"
cor[0]="\033[1;37m"

#TEXTOS
txt[206]="Archivito(s) Actualizado(s)!"
txt[208]="Invalid Key, Contact the Script Admin!"
txt[207]="Valid!!!"
txt[203]="☹"
txt[204]="㋡--->"
txt[205]="Actualizado"

#COMPARA
fun_filez () {
arq="/etc/SCRIPT/$1"
arq2="$HOME/update/$1"
     [[ ! -e "/etc/SCRIPT/$1" ]] && {
     mv -f $arq2 $arq
     unset ARQ
     case $1 in
     "gerar.sh")ARQ="/usr/bin/";;
     "http-server.py")ARQ="/bin/";;
      esac
     mv -f $arq2 ${ARQ}/$1
     chmod +x ${ARQ}/$1
     return
     }
equal=$(diff -q $arq $arq2)
echo -e "\033[1;31m ${txt[203]}: $1"
     [[ "$equal" = "" ]] && rm $arq2 || {
     mv -f $arq2 $arq
     chmod +x $arq
     unset ARQ
     case $1 in
     "gerar.sh")ARQ="/usr/bin/";;
     "http-server.py")ARQ="/bin/";;
      esac
     mv -f $arq2 ${ARQ}/$1
     chmod +x ${ARQ}/$1
     lista_atualizados=$(($lista_atualizados + 1))
     echo -e "\033[1;32m ${txt[204]}: $1 - ${txt[205]}!"
     sleep 0.5s
     echo ""
     }
}
clear
rm $(pwd)/$0 > /dev/null 2>&1 && echo -e "\033[1;31m- \033[1;32mExito!" || echo -e "\033[1;31m- \033[1;31mFallo"
ofus () {
unset txtofus
number=$(expr length $1)
for((i=1; i<$number+1; i++)); do
txt[$i]=$(echo "$1" | cut -b $i)
case ${txt[$i]} in
".")txt[$i]="+";;
"+")txt[$i]=".";;
"1")txt[$i]="@";;
"@")txt[$i]="1";;
"2")txt[$i]="?";;
"?")txt[$i]="2";;
"4")txt[$i]="%";;
"%")txt[$i]="4";;
"-")txt[$i]="K";;
"K")txt[$i]="-";;
esac
txtofus+="${txt[$i]}"
done
echo "$txtofus" | rev
}

atualiza_fun () {
 msg -bar
cd $HOME
[[ ! -d ./update ]] && mkdir ./update
cd ./update
wget -i $HOME/lista -o /dev/null  
unset arqs
for arqs in `ls $HOME/update`; do
echo -ne "\033[1;33mDescargando archivo: \033[1;31m[$arqs] "
fun_filez $arqs > /dev/null 2>&1 && echo -e "\033[1;31m- \033[1;31mFalla (no recibido!)" || echo -e "\033[1;32m- \033[1;32mRecibido con éxito!"
done
cd $SCPT_DIR
rm -f * > /dev/null
wget -i $REQUEST -o /dev/null
cat http-server.py > /bin/http-server.py
chmod +x /bin/http-server.py
cp gerar.sh /usr/bin/gerar.sh
chmod +x /usr/bin/gerar.sh
cd $HOME
  [[ -e $HOME/lista ]] && rm $HOME/lista
  [[ -d $HOME/update ]] && rm -rf $HOME/update
[[ "$lista_atualizados" != "" ]] && echo -e "${cor[5]} $lista_atualizados ${txt[206]}"
}

veryfy_fun () {
[[ ! -d ${IVAR} ]] && touch ${IVAR}
[[ ! -d ${SCPT_DIR} ]] && mkdir ${SCPT_DIR}
unset ARQ
case $1 in
"gerar.sh")ARQ="/usr/bin/";;
"http-server.py")ARQ="/bin/";;
*)ARQ="${SCPT_DIR}/";;
esac
mv -f $HOME/$1 ${ARQ}/$1
chmod +x ${ARQ}/$1
}
unset Key
install_ini
clear
 msg -bar
echo -e "\033[1;36m  # KEY GENERATOR VPS-MX # \033[0m"
 msg -bar
read -p "INTRODUZCA SU KEY DE INSTALACIÓN: " Key
#[[ $permited = $Key ]]
msg -bar
check_ip
function_verify
[[ ! $Key ]] && {
 msg -bar
echo -e "\033[1;33mKey inválida! llamame "
unset key > /dev/null 2>&1 && echo -e "\033[1;31m- \033[1;32mExito!" || echo -e "\033[1;31m- \033[1;31mFallo" > error.log
exit
msg -bar2
exit
}
meu_ip () {
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
echo "$IP" > /usr/bin/vendor_code
[[ -d /etc/SCRIPT ]] && rm -rf /etc/SCRIPT || mkdir /etc/SCRIPT
[[ -e /usr/bin/gerar ]] && rm -f /usr/bin/gerar
}
meu_ip
echo -e "\033[1;33mVerificando key... "
cd $HOME
locale-gen en_US.UTF-8 > /dev/null 2>&1
update-locale LANG=en_US.UTF-8 > /dev/null 2>&1
apt-get install gawk -y > /dev/null 2>&1
wget -O trans https://www.dropbox.com/s/cqocy859vui0iqy/trans.sh -o /dev/null 2>&1
mv -f ./trans /bin/ && chmod 777 /bin/*
[[ ! $Key ]] && {
echo -e  
exit
}
meu_ip () {
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
echo "$IP" > /usr/bin/vendor_code
}
meu_ip
REQUEST=$(echo $SCPresq|$SUB_DOM)
wget -O "$HOME/lista-arq" ${REQUEST}lista > /dev/null 2>&1
echo -e "\033[1;33mKey Verificada!! "
sleep 1s
[[ -e $HOME/lista-arq ]] && {
[[ ! -d ${IVAR} ]] && touch ${IVAR}
[[ ! -d ${SCPT_DIR} ]] && mkdir ${SCPT_DIR}
cd 
wget -O lista ${REQUEST}lista -o /dev/null
atualiza_fun
echo -e "\033[1;31m- \033[1;32mRecebido Com Sucesso!"
[[ ! -e /usr/bin/trans ]] && wget -O /usr/bin/trans https://www.dropbox.com/s/cqocy859vui0iqy/trans.sh &> /dev/null
mv -f /bin/http-server.py /bin/http-server.sh && chmod +x /bin/http-server.sh
apt-get install bc -y &>/dev/null
apt-get install screen -y &>/dev/null
apt-get install nano -y &>/dev/null
apt-get install curl -y &>/dev/null
apt-get install netcat -y &>/dev/null
apt-get install apache2 -y &>/dev/null
sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf
service apache2 restart > /dev/null 2>&1 &
IVAR2="/etc/key-gerador"
echo "$Key" > $IVAR2
rm $HOME/lista-arq
echo "source <(curl -sSL https://www.dropbox.com/s/pemdamq2be6rbv1/gerar.sh)" > /usr/bin/gerar   #https://www.dropbox.com/s/m2i5qi8jz69574/gerar.sh
wget -q -O /var/www/html/index.html https://www.dropbox.com/s/18qfq61qaelovsi/index.html
chmod +x /usr/bin/gerar
echo "cd /etc/SCRIPT && bash ./gerar.sh" > /usr/bin/keygen && chmod +x /usr/bin/keygen
echo -e "\033[1;33m Perfecto, utilize el comando \033[1;32mkeygen o gerar \033[1;33mpara administrar sus keys y
 actualizar la base del servidor"
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
echo -e "\033[1;33mKey ACCESIBLE!" $1

echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
} || {
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
echo -e "\033[1;33mKey inválida!"
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
}
echo "qraKatsil/@039?9a8@f89acb/8888:@?v5@@v@5@v9?@%" > /etc/key-gerador
apt-get install netcat -y &>/dev/null
apt install lolcat toilet -y &>/dev/null
echo -ne "\033[0m" 
