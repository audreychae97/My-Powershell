#Today's date####################
$a = Get-Date
$date = $a.Date
$day = $a.Day
$month = $a.Month
$hour = $a.Hour
$minute = $a.Minute

###########################
function HelloSlack($subject, $time){
    $payload = @{
    "token" = "PU2WkysIPVBdWVVO5lUm4S6o";
	"channel" = "audpodgexx";
    "text" = ":rocket: *REMINDER BOT* :rocket: `n You have an event coming up on $($time) `n For: $($subject)";

   
    }
    Invoke-WebRequest -Uri "https://hooks.slack.com/services/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xx" -Method "POST" -Body (ConvertTo-Json -Compress -InputObject $payload)
}

#connect to outlook
$Outlook = New-Object -ComObject Outlook.Application
#connect to calendar 
$Calendar = $Outlook.session.GetDefaultFolder(9) 

#Sort through the tasks... if it falls in the range of yesterday - 2 days from today.
#alert slac the name of the event and the start time 
foreach($task in $Calendar.Items){
    if($task.start -gt [datetime]$a.AddDays(-2) -AND $task.start -lt [datetime]$a.AddDays(2)){
        HelloSlack $task.subject $task.start
    }
}


<# this spits out all items
$Calendar.Items | Where-Object {$_.start -gt [datetime]$a.AddDays(-10) -AND $_.start -lt `
[datetime]$a.addDays(2)} | sort-object Duration | ft subject, start 
#>