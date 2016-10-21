<# Streamlink powershell script #>

[CmdletBinding()]
param ()

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.path

$executable = "\bin\streamlink.exe"

$fullExecutablePath = $scriptDir + $executable

write-OutPut "$fullExecutablePath"

[xml]$ConfigFile = Get-Content "$scriptDir\powershell_settings.xml"

$defaultSite = $ConfigFile.Settings.DefaultSite
$defaultStream = $ConfigFile.Settings.DefaultStream
$defaultQuality = $ConfigFile.Settings.DefaultQuality
$crunchyUser = $ConfigFile.Settings.CrunchyRollUser
$crunchyPassword = $ConfigFile.Settings.CrunchyRollPassword
$crunchyQuality = $ConfigFile.Settings.CrunchyRollQuality
$vlcPath = $ConfigFile.Settings.VlcPath

$site = Read-Host "What streaming/video site? [twitch.tv, youtube.com, crunchyroll.com] (default is $defaultSite)"

if ($site -eq "youtube.com")
{
    $site = "youtube.com/watch?v="
    $youtube = $TRUE
}
if ($site -eq "crunchyroll.com")
{
    $site = "http://crunchyroll.com/"
    $crunchyroll = $TRUE
}

$stream = Read-Host "What user or video? [twitch: totalbiscuit, youtube: njCDZWTI-xg, crunchyroll: hunter-x-hunter/episode-148-past-x-and-x-future-654039 ] (default is $defaultStream)"
$quality = Read-Host "What quality? (default is $defaultQuality)"

if (-Not $site)
{
    $site = $defaultSite
}

if (-Not $stream)
{
    $stream = $defaultStream
}

if (-Not $quality)
{
    if ($crunchyroll)
    {
        $quality = $crunchyQuality
    }
    $quality  = $defaultQuality
}

try
{
    if ($youtube)
    {
        & $fullExecutablePath "$site$stream" "$quality"
    }
    elseif ($crunchyroll)
    {
        & $fullExecutablePath "--crunchyroll-username=$crunchyUser" "--crunchyroll-password=$crunchyPassword" "$site$stream" "$quality"
    }
    else
    {
        & $fullExecutablePath "$site/$stream" "$quality" --player=$vlcPath
    }
}
catch
{
    Write-Warning $_.Exception.Message
}