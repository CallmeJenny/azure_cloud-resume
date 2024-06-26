using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $CosmosIn, $TriggerMetadata)

# Write to the Azure Functions log stream.
Write-Host "PowerShell HTTP trigger function processed a request."

if (-not $CosmosIn) { 
    $body = 'VisitorCounter item not found'
    Write-Host $body

    Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{ 
        StatusCode = [HttpStatusCode]::NotFound 
        Body = $body
    })
} else {
    $visitorCount = $CosmosIn.visitorCount
    Write-Host "Found VisitorCounter item, current visitorCount: $visitorCount"

    $visitorCount++
    Write-Host "New visitorCount: $visitorCount"

    # Nur den Zählerwert extrahieren und als einfachen Wert setzen
    $responseJson = $visitorCount

    Push-OutputBinding -Name cosmosOut -Value @{
        id = $CosmosIn.id
        visitorCount = $visitorCount
    }

    Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{ 
        StatusCode = [HttpStatusCode]::OK 
        Body = $responseJson
    })
}