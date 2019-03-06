# Build in deploy MarkDown dokumentacije v FireStore hosting (z DocFX)

## Postavitev DocFX v GitHub projektu

Da postavimo DocFX, moramo uporabiti Chocolatey ali pa povlečemo .zip datoteko iz DocFX GitHub strani. To extractamo v našo projektno mapo, kateri dodamo PATH v Windows, da lahko kličemo docfx.exe iz Command Prompta.
Nato lahko v **cmd** inštaliramo DocFX z ukazom: '*docfx init -q*'

[Več informacij je na tej povezavi](https://kvaes.wordpress.com/2018/06/13/generating-a-docs-website-powered-by-git-markdown/)

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

## DocFX Templates

Če želimo na naši strani uporabiti enega od templatov, ki jih najdemo [tukaj](https://dotnet.github.io/docfx/templates-and-plugins/templates-dashboard.html), moramo slediti tem navodilom:
1. **Downloadamo** zip od templata
2. **Ustvarimo mapo** z imenom '*templates*' in v njo ekstrahiramo ta zip (mapo **material**)
3. **Posodobimo docfx.json**, da bo pod *"template":* izgledal tako:
     *"template": [ "default", "templates/material" ]* **('default' ohranimo!)**
     
Na strani od vsakega templata so tudi navodila za tega posebej ter po možnosti kakšne dodatne informacije.


     
