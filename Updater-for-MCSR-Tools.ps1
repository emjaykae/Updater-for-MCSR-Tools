<#
.SYNOPSIS
    Update JAR files for various tools.
.DESCRIPTION
    This script provides a GUI for updating JAR files from GitHub for tools like Jingle, Julti, Ninjabrain-Bot, and Paceman-AA-Tracker.
.VERSION
    1.0
.AUTHOR
    twitch.tv/EmJayKae
.LICENSE
    MIT License

    Copyright (c) 2024 EmJayKae

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.

.NOTES
    - Ensure you have an active internet connection as the script fetches the latest releases from GitHub.
    - The script saves user settings in an XML file located in the user's profile directory.
#>
Add-Type -AssemblyName System.Windows.Forms

# Define the path to the settings file in the user's profile directory
$settingsFilePath = "$([System.IO.Path]::Combine($env:USERPROFILE, 'plugin_settings.xml'))"

# Function to save settings to a file
function Save-Settings {
    param (
        [hashtable]$settings
    )
    $settings | Export-CliXml -Path $settingsFilePath
}

# Function to load settings from a file
function Load-Settings {
    if (Test-Path -Path $settingsFilePath) {
        return Import-CliXml -Path $settingsFilePath
    } else {
        return @{}
    }
}

# Create the form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Updater for MCSR Tools"
$form.Size = New-Object System.Drawing.Size(535, 575)  # Increased height
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedDialog
$form.MaximizeBox = $false
$form.MinimizeBox = $false

# Handle the FormClosing event to prevent the "Cancel" message
$form.Add_FormClosing({
    $form.DialogResult = [System.Windows.Forms.DialogResult]::None
    [System.Windows.Forms.Application]::Exit()
})

# Load existing settings or use defaults
$settings = Load-Settings

# Text area explaining the program at the top
$labelInfo = New-Object System.Windows.Forms.Label
$labelInfo.Text = "Select the programs you use and specify the paths for JAR files:"
$labelInfo.Location = New-Object System.Drawing.Point(10, 10)
$labelInfo.Size = New-Object System.Drawing.Size(500, 40)
$labelInfo.Font = New-Object System.Drawing.Font("Arial", 10)
$form.Controls.Add($labelInfo)

# Create checkboxes for the programs with adjusted size
$checkJulti = New-Object System.Windows.Forms.CheckBox
$checkJulti.Text = "Julti"
$checkJulti.Location = New-Object System.Drawing.Point(15, 60)
$checkJulti.Size = New-Object System.Drawing.Size(200, 30)
$checkJulti.Checked = $settings["UseJulti"] -eq 'y'
$form.Controls.Add($checkJulti)

$checkJingle = New-Object System.Windows.Forms.CheckBox
$checkJingle.Text = "Jingle"
$checkJingle.Location = New-Object System.Drawing.Point(15, 90)
$checkJingle.Size = New-Object System.Drawing.Size(200, 30)
$checkJingle.Checked = $settings["UseJingle"] -eq 'y'
$form.Controls.Add($checkJingle)

$checkNinjabrain = New-Object System.Windows.Forms.CheckBox
$checkNinjabrain.Text = "Ninjabrain-Bot"
$checkNinjabrain.Location = New-Object System.Drawing.Point(15, 120)
$checkNinjabrain.Size = New-Object System.Drawing.Size(200, 30)
$checkNinjabrain.Checked = $settings["UseNinjabrainBot"] -eq 'y'
$form.Controls.Add($checkNinjabrain)

$checkPaceman = New-Object System.Windows.Forms.CheckBox
$checkPaceman.Text = "Paceman-AA-Tracker"
$checkPaceman.Location = New-Object System.Drawing.Point(15, 150)
$checkPaceman.Size = New-Object System.Drawing.Size(200, 30)
$checkPaceman.Checked = $settings["UsePaceman"] -eq 'y'
$form.Controls.Add($checkPaceman)

# Create labels and textboxes for input paths
$labelJulti = New-Object System.Windows.Forms.Label
$labelJulti.Text = "Julti JAR Path:"
$labelJulti.Location = New-Object System.Drawing.Point(10, 190)
$labelJulti.Size = New-Object System.Drawing.Size(150, 20)
$labelJulti.Visible = $checkJulti.Checked
$form.Controls.Add($labelJulti)

$textJulti = New-Object System.Windows.Forms.TextBox
$textJulti.Location = New-Object System.Drawing.Point(160, 190)
$textJulti.Size = New-Object System.Drawing.Size(350, 20)
$textJulti.Text = $settings["JultiJar"]
$textJulti.Visible = $checkJulti.Checked
$form.Controls.Add($textJulti)

$labelJingle = New-Object System.Windows.Forms.Label
$labelJingle.Text = "Jingle JAR Path:"
$labelJingle.Location = New-Object System.Drawing.Point(10, 220)
$labelJingle.Size = New-Object System.Drawing.Size(150, 20)
$labelJingle.Visible = $checkJingle.Checked
$form.Controls.Add($labelJingle)

$textJingle = New-Object System.Windows.Forms.TextBox
$textJingle.Location = New-Object System.Drawing.Point(160, 220)
$textJingle.Size = New-Object System.Drawing.Size(350, 20)
$textJingle.Text = $settings["JingleJar"]
$textJingle.Visible = $checkJingle.Checked
$form.Controls.Add($textJingle)

$labelNinjabrain = New-Object System.Windows.Forms.Label
$labelNinjabrain.Text = "Ninjabrain-Bot JAR Path:"
$labelNinjabrain.Location = New-Object System.Drawing.Point(10, 250)
$labelNinjabrain.Size = New-Object System.Drawing.Size(150, 20)
$labelNinjabrain.Visible = $checkNinjabrain.Checked
$form.Controls.Add($labelNinjabrain)

$textNinjabrain = New-Object System.Windows.Forms.TextBox
$textNinjabrain.Location = New-Object System.Drawing.Point(160, 250)
$textNinjabrain.Size = New-Object System.Drawing.Size(350, 20)
$textNinjabrain.Text = $settings["NinjabrainBotJar"]
$textNinjabrain.Visible = $checkNinjabrain.Checked
$form.Controls.Add($textNinjabrain)

# Create a button to start the update
$buttonUpdate = New-Object System.Windows.Forms.Button
$buttonUpdate.Text = "Update JAR Files"
$buttonUpdate.Location = New-Object System.Drawing.Point(225, 290)
$buttonUpdate.AutoSize = $true
$form.Controls.Add($buttonUpdate)

# Output textbox
$outputBox = New-Object System.Windows.Forms.TextBox
$outputBox.Location = New-Object System.Drawing.Point(10, 330)
$outputBox.Size = New-Object System.Drawing.Size(510, 170)
$outputBox.Multiline = $true
$outputBox.ReadOnly = $true
$outputBox.ScrollBars = "Vertical"
$form.Controls.Add($outputBox)

# Create a "Done" button to close the form
$buttonDone = New-Object System.Windows.Forms.Button
$buttonDone.Text = "Done"
$buttonDone.Location = New-Object System.Drawing.Point(225, 510)
$buttonDone.AutoSize = $true
$form.Controls.Add($buttonDone)

# Define the GitHub release URLs
$githubUrls = @{
    "Jingle" = "https://api.github.com/repos/DuncanRuns/Jingle/releases/latest"
    "Ninjabrain-Bot" = "https://api.github.com/repos/Ninjabrain1/Ninjabrain-Bot/releases/latest"
    "Paceman-AA-Tracker" = "https://api.github.com/repos/PaceMan-MCSR/PaceMan-AA-Tracker/releases/latest"
    "Julti" = "https://api.github.com/repos/DuncanRuns/Julti/releases/latest"
}

# Function to download the JAR file with exact file name handling
function Download-JarFile {
    param (
        [string]$fileName,
        [string]$localDirectory,
        [string]$githubUrl,
        [string]$pluginType = $null  # Optional parameter for plugin type (e.g., 'jingle' or 'julti' for paceman-aa-tracker)
    )
    
    try {
        $outputBox.AppendText("Starting download process for $fileName...`r`n")
        
        # Retrieve release information from GitHub
        $releaseInfo = Invoke-RestMethod -Uri $githubUrl -Headers @{ "User-Agent" = "Mozilla/5.0" }

        # Adjust the fileName for Paceman-AA-Tracker based on the pluginType
        if ($pluginType) {
            if ($pluginType -eq "jingle") {
                $fileName = "paceman-aa-tracker-jingle-plugin"
            } elseif ($pluginType -eq "julti") {
                $fileName = "paceman-aa-tracker-julti-plugin"
            }
        }

        # Get the correct download URL by exact matching for Paceman-AA-Tracker, or by pattern for others
        if ($pluginType) {
            $downloadAsset = $releaseInfo.assets | Where-Object { $_.name -eq "$fileName-0.3.5.jar" } | Select-Object -First 1
        } else {
            $downloadAsset = $releaseInfo.assets | Where-Object { $_.name -like "$fileName*.jar" } | Select-Object -First 1
        }
        
        if ($null -eq $downloadAsset) {
            throw "Could not find the correct asset for $fileName."
        }

        $downloadUrl = [System.Uri]::new($downloadAsset.browser_download_url)

        # Determine the full file path for the downloaded JAR file using the exact name from GitHub
        $fullFilePath = Join-Path -Path $localDirectory -ChildPath $downloadAsset.name

        # Attempt the download
        Invoke-WebRequest -Uri $downloadUrl -OutFile $fullFilePath -ErrorAction Stop
        $outputBox.AppendText("$fileName downloaded successfully to $fullFilePath.`r`n")

    } catch {
        # Catch and display any errors that occur during the download
        $outputBox.AppendText("Error downloading ${fileName}: $_`r`n")
    }
}

# Function to check for updates and download if available
function Check-And-Update {
    param (
        [string]$fileName,
        [string]$localDirectory,
        [string]$githubUrl,
        [string]$pluginType = $null  # Added pluginType parameter
    )

    $currentJarFile = Get-ChildItem -Path $localDirectory -Filter "$fileName*.jar" -ErrorAction SilentlyContinue | Sort-Object LastWriteTime -Descending | Select-Object -First 1

    if (-not $currentJarFile) {
        $outputBox.AppendText("$fileName not found in $localDirectory. Downloading...`r`n")
        Download-JarFile -fileName $fileName -localDirectory $localDirectory -githubUrl $githubUrl -pluginType $pluginType
    } else {
        $releaseInfo = Invoke-RestMethod -Uri $githubUrl -Headers @{ "User-Agent" = "Mozilla/5.0" }
        $latestVersion = $releaseInfo.tag_name.TrimStart('v')
        $currentVersion = [regex]::Match($currentJarFile.Name, '(?<=-)\d+\.\d+\.\d+').Value

        if ($latestVersion -ne $currentVersion) {
            $outputBox.AppendText("New version available for ${fileName}: $latestVersion. Downloading...`r`n")
            Remove-Item -Path $currentJarFile.FullName
            Download-JarFile -fileName $fileName -localDirectory $localDirectory -githubUrl $githubUrl -pluginType $pluginType
        } else {
            $outputBox.AppendText("$fileName is up to date.`r`n")
        }
    }
}

# Event handlers to show/hide text boxes based on checkbox state
$checkJulti.Add_CheckedChanged({
    $labelJulti.Visible = $checkJulti.Checked
    $textJulti.Visible = $checkJulti.Checked
})

$checkJingle.Add_CheckedChanged({
    $labelJingle.Visible = $checkJingle.Checked
    $textJingle.Visible = $checkJingle.Checked
})

$checkNinjabrain.Add_CheckedChanged({
    $labelNinjabrain.Visible = $checkNinjabrain.Checked
    $textNinjabrain.Visible = $checkNinjabrain.Checked
})

# Event handler for the update button
$buttonUpdate.Add_Click({
    $outputBox.Clear()
    
    $settings["UseJulti"] = if ($checkJulti.Checked) {'y'} else {'n'}
    $settings["UseJingle"] = if ($checkJingle.Checked) {'y'} else {'n'}
    $settings["UseNinjabrainBot"] = if ($checkNinjabrain.Checked) {'y'} else {'n'}
    $settings["UsePaceman"] = if ($checkPaceman.Checked) {'y'} else {'n'}
    
    $settings["JultiJar"] = $textJulti.Text
    $settings["JingleJar"] = $textJingle.Text
    $settings["NinjabrainBotJar"] = $textNinjabrain.Text

    Save-Settings -settings $settings

    if ($checkJulti.Checked -and $textJulti.Text -ne "") {
        Check-And-Update -fileName "Julti" -localDirectory $textJulti.Text -githubUrl $githubUrls["Julti"]
    }
    if ($checkJingle.Checked -and $textJingle.Text -ne "") {
        Check-And-Update -fileName "Jingle" -localDirectory $textJingle.Text -githubUrl $githubUrls["Jingle"]
    }
    if ($checkNinjabrain.Checked -and $textNinjabrain.Text -ne "") {
        Check-And-Update -fileName "Ninjabrain-Bot" -localDirectory $textNinjabrain.Text -githubUrl $githubUrls["Ninjabrain-Bot"]
    }

    if ($checkPaceman.Checked -and ($checkJulti.Checked -or $checkJingle.Checked)) {
        # Automatically assign the correct plugin folder for Paceman
        if ($checkJulti.Checked) {
            $pacemanPath = "$([System.IO.Path]::Combine($env:USERPROFILE, '.Julti', 'plugins'))"
            $pluginType = "julti"
        } elseif ($checkJingle.Checked) {
            $pacemanPath = "$([System.IO.Path]::Combine($env:USERPROFILE, '.config', 'Jingle', 'plugins'))"
            $pluginType = "jingle"
        }
        Check-And-Update -fileName "paceman-aa-tracker" -localDirectory $pacemanPath -githubUrl $githubUrls["Paceman-AA-Tracker"] -pluginType $pluginType
    }
})

# Event handler for the done button
$buttonDone.Add_Click({
    $form.Close()
    [System.Windows.Forms.Application]::Exit()
})


# Show the form
$form.ShowDialog()

# Check if the script is running in a windowed environment (like when double-clicked)
if ($Host.UI.RawUI.WindowTitle -like "*powershell*") {
    Write-Host "Press any key to exit..."
    [System.Console]::ReadKey() > $null
}
