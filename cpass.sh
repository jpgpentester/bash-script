#!/bin/bash
################################################################################
#	   __ ____  ____  ____ ____ __  __ _____ ____ ___  ______ ___ ___ 144      #
#      / / __  / ___// __  /___// / / /__  __/ __/ ___/__  __/ __/ __ \        #
#   __/ / /_/ / /__ / /_/ / __//  \/ /  / / / __/\ \    / / / __/ /_/_/        #
#  / / /  ___/ /_/ /  ___/ /_ / /\  /  / / / /_ __\ \  / / / /_/ /\ \          #
#  \__/__/   \____/__/  /___//_/ \_/  /_/ /___//____/ /_/ /___/_/  \_\         #
#     cpass.sh                             v1.0                                #
#                                                                              #
# VERSION                                                                      #
# 1.0                                                                          #
#                                                                              #
# CHANGELOG                                                                    #
# - Generate random password                                                   #
#   a. lowercase characters                                                    #
#   b. uppercase characters                                                    #
#   c. number characters                                                       #
#   d. special characters                                                      #
#   e. all characters                                                          #
#                                                                              #
# FILE                                                                         #
# cpass.sh                                                                     #
#                                                                              #
# DATE CREATED        LAST DATE MOD                                            #
# 20SEP2021           20SEP2021                                                #
#                                                                              #
# DESCRIPTION                                                                  #
# Simple script that generate random passwords                                 #
#                                                                              #
# AUTHOR              EMAIL                                                    #
# Jose Paulo Garcia   jpgpentester.github @ geemail.com                        #
#                                                                              #
################################################################################

#### VARIABLE DECLARATIONS ####
choice=""
length=0
total=0
password=()

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
    echo -e "    ${BEIGE}cpass.sh                                          v1.0${RESET}"
    echo
    echo "1. Lowercase letters"
    echo "2. Uppercase letters"
    echo "3. Numbers"
    echo "4. Special characters"
    echo "5. All characters"
    echo "6. Exit"
    echo
    read -p "Please enter your choice: " choice
    
    case $choice in
        1) totalChar=26;;
        2) totalChar=26;;
        3) totalChar=10;;
        4) totalChar=14;;
        5) totalChar=76;;
        6) echo "Good Bye!"
           exit 0;;
        *) echo
           echo "Invalid input."
           exit 1;;
    esac

    echo
    read -p "Please length of your password: " total
    echo
}
#### END OF FUNCTION DECLARATIONS ####


#### MAIN SCRIPT ####

_mainMenu

while [[ length -lt $total ]]
do
    num=`date +%N | cut -c 8-9`
    
    if [[ ${#num} -eq 2 ]] 
    then
        if [[ $(echo $num | cut -c 1) -eq 0 ]]
        then
             num=$(echo $num | cut -c 2)
        fi
    fi
    
    if [[ $num -ge 0 && $num -le $totalChar ]]
    then
        if [[ $choice -eq 1 ]]
        then
            lower=(a b c d e f g h i j k l m n o p q r s t u v w x y z)    # 26 characters
            password[$length]=${lower[$num]}
            
            if [[ `expr $length % 2` -eq 0 ]]
            then
                color="${GREEN}"
            elif [[ `expr $length % 3` -eq 0 ]]
            then
                color="${YELLOW}"
	    else
	        color="${BLUE}"
	    fi
	    
	    # Uncomment to troubleshoot
	    # echo
	    # echo "Num: $num"
	    # echo "Length: $length"
	    echo -e "${color}${password[@]}${RESET}"
	    # sleep 2
	    
            declare -i length; length=length+1;
	    
	elif [[ $choice -eq 2 ]]
	then
	    upper=(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)    # 26 characters
	    password[$length]=${upper[$num]}
	    
	    if [[ `expr $length % 2` -eq 0 ]]
            then
                color="${GREEN}"
            elif [[ `expr $length % 3` -eq 0 ]]
            then
                color="${YELLOW}"
	    else
	        color="${BLUE}"
	    fi
	    
	    # Uncomment to troubleshoot
	    # echo
	    # echo "Num: $num"
	    # echo "Length: $length"
	    echo -e "${color}${password[@]}${RESET}"
	    # sleep 2
	    
            declare -i length; length=length+1;
            
	elif [[ $choice -eq 3 ]]
	then    
	    number=(0 1 2 3 4 5 6 7 8 9 0)                                 # 10 characters
	    password[$length]=${number[$num]}
	    
	    if [[ `expr $length % 2` -eq 0 ]]
            then
                color="${GREEN}"
            elif [[ `expr $length % 3` -eq 0 ]]
            then
                color="${YELLOW}"
	    else
	        color="${BLUE}"
	    fi
	    
	    # Uncomment to troubleshoot
	    # echo
	    # echo "Num: $num"
	    # echo "Length: $length"
	    echo -e "${color}${password[@]}${RESET}"
	    # sleep 2
	    
            declare -i length; length=length+1;
            
	elif [[ $choice -eq 4 ]]
	then
	    special=('!' '@' '$' '%' '^' '-' '_' '+' '=' ':' ',' '.' '?' '~')                         # 14 characters
	    password[$length]=${special[$num]}
	    
	    if [[ `expr $length % 2` -eq 0 ]]
            then
                color="${GREEN}"
            elif [[ `expr $length % 3` -eq 0 ]]
            then
                color="${YELLOW}"
	    else
	        color="${BLUE}"
	    fi
	    
	    # Uncomment to troubleshoot
	    # echo
	    # echo "Num: $num"
	    # echo "Length: $length"
	    echo -e "${color}${password[@]}${RESET}"
	    # sleep 2
	    
            declare -i length; length=length+1;
            
        elif [[ $choice -eq 5 ]]
        then
            all=(a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z 0 1 2 3 4 5 6 7 8 9 0 '!' '@' '$' '%' '^' '-' '_' '+' '=' ':' ',' '.' '?' '~')    # 76
            password[$length]=${all[$num]}
	    
	    if [[ `expr $length % 2` -eq 0 ]]
            then
                color="${GREEN}"
            elif [[ `expr $length % 3` -eq 0 ]]
            then
                color="${YELLOW}"
	    else
	        color="${BLUE}"
	    fi
	    
	    # Uncomment to troubleshoot
	    # echo
	    # echo "Num: $num"
	    # echo "Length: $length"
	    echo -e "${color}${password[@]}${RESET}"
	    # sleep 2
	    
            declare -i length; length=length+1;
            
	else
	    echo "Encountered error."
	    exit 1
	fi       
    fi
done

box="${password[@]}"
echo
echo -e "${GREEN}Password: ${RESET}$(echo $box | sed s/' '/''/g)"
echo
echo -e "${GREEN}Complete.${RESET}"

