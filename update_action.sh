#!/bin/bash

function setup_environment(){
mkdir -p `pwd`/result
mkdir -p `pwd`/configure
dos2unix `pwd`/* >/dev/null 2>&1
dos2unix `pwd`/*/* >/dev/null 2>&1
}


function Do_detect_hosts(){
local file="`pwd`/result/test.conf"

test -f "${file}" && rm -rf "${file}"

#预测广告厂商重复的hosts
local number1=0
local number2=31
for i in $(seq $number1 $number2)
do
#127.0.0.1 img$i.360buyimg.com
#127.0.0.1 lf$i-short.bytegoofy.com
#127.0.0.1 polaris$i-normal-hl.zijieapi.com
#127.0.0.1 polaris$i-normal-lq.zijieapi.com
#127.0.0.1 lf$i-cdn-tos.bytescm.com
#127.0.0.1 gecko$i-hl.zijieapi.com
#127.0.0.1 gecko$i-lq.zijieapi.com
#127.0.0.1 v$i-default.ixigua.com
#127.0.0.1 log$i-applog-hl.fqnovel.com
#127.0.0.1 gecko$i-hl.zijieapi.com
#127.0.0.1 gecko$i-lq.zijieapi.com
#127.0.0.1 polaris$i-normal-hl.zijieapi.com
#127.0.0.1 polaris$i-normal-lq.zijieapi.com
#127.0.0.1 api$i-normal-lq.fqnovel.com
#127.0.0.1 api$i-normal-hl.fqnovel.com
#127.0.0.1 mon$i-misc-lf.fqnovel.com
#127.0.0.1 lf$i-common-ckv-tos.pstatp.com
#127.0.0.1 valipl.cp$i.ott.cibntv.net
#127.0.0.1 vali-g1.cp$i.ott.cibntv.net
#127.0.0.1 v$i-novelapp.ixigua.com
#127.0.0.1 lf$i-common-ckv-tos.pstatp.com
#127.0.0.1 tnc3-alisc1.bytedance.com
#127.0.0.1 tnc3-bjlgy.bytedance.com

echo "
127.0.0.1 p$i-ad-sign.byteimg.com
127.0.0.1 vs$i.bj2cm.u3.ucweb.com
127.0.0.1 vs$i.bj2cu.u3.ucweb.com
127.0.0.1 vs$i.bj2ct.u3.ucweb.com
127.0.0.1 vs${i}.bj2.u3.ucweb.com
127.0.0.1 vs$i.gzct.u3.ucweb.com
127.0.0.1 vs$i.gzcu.u3.ucweb.com
127.0.0.1 vs$i.gzcm.u3.ucweb.com
127.0.0.1 ${i}gtest.bj2cu.u3.ucweb.com
127.0.0.1 ads$i-normal-lq.zijieapi.com
127.0.0.1 ads$i-normal-lf.zijieapi.com
127.0.0.1 ads$i-normal-hl.zijieapi.com
127.0.0.1 ads$i-normal.zijieapi.com
127.0.0.1 p$i-orange.byteorge.com
127.0.0.1 lf$i-common-ckv-tos.pstatp.com
127.0.0.1 v$i-ad.ixigua.com
127.0.0.1 api-access.pangolin-sdk-toutiao${i}.com
127.0.0.1 api-access.pangolin-sdk-toutiao${i}-b.com
127.0.0.1 xn--pan-ei"$i"e.xn--baidu-jm6h.com
" >> "${file}"
done

#蓝奏云拦截域名
for i in s d z ;do
cat <<key >> "${file}"
127.0.0.1 lanzou$i.com
127.0.0.1 cbzhk.lanzou$i.com
127.0.0.1 wwa.lanzou$i.com
127.0.0.1 wws.lanzou$i.com
127.0.0.1 www.lanzou$i.com
127.0.0.1 wwe.lanzou$i.com
key
done
}


function wipe_value() {
	local file="${1}"
	#去除特殊符号
	echo -e "\n去除特殊符号……"
	sed -i '/^#/d;/^[[:space:]]*$/d' "${file}"
	sed -i '/\[/d;/^[[:space:]]*$/d' "${file}"
	sed -i '/\]/d;/^[[:space:]]*$/d' "${file}"
	sed -i '/<.*>/d;/^[[:space:]]*$/d' "${file}"
	sed -i '/^@/d;/^[[:space:]]*$/d' "${file}"
	sed -i 's|[[:space:]]$||g' "${file}"
	#去除特殊的0.0.0.0符号
	echo -e "\n去除特殊0.0.0.0符号……"
	sed -i 's|^0.0.0.0[[:space:]]|127.0.0.1 |g' "${file}"
	sed -i 's|^0.0.0.0	|127.0.0.1 |g' "${file}"
	sed -i 's|^0.0.0.0[[:space:]][[:space:]]|127.0.0.1 |g' "${file}"
	sed -i 's|^0.0.0.0[[:space:]][[:space:]][[:space:]]|127.0.0.1 |g' "${file}"
	sed -i 's|^0.0.0.0[[:space:]][[:space:]][[:space:]][[:space:]]|127.0.0.1 |g' "${file}"
	#去除特殊的127.0.0.1符号
	echo -e "\n去除特殊127.0.0.1符号……"
	sed -i 's|^127.0.0.1	|127.0.0.1 |g' "${file}"
	sed -i '/^127.0.0.1[[:space:]]#/d;/^[[:space:]]*$/d' "${file}"
	sed -i 's|^127.0.0.1[[:space:]][[:space:]]|127.0.0.1 |g' "${file}"
	sed -i 's|^127.0.0.1[[:space:]][[:space:]][[:space:]]|127.0.0.1 |g' "${file}"
	sed -i 's|^127.0.0.1[[:space:]][[:space:]][[:space:]][[:space:]]|127.0.0.1 |g' "${file}"
	sed -i 's|^127.0.0.1    |127.0.0.1 |g' "${file}"
	#去除"::"回环
	echo -e "\n去除回环符号……"
	sed -i 's|^::[[:space:]]|127.0.0.1 |g' "${file}"
	sed -i 's|^::[[:space:]][[:space:]]|127.0.0.1 |g' "${file}"
}

#Host去重
function mk_new_file() {
	local file=$1
	local new=$( cat "${file}"  | sort | uniq | sed '/^[[:space:]]*$/d' )
	echo -e "$new" > "${file}"
}

#下载新的hosts
function download_hosts() {
local file="${1}"
local IFS=$'\n'
local tmp_DIR="`pwd`/tmp_hosts"
mkdir -p "${tmp_DIR}"

#adhost 禁用 2022.11.20
#https://raw.githubusercontent.com/E7KMbb/AD-hosts/master/system/etc/hosts|AdHost
#http://someonewhocares.org/hosts/|someonewhocares

local hosts_list='
https://hblock.molinero.dev/hosts|hblock
https://raw.githubusercontent.com/Goooler/1024_hosts/master/hosts|1024
https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn-social/hosts|StevenBlack
https://raw.githubusercontent.com/VeleSila/yhosts/master/hosts|yhost
https://raw.githubusercontent.com/jdlingyu/ad-wars/master/hosts|大圣净化
https://hosts.oisd.nl/basic|oisd
https://neodev.team/lite_host|neodev
https://raw.githubusercontent.com/rentianyu/ad-set-hosts/master/hosts|小贝塔
https://raw.githubusercontent.com/E7KMbb/AD-hosts/master/system/etc/hosts|E7KMbb
https://raw.githubusercontent.com/ilpl/ad-hosts/master/hosts|ilpl
https://raw.githubusercontent.com/neodevpro/neodevhost/master/host|neodevpro
https://raw.githubusercontent.com/afwfv/DD-AD/main/rule/hosts.txt|DD
https://raw.githubusercontent.com/AdguardTeam/cname-trackers/master/data/combined_disguised_ads_justdomains.txt|AdguardTeam
https://raw.githubusercontent.com/mitchellkrogza/Badd-Boyz-Hosts/master/hosts|Badd-Boyz-Hosts
https://raw.githubusercontent.com/bigdargon/hostsVN/master/hosts|hostsVN
https://raw.githubusercontent.com/FiltersHeroes/KADhosts/master/KADhosts.txt|KADhosts
https://raw.githubusercontent.com/shreyasminocha/shady-hosts/main/hosts|shady-hosts
https://urlhaus.abuse.ch/downloads/hostfile|URLHaus
https://raw.hellogithub.com/hosts|冷莫hosts加速github
'

echo -e "\n※下载hosts中……"
for i in ${hosts_list}
do
	HostURL="$(echo "${i}" | cut -d'|' -f1)"
	Hostname="$(echo "${i}" | cut -d'|' -f2)"
	curl -k -L -o "${tmp_DIR}/$Hostname" "${HostURL}" >/dev/null 2>&1 && echo -e "※[ ${Hostname} ] 下载成功！" || echo -e "[ ${Hostname} ]下载失败！"
	hosts_original="$(cat ${tmp_DIR}/$Hostname 2>/dev/null )"
	echo -e "${hosts_original}" >> "${file}"
done
test ! -f "${file}" && echo -e "${file} 不存在！！" && exit 1
}

function grep_value_file() {
local value="${2}"
local file="${3}"
local word="${1}"
test $word == 1 && word='-iw' || word='-i'
local targetdir="`pwd`/result"
if test -e "${file}" ;then 
	mkdir -p "${targetdir}"
	hosts_value="$( cat ${file} 2>/dev/null | grep $word ${value} ${file} | sed '/^#/d;/^[[:space:]]*$/d' )"
echo -e "${hosts_value}" > "${targetdir}/${value}.conf" && echo -e "已经输出[ ${value} ]"
fi
}

function wipe_logcat() {
local file="$1"
local list="
errlogos
errlog
errlogs
eventlog
extlog
xlog
xlogs
logs
log
alog
alogs
ulog
ulogs
toblog
tobapplog
"
local IFS=$'\n'
if test -f "$file" ;then
	for i in $list 
		do
		echo -e "$(grep -wvi "$i" "$file")" > "$file"
	done
fi
}

function exclude_value() {
local conf="${1}"
local target="${2}"
if test -e $conf ;then 
echo -e "[$(date +%y-%m-%d-%T)] ※执行排除文件["${conf}"]下的规则……※\n"
	for i in $(cat "${conf}" 2>/dev/null | sed '/^#.*/d;/^[[:space:]]*$/d' )
		do
			sed -i "/$i/d" "${target}"
	done && echo -e "[$(date +%y-%m-%d-%T)] ※已排除[${conf}]文件中的规则※\n"
fi
}

function add_custo() {
local conf_file="${1}"
local target="${2}"
if test -e "${conf_file}" ;then
	cp -rf "${conf_file}" "${target}/${conf_file##*/}.conf" && echo -e "[$(date +%y-%m-%d-%T)] ※复制["${conf_file}"]※\n" || echo -e "[$(date +%y-%m-%d-%T)] ※复制["${conf_file}"]失败！※\n"
fi
}

function combine_file() {
local target_dir="${1}"
local output="${2}"
test -e "${output}" && rm -rf "${output}"
if test -e "${target_dir}" ;then
	echo -e "[$(date +%y-%m-%d-%T)] ※合并规则中……※\n"
for i in ${target_dir}/*.conf ;do
echo -e "$(cat $i 2>/dev/null )" >>"${output}"
done && echo -e "[$(date +%y-%m-%d-%T)] ※完成合并规则！※\n" || echo -e "[$(date +%y-%m-%d-%T)] ※合并失败！※\n"
	if test -e "${output}" ;then
		echo -e "[$(date +%y-%m-%d-%T)] ※筛选重复项中……※\n"
cat <<key > "${output}" && echo -e "[$(date +%y-%m-%d-%T)] ※筛选重复项完成！※\n" || echo -e "[$(date +%y-%m-%d-%T)] ※筛选失败！※\n"
$(cat "${output}" | sort | uniq | sed '/^#.*/d;/^[[:space:]]*$/d' )
key
		wipe_logcat "${output}"
	fi
fi
}

function modtifly() {
local targetfile="${1}"
sed -i '/\#/d' "${targetfile}"
sed -i '/\]/d' "${targetfile}"
sed -i '/\[/d' "${targetfile}"
sed -i '/(/d' "${targetfile}"
sed -i '/)/d' "${targetfile}"
}

function remove_ad() {
local file="$1"
local target="$2"
local local_host_file="$3"
test -f "${target}" && rm -rf "${target}"
cat "${file}" 2>/dev/null | sed '/^#/d;/^[[:space:]]*$/d' | while read host ;do
echo -e "127.0.0.1 $host" >> "$target"
done
cat <<key >> $local_host_file
#广告奖励
$(cat "$target" 2>/dev/null )
#END
key
}

#写入信息
function write_head() {
local target_file="${1}"
local total_count="$(cat ${target_file} 2>/dev/null | sed '/^#/d;/^[[:space:]]*$/d' | wc -l )"
sed -i "1i #@coolapk 1007" "${target_file}"
sed -i "2i #有问题可以在文件里搜索关键词" "${target_file}"
sed -i "3i #例如\"toutiao(头条)\"，\"MIUI xiaomi (小米)\"，\"reward(奖励)\"" "${target_file}"
sed -i "4i #在相应行的开头加个\"\#\"号" "${target_file}"
sed -i "5i #更新时间: $(date '+%F %T') " "${target_file}"
sed -i "6i 127.0.0.1 localhost" "${target_file}"
sed -i "7i ::1 localhost" "${target_file}"
sed -i "8i ::1 ip6-loopback" "${target_file}"
sed -i "9i ::1 ip6-localhost" "${target_file}"
sed -i "10i #规则数量:${total_count}" "${target_file}"
sed -i '11i ##################\n' "${target_file}"
}

function write_ad_block_reward_rules(){
file="${1}"
cat << key >> "$file"
$(cat "`pwd`/configure/add.prop")
key
}

function adblock() {
echo -e "[$(date +%y-%m-%d-%T)] ※制作Adblock规则……※\n"
local old_file="${1}"
local file="${old_file%/*}/adb.txt"
echo "$(cat $old_file )" > "${file}"
if test -f "$file" ;then
	sed -i "s|^#|!|g" "$file"
	sed -i "/^::1/d;/translate.google.com/d;/translate.googleapis.com/d" "$file"
	sed -i "s/127.0.0.1[[:space:]]localhost//g" "$file"
	sed -i "s/127.0.0.1 /||/g;s|$|^|g" "$file"
	sed -i "s/^\^//g" "$file"
	sed -i "1i [Host 10007]" "$file"
	sed -i "1i [Adblock Plus 2.0]" "$file"
	sed -i "2i ! Title: Host 10007" "$file"
	sed -i "3i ! Homepage: https://github.com/lingeringsound/10007_auto " "$file"
	sed -i "3i ! ZH_Homepage: https://www.gitlink.org.cn/keytoolazy/10007_auto " "$file"
	sed -i "4i ! Last modified: `date +'%F %T'`" "$file"
	write_ad_block_reward_rules "${file}"
fi
}

function mktouch_host() {
add_custo `pwd`/configure/自定义.prop `pwd`/result
add_custo `pwd`/configure/魅族.conf `pwd`/result
combine_file `pwd`/result `pwd`/all
exclude_value `pwd`/configure/排除列表.prop `pwd`/all
exclude_value `pwd`/configure/保留奖励.prop `pwd`/all
modtifly `pwd`/all
remove_ad `pwd`/configure/广告奖励.prop `pwd`/result/广告奖励.conf `pwd`/all
write_head `pwd`/all
}

function mktouch_no_host() {
add_custo `pwd`/configure/自定义.prop `pwd`/result
add_custo `pwd`/configure/魅族.conf `pwd`/result
combine_file `pwd`/result `pwd`/reward
exclude_value `pwd`/configure/排除列表.prop `pwd`/reward
exclude_value `pwd`/configure/保留奖励.prop `pwd`/reward
modtifly `pwd`/reward
write_head `pwd`/reward
}


function RUnning_SETUPS_environment(){
setup_environment
setup_environment
download_hosts `pwd`/host
mk_new_file `pwd`/host
wipe_value `pwd`/host
setup_environment
}

function RUnning_grep_values_conf(){
local hosts_file=`pwd`/host
cat "${hosts_file}" >> "${file}"




}

#开始运行
#设置环境
RUnning_SETUPS_environment
#筛选设定值
RUnning_grep_values_conf
Do_detect_hosts
#制作去除广告奖励的Host
mktouch_host
#制作不包含广告奖励的Host
mktouch_no_host
#制作adblock规则
adblock `pwd`/reward
#统计
rm -rf `pwd`/result `pwd`/host `pwd`/tmp_hosts
test -f `pwd`/reward && echo "文件大小 $( du -sh `pwd`/reward )，hosts数量: $(cat `pwd`/reward | wc -l ) "
test -f `pwd`/all && echo "文件大小 $( du -sh `pwd`/all )，hosts数量: $(cat `pwd`/all | wc -l ) "
test -f `pwd`/adb.txt && echo "文件大小 $( du -sh `pwd`/adb.txt )，hosts数量: $(cat `pwd`/adb.txt | wc -l ) "
