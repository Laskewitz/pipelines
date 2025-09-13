# Create variables
$projectName = "BalticSummit25"
$devEnvName = "$projectName-Dev"
$testEnvName = "$projectName-QA"
$prodEnvName = "$projectName-Prod"

# Setup environments
pac admin create --name $devEnvName --type Production
pac admin create --name $testEnvName --type Production
pac admin create --name $prodEnvName --type Production