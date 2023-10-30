# Powershell script for Proto-X-App Pico Firmware Generator

# Variables
$ImageName = "pico-firmware-generator"
$ContainerName = "pico-container"
$OutputDir = "$HOME/Code/proto-x-app/pico-firmware-generator/output"

# Build the Docker image
Function Build-Image {
    docker build -t $ImageName .
}

# Run the Docker container
Function Run-Container {
    if (-Not (Test-Path $OutputDir)) {
        New-Item -ItemType Directory -Path $OutputDir
    }
    docker run -it --rm --name $ContainerName -v ${OutputDir}:/output $ImageName
}


# Remove Docker images and containers
Function Clean-Up {
    docker rmi -f $ImageName
    docker rm -f $ContainerName
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
