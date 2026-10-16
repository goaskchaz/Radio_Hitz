# Radio_Hitz

A central library for organizing radio programs, historical broadcasts, playlists, and My Media automation.

Audio recordings remain on the local drive; this repository holds indexes, playlists, documentation, and automation scripts. Do not commit copyrighted recordings or private local file paths.

<!-- RADIO-INDEX:START -->
<!-- RADIO-INDEX:END -->

## PowerShell Script Directory

| Script | Version | Description |
| --- | --- | --- |
| [Update-RadioIndex.ps1](PowerShell/Utilities/Update-RadioIndex.ps1) | 1.0 | Regenerates the radio index; optionally counts local audio recordings. |

## Refresh the index

- **GitHub:** Actions > Update Radio Index > Run workflow. This refreshes show listings without accessing your local recordings.
- **Local:** Run `./PowerShell/Utilities/Update-RadioIndex.ps1 -MediaRoot 'D:\MyMedia\Radio-Shows'` to count files, then commit and push README.md.
- **Automatic:** Changes to `Catalog/RadioShows.csv` trigger the GitHub workflow to regenerate the directory.

See [setup documentation](Documentation/Setup.md).
