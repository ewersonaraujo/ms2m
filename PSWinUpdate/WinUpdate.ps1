@((New-Object -ComObject Microsoft.Update.Session).CreateupdateSearcher().Search("IsHidden=0 and IsInstalled=0").Updates) | Select-Object Title | Measure-Object | Select-Object -ExpandProperty Count