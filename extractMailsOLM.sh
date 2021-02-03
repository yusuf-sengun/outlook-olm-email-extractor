#! /bin/bash
# This sicrip must be located in a folder with olm file(s)

unzip *.olm


outputFile=allmails.txt

OIFS="$IFS"
IFS=$'\n'
for file in `find . -type f -name "m*"`  
do
      while read key; do

    IFS=' ' read -r -a emailArray <<< $key

        for email in "${emailArray[@]}"    
        do     
            if [[ $email == *"@"* && $email != "@"*  && $email != *".prod."* && $email != *".PROD."* && $email != *"-prod-"* && $email == *"."* && $email != "xml"*  ]]; then 

             
                if [[ $email == *"OPFContactEmailAddressAddress"* ]]; then 
                    email=${email#*=} 
                    email=${email#'"'}
		    email=${email%'"'}
		    email=${email#"'"}
		    email=${email%"'"}
		    email=${email#'('}
	            email=${email%')'}
	            
                    echo $email
                    echo $email >> $outputFile
                    break;
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
                        echo $email  >> $outputFile

                fi
                
            fi
        done
	done < $file
done
IFS="$OIFS"


sort $outputFile | uniq  > Mails.txt
sed 's/ \+/,/g' Mails.txt > Mails.csv
rm -r  $outputFile

