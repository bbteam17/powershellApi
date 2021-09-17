

Start-PodeServer {

    Add-PodeEndpoint -Address * -Port 8080 -Protocol Http
    Add-PodeRoute -Method Get -Path '/' -ScriptBlock {             
        Write-PodeTextResponse -Value 'Hello from OCAMPA PSAPI in Docker'
    };
    
    Add-PodeRoute -Method Get -Path '/phones2/' -ScriptBlock {
      $User = $WebEvent.Query['userId'];
       Write-PodeJsonResponse -Value $User | ConvertTo-Json -Compress
    }

    Add-PodeRoute -Method Get -Path '/phones/' -ScriptBlock {
      $User = $WebEvent.Query['userId'];
      try{
Import-Module MicrosoftTeams;
Import-Module PSWSMan;
$user = 'comrauser@ocampa.de';
$password = 'KJY0WUM16H4TYtW5glHH';
$secureStringPwd = $password | ConvertTo-SecureString -AsPlainText -Force ;
$credential = New-Object System.Management.Automation.PSCredential -ArgumentList $user, $secureStringPwd;
 
Connect-MicrosoftTeams -Credential $credential | Out-Null ;
 Write-Host 'connect oldu'
$psList = Get-CsOnlineUser  
# | Where-Object { $_.OnPremLineURI -ne '' -or $_.LineUri -ne '' }  | Select-Object  OnPremLineURI   , LineUri  | Sort-Object OnPremLineURI
Write-Host 'Get-CsOnlineUser finish'
Write-Host $psList
$list = New-Object System.Collections.Generic.List[string]  
      ForEach($ps in $psList){
        if($null -ne $ps ){
         $x =$ps.OnPremLineURI.Replace('tel:', '')
          if($list.Contains( $x) -ne $true -and $x -ne ''){
           $list.Add($x)
          }

         $x =$ps.LineUri.Replace('tel:', '')
          if($list.Contains( $x) -ne $true  -and $x -ne ''){
           $list.Add($x)
          }
        }
      
      }
      Write-Host $list
      $jlist= $list | ConvertTo-Json -Compress
    # $list|ConvertTo-Json -Compress
    Write-PodeJsonResponse -Value  $jlist
      }catch {
           Write-Host $_
           
           Write-PodeJsonResponse -Value @{ Error="errorrrrr" }

      }
      
       # Write-PodeTextResponse -Value "[$(Get-Date)] echo: $($e.Parameters['stuff'])"
    }
}