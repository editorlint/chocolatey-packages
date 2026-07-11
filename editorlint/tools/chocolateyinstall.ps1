$ErrorActionPreference = 'Stop'

$packageName = 'editorlint'
$version = '0.3.0'
$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  PackageName   = $packageName
  UnzipLocation = $toolsDir
  Url64bit      = "https://github.com/dobbo-ca/editorlint/releases/download/$version/editorlint-${version}-windows-amd64.zip"
  Checksum64    = '69d49a19b60e212d5fa3e219368d32c396c0c93efde1edb19258efb3f91225f8'
  ChecksumType64= 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

# Create a batch file to make the executable available in PATH
$batchFile = Join-Path $toolsDir 'editorlint.bat'
'@echo off' | Out-File -FilePath $batchFile -Encoding ASCII
"`"$toolsDir\editorlint.exe`" %*" | Out-File -FilePath $batchFile -Encoding ASCII -Append
