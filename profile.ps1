# EditMode                               : Emacs
# AddToHistoryHandler                    :
# HistoryNoDuplicates                    : True
# HistorySavePath                        : C:\Users\dvtuong\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt
# HistorySaveStyle                       : SaveIncrementally
# HistorySearchCaseSensitive             : False
# HistorySearchCursorMovesToEnd          : True
# MaximumHistoryCount                    : 4096
# ContinuationPrompt                     : >>
# ExtraPromptLineCount                   : 0
# PromptText                             : >
# BellStyle                              : None
# DingDuration                           : 0
# DingTone                               : 0
# CommandsToValidateScriptBlockArguments : {ForEach-Object, %, Invoke-Command, icm...}
# CommandValidationHandler               :
# CompletionQueryItems                   : 100
# MaximumKillRingCount                   : 10
# ShowToolTips                           : True
# ViModeIndicator                        : None
# WordDelimiters                         : ;:,.[]{}()/\|^&*-=+'"?????????
# CommandColor                           : "$([char]0x1b)[38;2;129;129;247m"
# CommentColor                           : "$([char]0x1b)[32m"
# ContinuationPromptColor                : "$([char]0x1b)[37m"
# DefaultTokenColor                      : "$([char]0x1b)[37m"
# EmphasisColor                          : "$([char]0x1b)[96m"
# ErrorColor                             : "$([char]0x1b)[91m"
# KeywordColor                           : "$([char]0x1b)[92m"
# MemberColor                            : "$([char]0x1b)[97m"
# NumberColor                            : "$([char]0x1b)[97m"
# OperatorColor                          : "$([char]0x1b)[90m"
# ParameterColor                         : "$([char]0x1b)[90m"
# SelectionColor                         : "$([char]0x1b)[30;47m"
# StringColor                            : "$([char]0x1b)[36m"
# TypeColor                              : "$([char]0x1b)[37m"
# VariableColor                          : "$([char]0x1b)[92m"

if ($PSVersionTable.PSVersion.Major -eq 7) {
    $PSStyle.FileInfo.Directory = $PSStyle.Foreground.Green
}

$PSReadLineOptions = @{
    EditMode = "Emacs"
        HistoryNoDuplicates = $true
        HistorySearchCursorMovesToEnd = $true
        BellStyle = "None"
}
Set-PSReadLineOption @PSReadLineOptions
# Set-PSReadLineOption -EditMode Emacs
# Set-PSReadlineOption -BellStyle None
set-variable -name "Setting" -value "C:\Users\dvtuong\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
# oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/pure.omp.json" | Invoke-Expression -ErrorAction SilentlyContinue
if ((get-alias ls -ErrorAction Ignore) -and $true) {
    Remove-Item Alias:ls
}
function ls {
    Get-ChildItem $args -Force
}
function gs {
    git status
}

function adb_con {
    param (
            [string]$ip = $( Read-Host "Ip: " ),
            [string]$code_port = $( Read-Host "Code port" ),
            [string]$wifi_port = $( Read-Host "Wifi port" )
          )
        set-variable -name "adb" -value "$env:LOCALAPPDATA\Android\sdk\platform-tools\adb.exe"
        powershell -Command "${adb} pair ${ip}:${code_port}"
        powershell -Command "${adb} connect ${ip}:${wifi_port}"
}

enum LinkType {
    File
    Dir
}
function mklink {
    param (
            [LinkType]$Type = [LinkType]::File,
            [Parameter(Mandatory)]
            [ValidateNotNullOrEmpty()]
            [string]$Dest,
            [Parameter(Mandatory)]
            [ValidateNotNullOrEmpty()]
            [string]$Src
          )
        if ($Type -eq 'd') {
            if (Test-Path -Type Leaf "$Dest") {
                Write-Error '$Dest must be a directory when using `-Type d`'
            } elseif (Test-Path -Type Leaf "$Src") {
                Write-Error '$Src must be a directory when using `-Type d`'
            } else {
                cmd /C mklink /D "$Dest" "$Src"
            }
        } else {
            if (Test-Path -Type Container "$Dest") {
                Write-Error '$Dest must be a file when using `-Type d`'
            } elseif (Test-Path -Type Container "$Src") {
                Write-Error '$Src must be a file when using `-Type d`'
            } else {
                cmd /C mklink "$Dest" "$Src"
            }
        }
}

