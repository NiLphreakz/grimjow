#!/bin/bash
# =========================================
# Quick Setup | Script Setup Manager
# Edition : Stable Edition V1.0
# Auther  : NiLphreakz
# (C) Copyright 2022
# =========================================
#wget https://github.com/${GitUser}/
GitUser="NiLphreakz"
#IZIN SCRIPT
MYIP=$(curl -sS ipv4.icanhazip.com)
echo -e "\e[32mloading...\e[0m"
clear
# Valid Script
VALIDITY () {
    today=`date -d "0 days" +"%Y-%m-%d"`
    Exp1=$(curl https://raw.githubusercontent.com/${GitUser}/allow/main/ipvps.conf | grep $MYIP | awk '{print $4}')
    if [[ $today < $Exp1 ]]; then
    echo -e "\e[32mYOUR SCRIPT ACTIVE..\e[0m"
    else
    echo -e "\e[31mYOUR SCRIPT HAS EXPIRED!\e[0m";
    echo -e "\e[31mPlease renew your ipvps first\e[0m"
    exit 0
fi
}
IZIN=$(curl https://raw.githubusercontent.com/${GitUser}/allow/main/ipvps.conf | awk '{print $5}' | grep $MYIP)
if [ $MYIP = $IZIN ]; then
echo -e "\e[32mPermission Accepted...\e[0m"
VALIDITY
else
echo -e "\e[31mPermission Denied!\e[0m";
echo -e "\e[31mPlease buy script first\e[0m"
exit 0
fi
echo -e "\e[32mloading...\e[0m"
clear
echo " "

#----- Auto Remove Vmess
data=( `cat /usr/local/etc/xray/vmess.json | grep '^#vms' | cut -d ' ' -f 2 | sort | uniq`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^#vms $user" "/usr/local/etc/xray/vmess.json" | cut -d ' ' -f 3 | sort | uniq)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" -le "0" ]]; then
sed -i "/^#vms $user $exp/,/^},{/d" /usr/local/etc/xray/vmess.json
sed -i "/^#vms $user $exp/,/^},{/d" /usr/local/etc/xray/vmessnone.json
rm -f /usr/local/etc/xray/$user-tls.json
rm -f /usr/local/etc/xray/$user-none.json
rm -f /usr/local/etc/xray/$user-clash-for-android.yaml
rm -f /home/vps/public_html/$user-clash-for-android.yaml
systemctl restart xray@vmess
systemctl restart xray@vmessnone
fi
done

#----- Auto Remove Vless
data=( `cat /usr/local/etc/xray/vless.json | grep '^#vls' | cut -d ' ' -f 2 | sort | uniq`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^#vls $user" "/usr/local/etc/xray/vless.json" | cut -d ' ' -f 3 | sort | uniq)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" -le "0" ]]; then
sed -i "/^#vls $user $exp/,/^},{/d" /usr/local/etc/xray/vless.json
sed -i "/^#vls $user $exp/,/^},{/d" /usr/local/etc/xray/vlessnone.json
systemctl restart xray@vless.service
systemctl restart xray@vlessnone
fi
done

#----- Auto Remove Trojan
data=( `cat /usr/local/etc/xray/trojan.json | grep '^#trws' | cut -d ' ' -f 2 | sort | uniq`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^#trws $user" "/usr/local/etc/xray/trojan.json" | cut -d ' ' -f 3 | sort | uniq)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" -le "0" ]]; then
sed -i "/^#trws $user $exp/,/^},{/d" /usr/local/etc/xray/trojan.json
sed -i "/^#trws $user $exp/,/^},{/d" /usr/local/etc/xray/trojannone.json
systemctl restart xray@trojan
systemctl restart xray@trojannone
fi
done

#----- Auto Remove Trojan TCP
data=( `cat /usr/local/etc/xray/akunxtr.conf | grep '^###' | cut -d ' ' -f 2 | sort | uniq`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^### $user" "/usr/local/etc/xray/akunxtr.conf" | cut -d ' ' -f 3 | sort | uniq)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" -le "0" ]]; then
sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/akunxtr.conf
sed -i "/^#trx $user $exp/,/^},{/d" /usr/local/etc/xray/tcp.json
systemctl restart xray@tcp
fi
done

#----- Auto Remove VLESS TCP XTLS
data=( `cat /usr/local/etc/xray/config.json | grep '^#vxtls' | cut -d ' ' -f 2 | sort | uniq`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^#vxtls $user" "/usr/local/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" -le "0" ]]; then
sed -i "/^#vxtls $user $exp/,/^},{/d" /usr/local/etc/xray/config.json
systemctl restart xray.service
fi
done

echo -e " Delete Exp User Xray Success (nilvpn)"
echo 
echo -e " Back To Menu In 2 Sec"
sleep 2
menu
