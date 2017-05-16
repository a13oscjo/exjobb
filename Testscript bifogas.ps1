   New-Item "C:\Users\$env:UserName\Desktop\$env:UserName" -itemType directory
   New-Item "C:\Users\$env:UserName\Desktop\$env:UserName\test.txt" -itemType file
   "Scriptet fungerar och exekveras automatiskt" >> C:\Users\$env:UserName\Desktop\$env:UserName\test.txt