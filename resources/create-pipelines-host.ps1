$envName = "Pipelines-Host-Automated"
$env = pac admin create --name $envName --type Production --json | ConvertFrom-Json
$adminGroupId = "replace-with-your-admin-group-id";
$userGroupId = "replace-with-your-user-group-id";

# Output the environment details
"Environment ID: " + $env.EnvironmentId
"Environment Display Name: " + $env.DisplayName

# Select newly created environment
pac env select --environment $env.EnvironmentId

# Install the Pipelines Host solution
pac application install --application-name "msdyn_AppDeploymentAnchor"

# Create Entra ID teams and assign security roles
pac admin assign-group --role "Deployment Pipeline Administrator" --group $adminGroupId --group-name "Pipeline Administrators" --team-type "AadSecurityGroup" --membership-type "Members"
pac admin assign-group --role "Deployment Pipeline User" --group $userGroupId --group-name "Pipeline Users" --team-type "AadSecurityGroup" --membership-type "Members"

# Import solution with sample flows
pac solution import --path ./PipelinesExtensibilitySamples_1_0_0_1.zip

## Do other setup here, such as configuring settings, import other solutions, etc.