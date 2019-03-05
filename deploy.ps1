$dir = Split-Path $MyInvocation.MyCommand.Path
Push-Location $dir

npm i -g firebase-tools
write-host "starting deploy...";
firebase --version;
firebase deploy --token "1/5DTQvFZGLxga-T1xrgvrfbnnbc6nnMk2LV9FCVqZpH0" --project "my-test-project-c4ce1" --message "Release: 1.0" --only hosting;
write-host "deployment completed";

Pop-Location
