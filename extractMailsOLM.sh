#! /bin/bash
# This sicript must be located in a folder with olm file(s)

unzip *.olm

extractMails() {
    while read key; do

        IFS=' ' read -r -a emailArray <<<$key

        for email in "${emailArray[@]}"; do
            if [[ $email == *"@"* && $email != "@"* && $email != *"telenity"* && $email != *".prod."* && $email != *".PROD."* && $email != *"-prod-"* && $email == *"."* && $email != "xml"* ]]; then

                if [[ $email == *"OPFContactEmailAddressAddress"* ]]; then
                    email=${email#*=}
                    email=${email#'"'}
                    email=${email%'"'}
                    email=${email#"'"}
                    email=${email%"'"}
                    email=${email#'('}
                    email=${email%')'}

                    echo $email
                    echo $email >>$outputFile
                    break
                fi
                if [[ $email == *"OPFMessageCopyExchangeConversationId" ]]; then
                    email=${email%<*}
                    email=${email%<*}
                    email=${email#*>}
                    email=${email#"'"}
                    email=${email%"'"}
                    email=${email#'('}
                    email=${email%')'}
                    echo $email
                    echo $email >>$outputFile

                fi

            fi
        done
    done <$1
}

outputFile=allmails.txt

if [[ ! -z $1 ]] && [[ ! -z $2 ]]; then
    lowerDate=$(echo $1 | sed 's/-//g')
    upperDate=$(echo $2 | sed 's/-//g')
    echo Email address will be extract between $1 and $2
    OIFS="$IFS"
    IFS=$'\n'
    for file in $(find . -type f -name "m*"); do
        while read key; do
            IFS=' ' read -r -a emailArray <<<$key

            for firstWord in "${emailArray[@]}"; do
                if [[ $firstWord == *"</ExchangeServerLastModifiedTime>"* ]]; then
                    mailDate=${firstWord#*>}
                    mailDate=$(echo $mailDate | cut -c 1-10)
                    mailDate=$(echo $mailDate | sed 's/-//g')

                    if [[ $mailDate -ge $lowerDate && $mailDate -le $upperDate ]]; then
                        extractMails $file
                        
                    fi
                fi
            done
        done <$file
    done
    IFS="$OIFS"
else
    OIFS="$IFS"
    IFS=$'\n'
    for file in $(find . -type f -name "m*"); do
        extractMails $file
    done
    IFS="$OIFS"
fi

sort $outputFile | uniq >Mails.txt
sed 's/ \+/,/g' Mails.txt >Mails.csv
rm -r $outputFile

