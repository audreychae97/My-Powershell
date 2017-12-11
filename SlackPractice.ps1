SendEmail
#pickMessage
HelloSlack "hello bob" 

#########################################################
# sending email
#########################################################
function SendEmail{
$smtpServer = "domain. example: mail.gmail.com"
$attachment = new-object Net.Mail.Attachment("C:\Users\YChae1\Desktop\bigHi.xlsx")

$msg = new-object Net.Mail.MailMessage

$smtp = new-object Net.Mail.SmtpClient($smtpServer)

$msg.From = "FROMADDRESS@yourdomain.com"
$msg.To.Add("TOADDRESS@yourdomain.com");
$msg.Subject = "Testing from Powershell" 
$msg.Body = "Attached is a secret secret file"
$msg.Attachments.Add($attachment)

$smtp.Send($msg)
$attachment.Dispose()
}

#########################################################
# Posting to Slack - interactive and cool! :) 
#########################################################

function HelloSlack($Type){
    $payload = @{
    "token" = "PU2WkysIPVBdWVVO5lUm4S6oxx";
	"channel" = "ps-practice";
    "text" = $($Type);
    }
    Invoke-WebRequest -Uri "https://hooks.slack.com/services/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xx" -Method "POST" -Body (ConvertTo-Json -Compress -InputObject $payload)
}


function PickMessage(){
    $alert = ":bomb: [ALERTING] SOMETHING TERRIBLE IS HAPPENING LOLZ"
    $warning = " :warning: [WARNING] On the verge of mental break down"
    $ok = ":slightly_smiling_face: [OK] The storm has passed "
    $fixed = ":hammer_and_wrench: [FIXED] Error was fixed. Time to go home"

    Write-HOST "Here are the following life crisis problems:"
    Write-HOST "1 - Lack of Sleep "
    Write-HOST "2 - No Money"
    Write-HOST "3 - Too much Work"
    Write-HOST "4 - Failing everything"
    Write-HOST "5 - Health issues"


    $issue = Read-Host -Prompt 'Total your problems and enter the amount:'
    $degree = Read-Host -Prompt 'Enter the percentage of panic mode'

    #pretty bad
    if($issue -match 0 -and $degree -match 0){
        HelloSlack $ok
    }
    
    elseif($issue -gt 5 -and $degree -gt 70){
        HelloSlack $alert
    }
    else{
        HelloSlack $warning
    }

  }
   