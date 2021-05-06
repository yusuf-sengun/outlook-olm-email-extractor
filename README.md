<h1>OLM Email Extractor</h1>

You can use this bash script to export e-mails addresses from your company Outlook e-mail account and import it to Linkedin. Also you can use CSV file which is produced by script end of process
<br/>
<b> There are two mode that you can run the script
<br/>
  <h1>1. Export all mail adress from your .olm file</h1>
Export your all e-mails using Export menu in Outlook.<br/>
Locate .olm file and script in same folder.<br/>
Go to terminal at specific folder and write following commands;<br/>
<br/>
->chmod 755 extractMailsOLM.sh<br/>
->./extractMailsOLM.sh<br/>
<br/>
Wait untill process done. End of process you will get txt and CSV file.<br/>
  
<h1>2. Export specific times mail adress from your .olm file</h1>
Export your all e-mails using Export menu in Outlook.<br/>
Locate .olm file and script in same folder.<br/>
Please read the note.<br/>
Go to terminal at specific folder and write following commands with time argument;<br/>
<br/>
->chmod 755 extractMailsOLM.sh<br/>
->./extractMailsOLM.sh 2021-01-25 2021-04-28<br/>
<br/>
Wait untill process done. End of process you will get txt and CSV file.<br/>
<br/>
<h3>Note: </h3>While declaring a time period be sure that you apply following rules;
<br/>-> You specified 2 time.
<br/>-> The first time is before than the second time.
<br/>-> You specified time periods as "yyyy-mm-dd" format.
