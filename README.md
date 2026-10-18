# Radio_Hitz

A public catalog and automation project for radio programs, historical broadcasts, spoken-word collections, playlists, and My Media for Alexa.

This project uses [My Media for Alexa](https://www.mymediaalexa.com/) as the local media application and an alternative to the user's former Plex-to-Alexa workflow. Audio recordings remain on local storage and NAS backups; this public repository contains only indexes, metadata, documentation, and scripts. Do not commit audio recordings, credentials, private settings, or sensitive local paths. File listings and metadata should be reviewed before publication.

<!-- RADIO-INDEX:START -->
<!-- RADIO-INDEX:END -->

## PowerShell Script Directory

| Script | Version | Description |
| --- | --- | --- |
| [Check_MyMediaInv.ps1](PowerShell/Utilities/Check_MyMediaInv.ps1) | 1.3.1 | Inventories local media categories, summarizes OTR shows and season/subfolder counts, and generates README and CSV files; excludes ZIP folders. |
| [Update-RadioIndex.ps1](PowerShell/Utilities/Update-RadioIndex.ps1) | 1.0 | Rebuilds the main README radio-show directory from `Catalog/RadioShows.csv`. |
| [Sync-MyMediaCatalog.ps1](PowerShell/Utilities/Sync-MyMediaCatalog.ps1) | 1.1 | Previews or copies reviewed catalog README/CSV files into a Git clone; optionally commits and pushes. |

## Media Category Indexes

The **Local Recording Folders** column represents category names beneath a user-configured local media root (for example, `<MediaRoot>\OTR`). Since local Windows folders cannot be opened from GitHub, these links lead to their corresponding catalog folders in this repository. All catalog paths are relative to the repository root.

<!-- MEDIA-CATEGORIES:START -->
| Category | Local Recording Folders | Catalog |
| --- | --- | --- |
| [OTR](Catalog/OTR/README.md) | [OTR](Catalog/OTR/) | [`Catalog/OTR/`](Catalog/OTR/) |
| [Speeches](Catalog/Speeches/README.md) | [Speeches](Catalog/Speeches/) | [`Catalog/Speeches/`](Catalog/Speeches/) |
| [Sermons](Catalog/Sermons/README.md) | [Sermons](Catalog/Sermons/) | [`Catalog/Sermons/`](Catalog/Sermons/) |
| [Books](Catalog/Books/README.md) | [Books](Catalog/Books/) | [`Catalog/Books/`](Catalog/Books/) |
| [Sound FX](Catalog/Sound%20FX/README.md) | [Sound FX](Catalog/Sound%20FX/) | [`Catalog/Sound FX/`](Catalog/Sound%20FX/) |
| [Radio](Catalog/Radio/README.md) | [Radio](Catalog/Radio/) | [`Catalog/Radio/`](Catalog/Radio/) |
<!-- MEDIA-CATEGORIES:END -->

**Updating:** Run `Check_MyMediaInv.ps1 -Execute` locally after changing recordings. Review its generated README and CSV files, then copy approved indexes into `Catalog/` and commit/push to GitHub. The GitHub workflow refreshes the separate radio-show directory from `Catalog/RadioShows.csv`; it does not scan local recordings. An OTR show README summarizes local recording counts and season/subfolder inventories; it is not a verified historical episode guide.

## Refresh the index

- **GitHub:** Actions > Update Radio Index > Run workflow. This refreshes show listings without accessing your local recordings.
- **Local:** Run `./PowerShell/Utilities/Update-RadioIndex.ps1 -MediaRoot 'D:\MyMedia\Radio-Shows'` to count files, then commit and push README.md.
- **Automatic:** Changes to `Catalog/RadioShows.csv` trigger the GitHub workflow to regenerate the directory.

See [setup documentation](Documentation/Setup.md).

## Publish Reviewed MyMedia Catalogs

Install Git for Windows and clone this repository to your PC. The [catalog synchronization utility](PowerShell/Utilities/Sync-MyMediaCatalog.ps1) defaults to `D:\BU\My_Computer\GitResp\Radio-Hitz`; use `-Repository` only to override it:

```powershell
# Preview only
& './PowerShell/Utilities/Sync-MyMediaCatalog.ps1' -Library '<LibraryRoot>' -Repository '.'

# Copy reviewed generated catalog files into the local clone
& './PowerShell/Utilities/Sync-MyMediaCatalog.ps1' -Library '<LibraryRoot>' -Repository '.' -Execute

# On a subsequent run, copy and publish directly (requires a clean clone)
& './PowerShell/Utilities/Sync-MyMediaCatalog.ps1' -Library '<LibraryRoot>' -Repository '.' -Execute -Push
```

The script copies only known inventory README and CSV filenames from the local MyMedia Library into relative repository paths such as `./Catalog/OTR/` and `./Catalog/Radio/`. It skips ZIP directories and README files without the expected generated marker. It checks for obvious absolute local paths, but **manually review catalog filenames and metadata before publishing to this public repository**. It does not copy audio files or delete destination files. Running `-Execute` without `-Push` changes the local clone, which must be committed, stashed, or reverted before running `-Execute -Push`.
