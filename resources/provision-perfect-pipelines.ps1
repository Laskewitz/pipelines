# Define variables
$projectName = "BalticSummit25"
$devEnvName = "$projectName-Dev"
$testEnvName = "$projectName-QA"
$prodEnvName = "$projectName-Prod"

# Define the template file and output file
$templateFile = "./resources/pfx-provisionpipeline-template.txt"
$outputFile = "./resources/pfx-provisionpipeline-updated.txt"

# Using regular expression to extract Environment ID for development environment
$devEnvId = (pac org list --filter $devEnvName  | Select-String -Pattern "\s+([0-9a-fA-F-]+)\s+https").Matches.Groups[1].Value
Write-Host "Environment ID for dev: $devEnvId"

# Using regular expression to extract Environment ID for test environment
$testEnvId = (pac org list --filter $testEnvName  | Select-String -Pattern "\s+([0-9a-fA-F-]+)\s+https").Matches.Groups[1].Value
Write-Host "Environment ID for test: $testEnvId"

# Using regular expression to extract Environment ID for production environment
$prodEnvId = (pac org list --filter $prodEnvName  | Select-String -Pattern "\s+([0-9a-fA-F-]+)\s+https").Matches.Groups[1].Value
Write-Host "Environment ID for prod: $prodEnvId"

# Read the content of the template file
$powerFxExpression = Get-Content -Path $templateFile -Raw

# Replace the placeholders with actual values
$powerFxExpression = $powerFxExpression -replace "@projectName", $projectName
$powerFxExpression = $powerFxExpression -replace "@devEnvName", $devEnvName
$powerFxExpression = $powerFxExpression -replace "@testEnvName", $testEnvName
$powerFxExpression = $powerFxExpression -replace "@prodEnvName", $prodEnvName
$powerFxExpression = $powerFxExpression -replace "@devEnvId", $devEnvId
$powerFxExpression = $powerFxExpression -replace "@testEnvId", $testEnvId
$powerFxExpression = $powerFxExpression -replace "@prodEnvId", $prodEnvId

# Write the updated Power Fx expression to a new file
$powerFxExpression | Out-File -FilePath $outputFile -Force

# Run the pac CLI command with the new file
pac power-fx run --file $outputFile --echo