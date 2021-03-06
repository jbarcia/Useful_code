#Check for local groups on server
net localgroup administrators

function get_result(){
    $strUser = $($user)
    $strPass = $($passwd)
    $PWord = ConvertTo-SecureString –String $strPass –AsPlainText -Force
    $objCred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList ($strUser, $PWord)
    Get-WmiObject -ComputerName $($ip) -Credential $objCred Win32_Process
}

$ips = @{};
$ips['2012'] = Read-Host "Please enter IP 2012";
$ips['2008'] = Read-Host "Please enter IP 2008";
$passwd = 'Pass'
 
function credential([String]$user, [String]$password) {
$pass = ConvertTo-SecureString –String $password –AsPlainText -Force
New-Object –TypeName System.Management.Automation.PSCredential –ArgumentList $user, $pass
}
 
function login_to($name) {
$server, $user = $name.Split(' ')
$ip = $ips[$server];
Write-Host "Logging to $($ip)";
Enter-PSSession -ComputerName $ip -Credential $(credential $user $passwd)
}

function convert_sid-to_username($sid){
$objSID = New-Object System.Security.Principal.SecurityIdentifier `
($($sid))
$objUser = $objSID.Translate( [System.Security.Principal.NTAccount])
$objUser.Value }