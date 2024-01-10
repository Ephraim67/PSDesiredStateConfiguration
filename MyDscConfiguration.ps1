Configuration MyDscConfiguration
{
   param
   (
      [string[]]$ComputerName='localhost'
   )

   Import-DscResource -ModuleName PSDesiredStateConfiguration

   Node $ComputerName
   {
      WindowsFeature MyFeatureInstance
      
      {
         Ensure = 'Present'
         Name = 'RSAT'
      }

      WindowsFeature My2ndFeatureInstance
      {
         Ensure = 'Present'
         Name = 'Bitlocker'
      }

   }

}

MyDscConfiguration