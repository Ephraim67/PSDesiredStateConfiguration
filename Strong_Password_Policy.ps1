Configuration EnforceStrongPassword
{
   param (
      [Parameter(Mandatory=$true)]
      [String]$LocalAdminPassword
   )

   Import-DscResource -ModuleName 'PSDesiredStateConfiguration'
   Import-DscResource -ModuleName 'SecurityPolicy'
   Import-DscResource -ModuleName 'AuditPolicyDsc'

   Node Localhost
   {
      #Import-DscResource -ModuleName 'AccountPolicy'
      AccountPolicy AccountPolicies{
         MinimumPasswordLenght = 8
         MaximumPasswordLenght = 18
         PasswordComplexity = $true
         ReversibleEncryption = $false
         LockoutBadCount = 3
         LockoutDuration = (New-TimeSpan -Minutes 15)
         LockoutObservationWindow = (New-TimeSpan -Minutes 15)
      }

      #Import-DscResource -ModuleName LocalAccount
      LocalAccount SetLocalAdminPassword{
         UserName = 'Administrator'
         Password = $LocalAdminPassword | ConvertTo-SecureString -AsPlainText -Force
      }

    }

}


$LocalAdminPassword = "Vix75@65665052"
SecureWindowServer -LocalAdminPassword $LocalAdminPassword -OutputPath "C:\SecureWindowsServer"
Start-DscConfiguration -Path "C:\SecureWindowsServer" -Wait -Force -Verbose

         