# %USERPROFILE%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1

# Use Starship
Invoke-Expression (&starship init powershell)

# Winget completions
Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)
    [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
    $Local:word = $wordToComplete.Replace('"', '""')
    $Local:ast = $commandAst.ToString().Replace('"', '""')
    winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
}

# Completions
. C:\Users\sergi\.dotfiles\windows\shell\espup.ps1
. C:\Users\sergi\.dotfiles\windows\shell\espflash.ps1

function Update-Completions {
    espup completions fish > $HOME\.dotfiles\windows\shell\espup.ps1
    espflash completions fish > $HOME\.dotfiles\windows\shell\espflash.ps1
}

# Create an alias for the function
Set-Alias -Name comp -Value Update-Completions

# Aliases
## File Navigation
Function Back { Set-Location -Path .\.. }
Set-Alias -Name .. -Value Back
Function BackBack { Set-Location -Path .\..\.. }
Set-Alias -Name ... -Value BackBack
Function BackBack { Set-Location -Path .\..\..\.. }
Set-Alias -Name .... -Value BackBack
Function Documents { Set-Location -Path C:\Users\sergi\Documents }
Set-Alias -Name cddoc -Value Documents
Function Espressif { Set-Location -Path C:\Users\sergi\Documents\Espressif }
Set-Alias -Name cdesp -Value Espressif
Function EspRs { Set-Location -Path C:\Users\sergi\Documents\Espressif\esp-rs }
Set-Alias -Name cdesprs -Value EspRs
Function Forks { Set-Location -Path C:\Users\sergi\Documents\Espressif\forks }
Set-Alias -Name cdforks -Value Forks
Function Tests { Set-Location -Path C:\Users\sergi\Documents\Espressif\tests }
Set-Alias -Name cdtests -Value Tests
Function Personal { Set-Location -Path C:\Users\sergi\Documents\Espressif\personal }
Set-Alias -Name cdper -Value Personal
Function ThirdParty { Set-Location -Path C:\Users\sergi\Documents\Espressif\third-party }
Set-Alias -Name cdtp -Value ThirdParty

