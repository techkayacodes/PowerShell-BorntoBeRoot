$From = ""
$To = ""
$MailServer = ""

$Subject = ""
$Body = ""

Send-MailMessage -SmtpServer $MailServer -From $From -To $To -Subject $Subject -Body $Body
# Be sure that your mail server acceppt mails from the host