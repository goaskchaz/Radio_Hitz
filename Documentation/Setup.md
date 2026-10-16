# Radio_Hitz setup

1. Create a private GitHub repository named `Radio_Hitz` under `goaskchaz` (without auto-initializing).
2. Unzip this starter into a local `Radio_Hitz` directory.
3. Open PowerShell in that directory and run:

```powershell
git init
git branch -M main
git add .
git commit -m "Initialize Radio_Hitz catalog and index automation"
git remote add origin https://github.com/goaskchaz/Radio_Hitz.git
git push -u origin main
```

4. Set Actions > General > Workflow permissions to allow read/write if required by your repository settings.
5. Run `./PowerShell/Utilities/Update-RadioIndex.ps1` locally to refresh show names.
6. To count actual episodes, use `./PowerShell/Utilities/Update-RadioIndex.ps1 -MediaRoot 'D:\MyMedia\Radio-Shows'`, replacing the example path.

The GitHub-hosted workflow cannot access a local Windows drive. Running it after a local count will replace local episode counts with `Not scanned`; for persistent counts, extend the workflow to consume a separately committed inventory CSV. This starter avoids falsely claiming cloud access to local files.
