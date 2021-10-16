# References
## https://github.com/Hackplayers/PsCabesha-tools/blob/master/Privesc/Acl-FullControl.ps1
## https://serverfault.com/questions/834046/remove-a-user-from-acl-completely-using-powershell

function Acl-RevokeFullControl {param ($user,$path)
$help = @"
.SYNOPSIS
    Acl-Acl-RevokeFullControl
.DESCRIPTION
.EXAMPLE
    Acl-RevokeFullControl -user domain\user -path c:\users\administrator
    Description
    -----------
    Remove a user from having a full control access over a directory
"@

if ($user -eq $null -or $path -eq $null) {$help} else {

$acl = Get-Acl $path
$acesToRemove = $acl.Access | ?{ $_.IsInherited -eq $false -and $_.IdentityReference -eq $user }

"[+] Current permissions:"
$acl | fl

"[+] User permissions to remove on $path"
$acesToRemove

$acl.RemoveAccessRuleAll($acesToRemove)
Set-Acl -AclObject $acl -path $path
"[+] Acls changed successfully."
Get-Acl -path $path | fl
}
}