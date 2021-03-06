﻿$header1 = "RequestURL"
$header2 = "mimeType"
$header3 = "Method"
$header4 = "StartTime"
$header5 = "TotalTime"
$header6 = "StatusCode"
$header7 = "blocked"
$header8 = "wait"
$header9 = "send"
$header10 = "receive"

$csvHeaders = @"
$header1;$header2;header3;header4;header5;header6;header7;header8;header9;header10
"@

$csvHeaders | Out-File -FilePath "<output-filepathincsv>"


$file = Get-Content -path "<input-filepath.har>" -Raw | ConvertFrom-Json
$entriescount = $file.log.entries.count

for($i=0; $i -lt $entriescount; $i++)
{
$RequestURL = $file.log.entries[$i].request.url
$mimeType = $file.log.entries[$i].respone.content.mimeType
$Method = $file.log.entries[$i].request.method
$StartTime = $file.log.entries[$i].startedDateTime
$TotalTime = $file.log.entries[$i].time
$StatusCode = $file.log.entries[$i].response.status
$blocked = $file.log.entries[$i].timings.blocked
$wait = $file.log.entries[$i].timings.wait
$send = $file.log.entries[$i].timings.send
$receive = $file.log.entries[$i].timings.receive

 
$newRow = New-Object PSObject -Property @{
                    $header1 = $RequestURL;
                    $header2 = $mimeType;
                    $header3 = $Method;
                    $header4 = $StartTime;
                    $header5 = $TotalTime;
                    $header6 = $StatusCode;
                    $header7 = $blocked;
                    $header8 = $wait;
                    $header9 = $send;
                    $header10 = $receive
                }
                $reorderedRow = $newRow | Select-Object -Property $header1,$header2,$header3,$header4,$header5,$header6,$header7,$header8,$header9,$header10

                $reorderedRow | Export-Csv -Path "<outputfileincsv>" -Append -Delimiter ";"

}
