

# TODO: Ask for admin permission to do this type of work
# run this command Start-Process powershell -Verb runAs 
# In CMD and Powershell to start as admin
Function BlockSiteHosts ([Parameter(Mandatory=$true)]$Url){
    $hosts  = 'C:\Windows\System32\drivers\etc\hosts'
    $is_blocked = Get-Content -Path $hosts |
    Select-String -Pattern ([regex]::Escape($Url))
    If(-not $is_blocked){
        $hoststr="127.0.0.1 " + $Url
        Add-Content -Path $hosts -Value $hoststr
    }
    Write-Output "[+] Blocked $Url";
}


# Something is really out of sync in this code but I don't know why, it is 
# Not usually like this, how can I print something in powershell 
Function UnblockSitesHosts ([Parameter(Mandatory=$true)]$Url){
    $hosts = 'C:\Windows\System32\drivers\etc\hosts'
    $is_blocked = Get-Content -Path $hosts |
    Select-String -Pattern ([regex]::Escape($Url))
    If($is_blocked){
        $newhosts = Get-Content -Path $hosts |
        Where-Object {
            $_ -notmatch ([regex]::Escape($Url))
        }
        Set-Content -Path $hosts -Value $newhosts
    }
}

UnblockSitesHosts("facebook.com")
UnblockSitesHosts("www.facebook.com")