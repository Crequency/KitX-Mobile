using namespace System.IO

param(
    $keyPassword,
    $storePassword,
    $keyAlias,
    $storeFile,
    $jksBase64
)

$fileName = "key.properties"

$content = "lock=lock
keyPassword=$keyPassword
storePassword=$storePassword
keyAlias=$keyAlias
storeFile=$storeFile"

$currentPath = $pwd.ToString()

Write-Debug "# Current path: $currentPath"

while (([DirectoryInfo]$currentPath).FullName -ne ([DirectoryInfo]$currentPath).Parent.FullName) {
    Write-Debug "# Current path: $currentPath"

    $relativeKitxMobilePath = Join-Path $currentPath "kitx_mobile"
    $resolvedKitxMobilePath = Resolve-Path $relativeKitxMobilePath -ErrorAction SilentlyContinue

    Write-Debug "# Relative path: $relativeKitxMobilePath"
    Write-Debug "# Resolved path: $resolvedKitxMobilePath"

    if ($resolvedKitxMobilePath -and (Test-Path $resolvedKitxMobilePath -Type Container)) {
        Set-Location $resolvedKitxMobilePath.ProviderPath
        break
    }
    else {
        $currentPath = ([DirectoryInfo]$currentPath).Parent.FullName
    }
}

if (Test-Path "pubspec.yaml") {
    Write-Host "Changing directory to 'kitx_mobile'"
}
else {
    Write-Error "We can't find `kitx_mobile` folder"
    exit 1
}

Set-Location android

Write-Output $content > $fileName

Set-Location app

if (($null -eq $jksBase64) -or ('' -eq $jksBase64)) {
    Write-Error "JKS file is not provided"
    exit 1
}

$decodedBytes = [System.Convert]::FromBase64String($jksBase64)

Set-Content -Path $storeFile -Value $decodedBytes -AsByteStream

Write-Host "Key properties and JKS file are created successfully."
