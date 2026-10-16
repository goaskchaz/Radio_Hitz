<#
.SYNOPSIS
Rebuilds the Radio_Hitz README radio-show index.
.DESCRIPTION
Reads Catalog/RadioShows.csv and optionally counts audio files in matching local folders.
Does not copy, upload, modify, or delete recordings. Without -MediaRoot, counts show 'Not scanned'.
.PARAMETER MediaRoot
Optional local root directory containing one folder per radio show.
.EXAMPLE
.\PowerShell\Utilities\Update-RadioIndex.ps1
.EXAMPLE
.\PowerShell\Utilities\Update-RadioIndex.ps1 -MediaRoot 'D:\MyMedia\Radio-Shows'
.NOTES
Version: 1.0
#>
[CmdletBinding()]
param([string]$MediaRoot)
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot '../..')).Path
$csvPath = Join-Path $repoRoot 'Catalog/RadioShows.csv'
$readmePath = Join-Path $repoRoot 'README.md'
$shows = Import-Csv -LiteralPath $csvPath
$lines = @('## Radio Show Directory', '', 'Generated from `Catalog/RadioShows.csv`. Episode counts are local inventory results, not online catalog totals.', '', '| Radio program | Category | Episodes |', '| --- | --- | ---: |')
foreach ($show in $shows) {
    $count = 'Not scanned'
    if ($MediaRoot) {
        $folder = Join-Path $MediaRoot $show.FolderName
        if (Test-Path -LiteralPath $folder -PathType Container) {
            $count = [string]@(Get-ChildItem -LiteralPath $folder -Recurse -File | Where-Object { $_.Extension -in @('.mp3','.m4a','.flac','.wav','.ogg','.wma') }).Count
        } else { $count = 'Folder missing' }
    }
    $name = $show.Show.Replace('|','\|')
    $category = $show.Category.Replace('|','\|')
    $lines += "| $name | $category | $count |"
}
$readme = Get-Content -LiteralPath $readmePath -Raw
$start = '<!-- RADIO-INDEX:START -->'
$end = '<!-- RADIO-INDEX:END -->'
$pattern = '(?s)' + [regex]::Escape($start) + '.*?' + [regex]::Escape($end)
if ($readme -notmatch $pattern) { throw 'Radio index markers missing in README.md' }
$replacement = $start + "`n" + ($lines -join "`n") + "`n" + $end
$updated = [regex]::Replace($readme,$pattern,[System.Text.RegularExpressions.MatchEvaluator]{param($m) $replacement})
[System.IO.File]::WriteAllText($readmePath,$updated,[System.Text.UTF8Encoding]::new($false))
Write-Host "Updated Radio Show Directory: $($shows.Count) shows."
