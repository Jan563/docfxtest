Navodila za postavitev
V prvi fazi je potrebno v Azure postaviti Kubernetes service, ki nam omogoča izvajanje kubernetes komand v 'cmd' prompt ter vpogled v dashboard z navodili, ki so na njihovi strani. Za testiranje napišemo v command prompt 'kubectl'.

'Build' faza
Nato se povežemo na Azure DevOps, kjer najdemo zavihek Pipelines. Pod zavihkom 'builds' se prvo povežemo na naš GitHub repozitorij in določimo tip proženja (ob vsaki spremembi, ročno). Agent pool naj bo tipa Hosted Ubuntu. Nato pod prvim in edinim Agent Job začnemo nizati taske:

Use Node 8.x (Inštalacija poljubne verzije Node.js)
Command line (V njem naredimo production build, torej:)
npm install -g @angular/cli cd ./ProjektPoste npm install ng build --prod echo Production build finished!
Docker login (Pri čemer naredimo service connection Primer Image name: janp110191/jan-repo:$(Build.BuildId))
Docker build (Naša mapa, ki jo z Gita vlečemo, naj ima Dockerfile, v katerem je določeno katere datoteke se vključijo v naš build.)
Docker tag (Kopiramo Image name iz Docker build taska)
Docker push (Upload v določen repozitorij. Login je potreben za to fazo. Kopiramo zopet Image name od zgoraj.)
Pri vseh docker taskih potrebujemo delujoč service connection.

Agent Job naj bo linux, saj so v primeru Windows bile neke komplikacije.

Build slika

'Release' faza
Nato skočimo v 'Releases' zavihek, kjer ustvarimo nov release in kot artifact določimo ta build. V proženju lahko izberemo, ali se release izvaja ročno ali avtomatsko po uspešno končanem buildu. Pri release imamo dva načina postavitve storitve:

Tekstovni ukazi S tem primerom postavimo Kubernetesu argumenete kar v command line. Naredimo dva 'Deploy to Kubernetes' tasks na Agent jobu, pri čemer je prvi run in drugi expose. Task naredi 'kubectl run/expose' del, mi pa ostalo v Arguments. Pri 'run' so argumenti takšni:
$(Release.ReleaseId) --image=janp110191/jan-repo:$(Build.BuildId) --port=80
Pri expose pa: deployment $(Release.ReleaseId) --name=service-$(Release.ReleaseId) --type=LoadBalancer --port=3000 --target-port=80
Build slika

YAML navodili S tem primerom naredimo enako 'Deploy to Kubernetes' task, v katerem uporabimo 'apply'. Tam kličemo našo YAML datoteko, ki bi jo vključili v naš GitHub repozitorij. (YAML mora vsebovati navodila za deployment in service tipa LoadBalancer) Ker YAML ne dopušča dinamičnih zunanjih spremenljivk, z še enim 'set' taskom popravimo image na najnoveji:
kubectl set deployment (ime) --image janp110191/jan-repo:$(Build.BuildId)
V obeh primerih pazimo, da so porti pravilno konfigurirani glede na image, ki ga uporabljamo. Servis pa mora biti tipa 'LoadBalancer' Dodatna navodila so tu.

Na Kubernetes dashboardu bi sedaj morali videti naš deployment in toliko podov, kolikor smo jih definirali. Servis bi moral biti z statusom 'pending' za kratek čas, preden se mu dodeli External IP in je aplikacija dosegljiva.

Kubernetes (kubectl) ukazi
Kubernetes nam ponuja dostop poleg dashboarda tudi v command promptu, kjer ima vedno pripono 'kubectl'.

Yaml
Za poganjanje naših .yaml datotek, ki definirajo različne stvari v Kubernetesu uporabljamo:

kubectl create -f (datoteka)
kubectl apply -f (datoteka)
'Create' uporabljamo le, kadar ne nameravamo storitve v prihodnosti nikoli spreminjati - če hočemo spremenljivo verzijo, ga vedno ustvarimo kar z 'apply'.

Ogled storitev
Če si hočemo ogledati listo storitev katerega tipa ali pa le eno v podrobnosti, uporabimo:

kubectl get (deployments, services, pods, persistentVolumes, itd.) (ime_storitve(ni obvezno))
kubectl describe (deployment, service, pod, itd.) (ime_storitve(ni obvezno))
kubectl run (za ročno ustvarjanje deploymentov in drugi storitev)
YAML
Kreiranje osnovnega deploymenta:

Slika deploy

Kreiranje servisa za nek deployment:

Slika deploy

Persistent volumes

Slika deploy

Kot se vidi na sliki, potrebujemo za persistent volume deployment, Persistent Volume claim zanj, Storage Class, Persistent volume sam in pa secret. Postopek je bolje opisan na tem linku(pod 'Static Persistent Volume')

Viri:
Video z podobnimi koraki
Blog z navodili (na koncu vključuje Helm)
