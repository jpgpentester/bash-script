#!/bin/bash
################################################################################
#	    __ ____  ____  ____ ____ __  __ _____ ____ ___  ______ ___ ___ 144     #
#      / / __  / ___// __  /___// / / /__  __/ __/ ___/__  __/ __/ __ \        #
#   __/ / /_/ / /__ / /_/ / __//  \/ /  / / / __/\ \    / / / __/ /_/_/        #
#  / / /  ___/ /_/ /  ___/ /_ / /\  /  / / / /_ __\ \  / / / /_/ /\ \          #
#  \__/__/   \____/__/  /___//_/ \_/  /_/ /___//____/ /_/ /___/_/  \_\         #
#     netmon.sh                             v1.8                               #
#                                                                              #
# VERSION                                                                      #
# 1.8                                                                          #
#                                                                              #
# CHANGELOG                                                                    #
# - create new log directory                                                   #
# - monitor and log active network connections                                 #
# - display all log per date                                                   #
# - delete all logs                                                            #
# - ability to export all ip address from the logs                             #
#                                                                              #
# FILE                                                                         #
# netmon.sh                                                                    #
#                                                                              #
# DATE CREATED        LAST DATE MOD                                            #
# 24JUN2021           18AUG2021                                                #
#                                                                              #
# DESCRIPTION                                                                  #
# Simple script that display and record active network connections             #
#                                                                              #
# AUTHOR              EMAIL                                                    #
# Jose Paulo Garcia   jpgpentester.github @ geemail.com                        #
#                                                                              #
################################################################################

#### VARIABLE DECLARATIONS ####
currentDate=`date '+%m%d%Y'`
#currentTime=`date '+%m%d%Y-%H%M%S'`
logFile=netstat-$currentDate.txt
logDir=~/logs
ipFile=ip.txt
ipDir=~/ipaddress

## BASH COLOR OUTPUT ##
RED="\033[01;31m"
GREEN="\033[01;32m"
YELLOW="\033[01;33m"
BLUE="\033[01;34m"
BEIGE="\033[01;36m"
RESET="\033[00m"

#### END OF VARIABLE DECLARATION ####


#### FUNCTION DECLARATIONS ####
_mainMenu() {
    clear
    echo 
    echo
    echo -e "${BLUE}     __ ____  ____${RESET}${RED}  _____ ____ __  __ _____ ____ ___  ______ ___ ___ 144"
    echo -e "${BLUE}    / / __  / ___/${RESET}${RED} / __  /___// / / /__  __/ __/ ___/__  __/ __// __ \  ${RESET}"
    echo -e "${BLUE} __/ / /_/ / /___ ${RESET}${RED}/ /_/ / __//  \/ /  / / / __/\ \    / / / __// /_/_/  ${RESET}"
    echo -e "${BLUE}/ / /  ___/ /_/ /${RESET}${RED}/  ___/ /_ / /\  /  / / / /_ __\ \  / / / /_ / /\ \    ${RESET}"
    echo -e "${BLUE}\__/__/   \____/${RESET}${RED}/__/  /___//_/ \_/  /_/ /___//____/ /_/ /___//_/  \_\   ${RESET}"
    echo -e "    ${BEIGE}netmon.sh                                          v1.8${RESET}"
    echo
    echo "1. Monitor active connections"
    echo "2. Display all logs"
    echo "3. Purge all logs and records"
    echo "4. Export all IP address"
    echo "5. Resolve all IP address"
    echo "6. Exit program"
    echo

    read -p "Please choose from above: " userInput
    echo
}

_isDirExist() {

    if ! [ -d $1 ]
    then
        echo ""
        echo "No logs found."
        echo ""
        echo "[!] To start monitoring active network connection choose option #1 from main menu."
        echo ""
        echo "Good bye."
        echo ""
        exit
    fi
}
#### END OF FUNCTION DECLARATIONS ####


#### MAIN SCRIPT ####

_mainMenu
    
if [ $userInput = "1" ]		# 1. Monitor active connections
then
    echo "[i] Saving... $logDir"
    sleep 5
    
    if ! [ -d $logDir ]
    then
        mkdir -m 700 $logDir
        mkdir -m 700 $ipDir
        echo "[i] SUCCESS: Directory created in $logDir"
    fi
    
    echo
    echo "[i] Displaying current network connections... (Ctrl + C to exit):"
    echo
    
    for i in $(seq 1 1000); do
        if [ $i -le 1 ]
        then
	        echo "[!] ATTN: Please use sudo to identify all processes and non-owned process info."
	        echo
	    fi
	
	    sleep 5
        
        date >> $logDir/$logFile
        sudo netstat -antp | grep ESTABLISHED >> $logDir/$logFile
        
        date
        sudo netstat -antp | grep ESTABLISHED
        
        echo;
    done

elif [ $userInput = "2" ]	# 2. DISPLAY ALL LOGS
then
    _isDirExist $logDir
    
    for log in $(ls $logDir); do
        cat $logDir/$log
    done
    
elif [ $userInput = "3" ] 	# 3. CLEAR ALL LOGS
then
    _isDirExist $logDir
    
    echo "[!] Purging all logs and records in 20 seconds... (Ctrl + c to cancel)"
    sleep 20
    
    rm -rf $logDir		# DELETE ALL LOG DIRECTORY AND IP ADDRESS DIRECTORY
    rm -rf $ipDir
    
    echo
    echo "Purge complete."
    echo 
    
elif [ $userInput = "4" ] 	# 4. Export all IP address
then
    _isDirExist $logDir
    
    echo
    echo "[!] Retrieving all IP address from all logs. Please wait..."
    echo

    sleep 2

    for logFound in $(ls $logDir); do
        cat $logDir/$logFound >> $ipDir/$ipFile;
    done

    cat $ipDir/$ipFile | grep EST | cut -d " " -f 23 | sort -u | grep "." | cut -d ":" -f 1 | sort -n
    cat $ipDir/$ipFile | grep EST | cut -d " " -f 23 | sort -u | grep "." | cut -d ":" -f 1 | sort -n >>  $ipDir/backup-$ipFile

    echo
    echo "Retrieval process complete."
    echo

elif [ $userInput = "5" ] 	# 5. Resolve all IP address
then
    _isDirExist $logDir
    
    _isDirExist $ipDir
    
    echo
    echo "Resolving IP adrresses. Please wait..."
    echo
    
    sleep 2
    
    for ip in $(cat $ipDir/$ipFile | grep EST | cut -d " " -f 23 | sort -u | grep "." | cut -d ":" -f 1 | sort -n); do
        echo "$ip: " $(whois $ip | grep -i NetName | cut -d ":" -f 2)
	echo "$ip: " $(whois $ip | grep -i NetName | cut -d ":" -f 2) >> $logDir/backup-resolved-$ipFile;
    done

elif [ $userInput = "6" ] # 6. Exit program
then
    echo
    echo "Good bye."
    echo
    exit 0

else
    echo "Invalid input. Please restart program."
    exit 1
fi

#### END OF MAIN SCRIPT ####

