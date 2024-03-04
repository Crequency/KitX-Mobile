Set-Location android/app

keytool -genkey -v -keystore local_run.jks -keyalg RSA -keysize 2048 -validity 3650 -alias local_run -keypass testpwd -storepass testpwd -dname "cn=local_run,ou=xxx,o=xxx,l=xxx,st=xxx,c=xxx"

Set-Location ..

$content = "lock=lock
keyPassword=testpwd
storePassword=testpwd
keyAlias=local_run
storeFile=local_run.jks"

Write-Host "Writing key.properties with below content:"
Write-Host $content

$selection = Read-Host "Is this correct? (y/n)"
if ($selection.ToLower() -eq 'y') {
    Write-Output $content > key.properties
}

Set-Location ..
