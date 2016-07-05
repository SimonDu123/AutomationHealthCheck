﻿
.\UploadSampleData.ps1
. .\CheckResult.ps1

$CompareJson = @'
  {
  "TotalScoreIncludingIgnoredChecks": [
    77.443280977312384,
    75.443280977312384
  ],
  "TotalScoreExcludingIgnoredChecks": [
    77.443280977312384,
    75.443280977312384
  ],
  "TopIssues": {
    "_t": "a",
    "4": [
      "memory_physical_memory_pressure"
    ]
  },
  "StaticHealthChecks": {
    "_t": "a",
    "0": {
      "HealthCheckScore": [
        100.0,
        95.0
      ]
    }
  },
  "PhysicalMemoryPressure": {
    "TrendAnalysis": {
      "TrendExists": [
        false,
        true
      ],
      "TrendIsIncreasing": [
        false,
        true
      ]
    }
  }
}
'@
Set-Variable -Name $CompareJson -Option AllScope

function CheckResult
{
if ($CompareJson -eq $null)
{
    return $true
}
}  

Describe -Tags "HealthCheck" "HealthCheck Results" {
 
    It "Checking health results" {
       if ($CompareJson -eq $null)
    {
        Checkresult | Should Be $true
    }
       else
    {
        throw $CompareJson
    }
   }
}

