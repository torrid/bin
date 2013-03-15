#!/bin/bash

/sbin/modprobe nct6775 || exit 

hwpath=$(grep -H nct67  /sys/class/hwmon/hwmon*/device/name| sed -e 's#/name.*$##')

cd $hwpath || exit

FRONT_FAN=pwm3
BACK_FAN=pwm4
CPU_FAN=pwm2 

FRONT_SPEED=fan3_input
CPU_SPEED=fan2_input
BACK_SPEED=fan4_input

SOURCE_OUT=1
SOURCE_CHIP=2



for i in `seq 1 14`; do 
	in=$(cat in${i}_input); 
	let max=$in*105/100 ; 
	echo  $max > in${i}_max ; 
	let min=$in*95/100; 
	echo $min > in${i}_min;
	cat in${i}_alarm ; 
done


echo 0 > ${FRONT_FAN}_enable 
echo ${SOURCE_OUT} > ${FRONT_FAN}_temp_sel

echo 70 > ${FRONT_FAN}_auto_point1_pwm 
echo 90 > ${FRONT_FAN}_auto_point2_pwm 
echo 120 > ${FRONT_FAN}_auto_point3_pwm
echo 200 > ${FRONT_FAN}_auto_point4_pwm 
echo 255 > ${FRONT_FAN}_auto_point5_pwm 

echo "20000" > ${FRONT_FAN}_auto_point1_temp 
echo "35000" > ${FRONT_FAN}_auto_point2_temp 
echo "45000" > ${FRONT_FAN}_auto_point3_temp 
echo "47000" > ${FRONT_FAN}_auto_point4_temp 
echo "50000" > ${FRONT_FAN}_auto_point5_temp 
echo 5 > ${FRONT_FAN}_enable 

#####################################################################

echo 0 > ${BACK_FAN}_enable 
echo ${SOURCE_OUT} > ${BACK_FAN}_temp_sel
echo 90 > ${BACK_FAN}_auto_point1_pwm 
echo 100 > ${BACK_FAN}_auto_point2_pwm 
echo 160 > ${BACK_FAN}_auto_point3_pwm
echo 200 > ${BACK_FAN}_auto_point4_pwm 
echo 255 > ${BACK_FAN}_auto_point5_pwm 

echo "22000" > ${BACK_FAN}_auto_point1_temp 
echo "29000" > ${BACK_FAN}_auto_point2_temp 
echo "33000" > ${BACK_FAN}_auto_point3_temp 
echo "40000" > ${BACK_FAN}_auto_point4_temp 
echo "50000" > ${BACK_FAN}_auto_point5_temp 
echo 5 > ${BACK_FAN}_enable 

#####################################################################

echo 0 > ${CPU_FAN}_enable 

echo ${SOURCE_CHIP} > ${CPU_FAN}_temp_sel
echo 00 > ${CPU_FAN}_auto_point1_pwm 
echo 130 > ${CPU_FAN}_auto_point2_pwm 
echo 150 > ${CPU_FAN}_auto_point3_pwm
echo 200 > ${CPU_FAN}_auto_point4_pwm 
echo 255 > ${CPU_FAN}_auto_point5_pwm 

echo "27000" > ${CPU_FAN}_auto_point1_temp 
echo "35000" > ${CPU_FAN}_auto_point2_temp 
echo "37000" > ${CPU_FAN}_auto_point3_temp 
echo "40000" > ${CPU_FAN}_auto_point4_temp 
echo "50000" > ${CPU_FAN}_auto_point5_temp 

echo 5 > ${CPU_FAN}_enable 

