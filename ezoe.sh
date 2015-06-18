#!/bin/bash

curl="$(curl -fsSL http://ask.fm/EzoeRyou | bash -c "$(curl -fsSL https://raw.githubusercontent.com/ShellShoccar-jpn/Parsrs/master/parsrx.sh)" )"

answer=($(
    echo "$curl" |
    grep -A2 "/html/head/body/div/div/div/div/div/div/div/@class answer" |
    grep -v "@" |
    awk '{print $3}' |
    sed -e "s/\\\n//g" |
    grep -v '^\s*$'
))

question=($(
    echo "$curl" |
    grep -A15 "/html/head/body/div/div/div/div/div/div/div/@class question" |
    grep -v "@" |
    grep "/html/head/body/div/div/div/div/div/div/div/span/span " |
    awk '{print $2}' |
    sed -e "s/\\\n//g"
))

id=($(
    echo "$curl" |
    grep "question_box_" |
    sed -e "s/question_box_//g" |
    awk '{print $2}'
))

for ((i=0; i<"${#question[@]}"; i++)); do
    echo -e "http://ask.fm/EzoeRyou/answer"/"${id[i]}"
    echo -e "  \033[31m${question[i]}\033[m"
    echo -e "  ${answer[i]}"
    echo
done
