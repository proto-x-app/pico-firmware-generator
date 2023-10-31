# Powershell script for Proto-X-App Pico Firmware Generator

# Variables
$ImageName = "pico-firmware-generator"
$ContainerName = "pico-container"
$OutputDir = "$HOME/Code/proto-x-app/pico-firmware-generator/output"
$DockerFile = "$HOME/Code/proto-x-app/pico-firmware-generator/Dockerfile"

# Log function to output JSON formatted logs
Function Log-Output($message, $status) {
    $log = @{
        message = $message
        status  = $status
    } | ConvertTo-Json
    Write-Host $log
}

# Build the Docker image
Function Build-Image {
    Log-Output "Building Docker image... $DockerFile" "STARTED"
    docker build -t $ImageName -f $DockerFile .
    Log-Output "Docker image built successfully." "COMPLETED"
}

# Run the Docker container
Function Run-Container {
    if (-Not (Test-Path $OutputDir)) {
        New-Item -ItemType Directory -Path $OutputDir
    }
    Log-Output "Running Docker container..." "STARTED"
    docker run -it --rm --name $ContainerName -v ${OutputDir}:/output $ImageName
    Log-Output "Docker container ran successfully." "COMPLETED"
}

# Remove Docker images and containers
Function Clean-Up {
    Log-Output "Cleaning up Docker images and containers..." "STARTED"
    docker rmi -f $ImageName
    docker rm -f $ContainerName
    Log-Output "Clean up completed." "COMPLETED"
}

# Main Menu
Do {
    Clear-Host
    Write-Host "1: Build Docker Image"
    Write-Host "2: Run Docker Container"
    Write-Host "3: Build and Run"
    Write-Host "4: Clean Up"
    Write-Host "5: Exit"
    $input = Read-Host "Choose an option"

    Switch ($input) {
        '1' { Build-Image }
        '2' { Run-Container }
        '3' { Build-Image; Run-Container }
        '4' { Clean-Up }
        '5' { Return }
    }
}
While ($true)
