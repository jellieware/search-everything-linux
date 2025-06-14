#!/bin/bash
#Author: Alex Terranova 2024
#TITLE: Search All Android Termux
response=''
RED='\e[38;5;111m'
YEG='\e[38;5;190m'
REG='\033[0;0m'
DP='\e[38;5;162m'
pictures=0
normal=0
videos=0
documents=0
music=0
executables=0
archives=0
#while ! [[ $response = "q" ]]
#do
pictures=0
normal=1
videos=0
documents=0
executables=0
music=0
archives=0
DB=()
DBint=()
DBext=()
holdata=''
mykeyword=''
result=''
#echo -e "\n${YEG}Find What?${REG}"
#read -p '> ' response
#echo ''
#printf "\033c"
printf "\033c"
function searcheverything() {
START_TIME=$SECONDS


#oifs="$IFS"  ## save original IFS
#IFS=$'\n'    ## set IFS to break on newline


function start_spinner {
    set +m
    echo -n "$1"
    { while : ; do for X in 'Updating     ' 'Updating.    ' 'Updating..   ' 'Updating...  ' 'Updating.... ' 'Updating.....'; do echo -en "\r$X" ; sleep 0.1 ; done ; done & } 2>/dev/null



spinner_pid=$!
}

function stop_spinner {
    { kill -9 $spinner_pid && wait; } 2>/dev/null
    set -m
    echo -en "\033[2K\r"
}

spinner_pid=
start_spinner ""


sdcardpath="/"
internalpath="/"

if [ $normal = 1 ]; then

function iterate() {
  local dir="$1"

  for file in "$dir"/*; do
    if [ -f "$file" ]; then
      echo "$file"
    fi

    if [ -d "$file" ]; then
      iterate "$file"
    fi
  done
}


while IFS=  read -r -d $'\0'; do
    DBint+=("$REPLY")
done < <(find "$sdcardpath" -type f -print0 2> /dev/null)


#DBint=($(iterate "$sdcardpath"))
#DBext=($(iterate "$internalpath"))

DBint+=("${DBext[@]}")
#IFS="$oifs"  

#DB=( "${DB[@]// /_}" )
#DB=( "${DB[@]// /_}" )
#DB=( "${DB[@]//-/_}" )
#DB=("${DB[@]//[\[\]]/}")
#DB=("${DB[@]//[\(\)]/}")
#DB=("${DB[@]/./}")

#echo "$new_string" # Output: filetxt

fi

#
#if [[ "${URL}" =~ [^A-Za-z0-9] ]]; then
stop_spinner

echo -e "\t${YEG}Updated! ${REG}> ${REG}$response${REG}\n\n"
#echo -e "${InternalOut[@]}\n\n" 
#echo -e "${ExternalOut[@]}\n\n"
ELAPSED_TIME=$(($SECONDS - $START_TIME))
echo -e "Time taken: ${ELAPSED_TIME} Seconds"
#printf '%.s─' $(seq 1 $(tput cols)) 
}
searcheverything
#while [ "$holddata" != "q" ]; do

while [[ "$holddata" != "." ]]; do
  read -n 1 -s -r -p "Enter another character ('.' to Quit | ',' to Update): " holddata
printf "\033c"  
   if [[ "$holddata" != $'\x7f' && "$holddata" != $'\x08' && "$holddata" =~ [[:alnum:]] ]]; then
  result+="$holddata"
  fi
  if [[ "$holddata" == $'\x7f' || "$holddata" == $'\x08' ]]; then
  if [ "${#result}" -gt 0 ]; then
  result="${result::-1}"
  fi
  fi
#read -p ' > ' holddata
#printf "\033c"
if [[ "$holddata" == "." ]]; then
exit 0
fi
if [[ "$holddata" == "," ]]; then
#result="${result::-1}"
searcheverything
fi

function getresults {
printf "%s\n" "${DBint[@]}" | grep --color='auto' -i "$result"
echo ' '

echo "You entered: $result"
echo ''
}

if [[ "$holddata" != "." && "$holddata" != "," && "${#result}" -gt 2 ]]; then
getresults
fi
if [[ "${#result}" -lt 3 ]]; then
echo ' '

echo "You entered: $result"
echo ''
fi
#printf "\033c"
done
#done
