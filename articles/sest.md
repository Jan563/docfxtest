# Kreiranje Docker containerjev z docker-compose

Za to, da kreiramo container z ukazom docker-compose, bomo potrebovali **.yml** file. Uporabljal sem lokalnega agenta pri tem, za to mi ga ni treba vleči v Azure.

Yaml datoteka naj bi v osnovi izgledala nekako tako:

![Yaml](/images/pic7.PNG)

Na sliki se vidi, da sem definiral spremenljivko *$(APP_IMAGE)*. Ta se bo veza na zadnji Build ID iz Build faze, da lahko vedno povlečemo najnoveši image iz Docker Hub-a.

Naslednje moramo v Release fazi narediti le en task: **Powershell** ali **Docker compose task**. Jaz sem se v tem primeru odločil za Powershell.

![Yaml](/images/pic5.PNG)

Kot se vidi na sliki, najprej navigiram v datoteko, kjer imam svoj **docker-compose.yml**. To poimenovanje je **obvezno**, da ga docker-compose ukaz najde in izvrši.

Nato z PowerShell-ovim ukazom *$Env:* povem, kakšno vrednost želim v svoji spremenljivki. To vrednost bo naš .yml sam prebral in uporabil.

Končno z *docker-compose up -d* ukazom izvršimo ta YAML. -d pomeni detached in je priporočljiv. *Up* ukaz bo samodejno **posodobil in ponovno postavil** naš kontejner, pri čemer bo ohranil njegove nastavitve in je odličen za takšne zadeve.

[Več o docker-compose](https://docs.docker.com/compose/compose-file/)

[Več o spremenljivkah v docker-compose](https://docs.docker.com/compose/environment-variables/)
