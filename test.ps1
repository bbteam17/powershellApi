

Import-Module MicrosoftTeams;
Import-Module PSWSMan;
$user = 'comrauser@ocampa.de';
$password = 'KJY0WUM16H4TYtW5glHH';
$secureStringPwd = $password | ConvertTo-SecureString -AsPlainText -Force ;
$credential = New-Object System.Management.Automation.PSCredential -ArgumentList $user, $secureStringPwd;
 
Connect-MicrosoftTeams -Credential $credential | Out-Null ;
 Write-Host 'connect oldu'

$list=Get-CsOnlineVoicemailPolicy | Select-Object Identity

$x= $list|ConvertTo-Json -Compress

write-Host "$x || $x"
