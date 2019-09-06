#!/bin/bash

# This script is been developed by kabantsh 
# 				on 2019-09-06 	
# for more information please contact with the email kabantsh@gmail.com
################
# Prerequisits:-
################
#1- Ubuntu 18.04.3
#2- Bash 4.2 or higher
#3- Etherwake.c: v1.09 



# Please enter your interface name here
my_interface=enp0s3
# Please enter your your mac address file path name here
myfile='mac_address.txt'
touch $myfile
outputfile='output_wol_script.txt'
touch $myfile


# to show how many lines in the mac address file
mylines=`wc -l $myfile | awk '{print $1}'`
echo "__$mylines__"
	echo -e "\n\n============++++++==============|> This folder has $mylines lines <|============++++++==============\n\n"



# function to split the file
split() {
	echo -e "\n\n%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n\n"
}
# to show interfaces of your device	
show_interface=`ifconfig | grep : | awk '{print $1}' | grep : | awk -F':' '{print $1}'`
split 
myindex_=`echo $show_interface | wc`
echo $show_interface
split
echo "please Enter your interface name ==> " 
echo "==========================================" 
read my_interface
$show_interface
# funtion to print if the host is up 
mac_is_up() {
         echo -e "\n\n ^=========|> This is Host is up $mymac <|=========^  \n\n"
 }
# funtion to print if the host is down 
mac_is_down() {
         echo -e "\n\n ^=========|> This is Host is down $mymac <|=========^  \n\n"
 }

 my_error(){
 	         echo -e "\n\n!!!!!!!!!!!!!!!!!!!!! > > Error code no $1 < < ''!!!!!!!!!!!!!!!!!!!  \n\n"

 }

##############################################################
### modify 5 to the number of mac address that do you have ###
##############################################################

#To know which how many lines in the shell 
for_index=`wc -l $myfile | awk '{print $1}'`
START=1
END=$for_index

for i in $(eval echo "{$START..$END}")
 do
	 
	 split
	mymac=`cat  $myfile | head -$i | tail -1`
#	set -x
	sleep 1
 	 # core command 
	#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	 etherwake $mymac -i $my_interface	#!!
	#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	 if [ $? == '0'  ]
	 then
		mac_is_up
		echo -e "$mymac\tThis device is starting now" >> $outputfile
	elif  [ $? == '3'  ]	
	then
		my_error 3
		mac_is_down 
		echo -e "$mymac\tThis device is not started now" >> $outputfile
	else 
	       echo -e "\n\n\n\nInvalid Syntax\n\n\n\n"	
	fi
	 
#	set +x
 done
