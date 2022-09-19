#!/bin/bash

IFS=$'\n'

function Help () {
	cat << EOF
***********************   USAGE   ***********************
                      DESCRIPTION:
        Script to convert log files to CSV format

                        SYNOPSIS:

    Default convert:
      -a [path to log file] - Convert all log lines to CSV format
        Example:
        ./convert.sh -a nginx.log
                    or
        ./convert.sh -p /SomeFolder/MyLogs.log

    Filters:
      Required arguments for filers:
        -p [path to log file] - Path to your log file
          Example commands:
          ./convert.sh -p nginx.log
                  or
          ./convert.sh -p /SomeFolder/MyLogs.log

      Optional arguments:
        -i [IP-ADDRESS] - Filter by IP-Address
          Example command:
          ./convert.sh -p nginx.log -i 162.55.33.98

        -d [DATE] - Filter by date
          Example command:
          ./convert.sh -p nginx.log -d 26/Apr/2021

        -c [STATUS CODE] - Filter by HTTP status code
          Example command:
          ./convert.sh -p nginx.log -c 200


*********************************************************
EOF

exit 1
}
# CLEAN CSV COLLUMNS
REMOVE_COLUMNS="2,3,5,16"

# GLOBAL SETTINGS (ELEMENTS ID`s)
IP_ELEMENT=0
DATE_ELEMENT=1
STATUS_CODE_ELEMENT=5

# GLOBAL VARIABLES
IP_ARG=""
DATE_ARG=""
SCODE_ARG=""

FILE_PATH=""

# HEADER FOR CSV TABLE
HEADER="IP-Arddress, Date/Time, REQUEST, STATUS CODE, \
        - , - , BROWSER INFO, - , REQUEST TIME, NAME, \
        IP:PORT, - , REQUEST TIME, STATUS CODE, HASH"

function Header() {
    echo $HEADER >> output.csv
}

# CLEAN LOG FILE AND CONVERT TO ARRAY
function ClearString() {
  clearLine=( $(echo ${linesArray[i]} | tr -d '[]' \
                                      | sed -e 's/\s/,/g ; s/,,/,/g ; s/\(.*\),/\1 /' \
                                      | cut -d, -f$REMOVE_COLUMNS --complement) )
    IFS=$',' read -r -a arrayLine <<< $clearLine
}

# CONVERT ALL LOG to csv
function AllLogs() {
  fileLenth=${#linesArray[@]}
  for (( i=0;i<$fileLenth;i++ ));
  do
    ClearString
    echo $clearLine >> output.csv
  done
  echo "TOTAL LINES: $i"

}

# FILTER BY IP ADDRESS
function IPFilter () {
  fileLenth=${#linesArray[@]}
  for (( i=0;i<$fileLenth;i++ ));
  do
    ClearString
    if  [[  "$IP_ARG" == "${arrayLine[$IP_ELEMENT]}"  ]]; then
      echo $clearLine >> output.csv
    fi
  done
  echo "TOTAL LINES: $i"
}

# FILTER BY IP DATE
function DateFilter () {
  fileLenth=${#linesArray[@]}
  for (( i=0;i<$fileLenth;i++ ));
  do
    ClearString
    if grep -q $DATE_ARG <<< ${arrayLine[$DATE_ELEMENT]}; then
      echo $clearLine >> output.csv
    fi
  done
  echo "TOTAL LINES: $i"
}

# FILTER BY HTTP STATUS CODE
function StatusCodeFilter () {
  fileLenth=${#linesArray[@]}
  for (( i=0;i<$fileLenth;i++ ));
  do
    ClearString
    if  [[  "$SCODE_ARG" == "${arrayLine[$STATUS_CODE_ELEMENT]}"  ]]; then
      echo $clearLine >> output.csv
    fi
  done
  echo "TOTAL LINES: $i"
}



while getopts "p:a:i:d:c:h:" opt; do
  case $opt in
  p)
    FILE_PATH=${OPTARG}
    echo "LOG FILE: $FILE_PATH"
    readarray linesArray <  "${FILE_PATH}"
    ;;
  a)
    FILE_PATH=${OPTARG}
    echo "LOG FILE: $FILE_PATH"
    echo "CONVERT ALL LOG"
    readarray linesArray <  "${FILE_PATH}"
    Header
    AllLogs
    ;;
  i)
    IP_ARG=${OPTARG}
    Header
    IPFilter
    echo "FILTER BY IP: $IP_ARG"
    ;;
  d)
    DATE_ARG=${OPTARG}
    Header
    DateFilter
    echo "FILTER BY DATE: $DATE_ARG"
    ;;
  c)
    SCODE_ARG=${OPTARG}
    Header
    StatusCodeFilter
    echo "FILTER BY STATUS CODE: $SCODE_ARG"
    ;;
  h)
    Help
    ;;
  *)
    Help
    ;;
  esac
done