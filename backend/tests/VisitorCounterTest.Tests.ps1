BeforeAll {
    . $PSScriptRoot\..\api\VisitorCounter\run.ps1
}

Describe "Integration test for run.ps1" {
    Context "When CosmosIn is provided" {
        It "Should increase visitorCount by 1" {
            # Arrange
            $initialVisitorCount = 5
            $CosmosIn = @{
                id = "1"
                visitorCount = $initialVisitorCount
            }
            $Request = $null
            $TriggerMetadata = $null

            # Act
            $response = Invoke-AzFunction -Name "VisitorCounter" -InputObject @{
                Request = $Request
                CosmosIn = $CosmosIn
                TriggerMetadata = $TriggerMetadata
            }

            # Assert
            $expectedVisitorCount = $initialVisitorCount + 1
            $response.Body | ConvertFrom-Json | Select-Object -ExpandProperty visitorCount | Should -BeExactly $expectedVisitorCount
        }
    }

    Context "When CosmosIn is not provided" {
        It "Should return a 404 Not Found response" {
            # Arrange
            $CosmosIn = $null
            $Request = $null
            $TriggerMetadata = $null

            # Act
            $response = Invoke-AzFunction -Name "VisitorCounter" -InputObject @{
                Request = $Request
                CosmosIn = $CosmosIn
                TriggerMetadata = $TriggerMetadata
            }

            # Assert
            $response.StatusCode | Should -BeExactly [System.Net.HttpStatusCode]::NotFound
        }
    }
}