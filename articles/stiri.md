# Build in deploy MarkDown dokumentacije v FireStore hosting (z DocFX)

## 'Build' faza
1. **Chocolatey**
   Začnemo s tem, da ustvarimo en Chocolatey task, v katerem pod polje ID package-a vpišemo le *'docfx'* in izberemo kod         Command '*install*'.
2. **Command Line Script**
   S Command Line Skripto poženemo *'docfx docfx.json'*. Ta datoteka bi morala biti ustvarjenja v prejšnem tasku. Za lažje razumevanje lahko damo tudi '*dir*' ukaz pred in po njem.
3. **Publish Build Artifact**
   Naredimo štiri Publish Build Artifact, ki imajo vsi Artifact Name '*drop*' ter sledeče '*Path to Publish*':
   - $(Build.ArtifactStagingDirectory)
   - deploy.ps1 (s tem inštaliramo orodje za firebase, da lahko kličemo spodnjo datoteko firebase.json.)
   - firebase.json
   - _site (To mapo kreira klic docfx.json-a.)

   Display names so poljubna.
   [Primer **deploy.ps1**](https://github.com/Jan563/docfxtest/blob/master/deploy.ps1)
   [Primer **firebase.json**](https://github.com/Jan563/docfxtest/blob/master/firebase.json)
## 'Release' faza
V tej fazi izberemo artifakt iz builda, ki smo ga ravnokar naredili. Nato ustvarimo pod Agentom le en **Powershell** script task.
Pod **script path** navedemo sledeče: *$(System.DefaultWorkingDirectory)/_dotfx/drop/deploy.ps1*  (ali z klikom na tri pike sami navigiramo do **deploy.ps1**)
