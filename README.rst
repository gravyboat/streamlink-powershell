Powershell Script Docs (Twitch, Youtube, Crunchyroll)
===============================

This guide assumes you have installed Streamlink and powershell:

https://github.com/streamlink/streamlink/releases

https://technet.microsoft.com/en-us/library/hh847837.aspx


Begin by modifying the ``powershell_settings.xml`` file so that you point
at the correct release of VLC.

Move the script ``Streamlink_powershell.ps1`` as well as the
``powershell_settings.xml`` script to your Streamlink folder.

Ensure PowerShell has scripts set correctly to allow all scripts by running
``Set-ExceutionPolicy Unrestricted`` inside of a PowerShell termina, and
select ``Y``. Note that you may need to set this in both the 64 (x86) versions,
and 32 bit versions of powershell. You will also need to run PowerShell as an
admin for this to work.

Right click the script and run as a powershell script and it should now prompt
for the main website, stream/episode, and the quality if applicable.
