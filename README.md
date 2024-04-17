# containers

## Allow shell execution from powershell
```powershell
Get-ChildItem -Recurse -Filter *.sh | ForEach-Object { git update-index --chmod=+x $_.FullName }
```

```bash
find . -type f -name "*.sh" -exec git update-index --chmod=+x {} \;
```