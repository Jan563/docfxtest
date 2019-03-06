# Opis Devops pipeline za build docker image-a in deploy Docker hub

Za kreiranje Docker image-a iz našega Azure agenta naredimo štiri 'Docker' taske, ko smo zaključili z drugimi in je naš agent pripravljen za pakiranje v image. V teh Docker taskih izberemo štiri različne komande, v tem vrstnem redu:
  1. **Login**
    Preden lahko nadaljujemo, moramo vspostaviti 'Service connection' preko Azure interface-a, v katerem se z našim geslom in ID-jem povežemo na Docker Hub (ali drug Docker register) s čemer si zagotovimo pravice do objavljanja novih image-ov.
  2. **Build**
    V build fazi določimo pot do Dockerfile-a (glede na root repozitorija) in določimo ime image-a. Format tega naj bi izgledal takole: *janp110191/jan-repo:$(Build.BuildId)*
    Spremenljivka, kot je *$(Build.BuildId)* nam omogoča dinamično poimenovanje ter kasnejšo referenco na najnovejši image v Release fazi ter pa hranjenje zgodovine image-ov.
  3. **Tag**
    V tag fazi le kopiramo ime iz Build taska.
  4. **Push**
    V push fazi zopet naredimo le to. V build, tag in push mora biti navedeno isto ime, v vseh štirih taskih pa mora biti označen isti  'Service connection'

Končno naj bi zadeva izgledala takole:
![Build slika](/images/pic1.PNG)
