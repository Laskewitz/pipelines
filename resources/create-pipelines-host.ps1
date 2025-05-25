$envName = "Pipelines-Host-Automated"
$env = pac admin create --name $envName --type Production --json | ConvertFrom-Json

# Output the environment details
"Environment ID: " + $env.EnvironmentId
"Environment Display Name: " + $env.DisplayName

# Select newly created environment
pac env select --environment $env.EnvironmentId

# Install the Pipelines Host solution
pac application install --application-name "msdyn_AppDeploymentAnchor"

## Do other setup here, such as assigning security roles, configuring settings, etc.
