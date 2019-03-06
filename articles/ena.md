# Postavitev kubernetes v Azure
Ko smo v Azure pridobili svoj **Azure Kubernetes Service**, lahko sledimo navodilom tam in inštaliramo Kubernetes na naš računalnik ter odpremo dashboard, s katerim nadziramo elemente Kubernetesa.

## Kubernetes (kubectl) ukazi
Kubernetes nam ponuja dostop poleg dashboarda tudi v command promptu, kjer ima vedno pripono '**kubectl**'.
S to pripono bomo ustvarjali vse elemente v Kubernetesu.
- ##### Klic YAML-a
  Za poganjanje naših .yaml datotek, ki definirajo različne stvari v Kubernetesu uporabljamo:
  1. *kubectl create -f (datoteka)*
  2. *kubectl apply -f (datoteka)*

  **'Create' uporabljamo le, kadar ne nameravamo storitve v prihodnosti nikoli spreminjati - če hočemo spremenljivo verzijo, ga vedno ustvarimo kar z 'apply'!**
- ##### Ogled storitev
  Če si hočemo ogledati listo storitev katerega tipa ali pa le eno v podrobnosti, uporabimo:
  1. *kubectl get (deployments, services, pods, persistentVolumes, itd.) (ime_storitve(ni obvezno))*
  2. *kubectl describe (deployment, service, pod, itd.) (ime_storitve(ni obvezno))*
  3. *kubectl run (za ročno ustvarjanje deploymentov in drugi storitev*)
  
    Za več ukazov in informacij napišemo '*kubectl --help*'.

## YAML

YAML je uporabljen za ustvarjanje elementov v Kubernetesu tako, da definiramo parametre v datoteki in jo nato kličemo z '*apply*' ali '*create*' ukazom.
Primer definicije nekega **Deploymenta**:

![Slika deploy](/images/pic3.PNG)

Primer definicije **servisa** (pri čemer mora selector kazati na obstoječ deployment, če želimo da ima servis kakšno funkcijo)

![Slika deploy](/images/pic4.PNG)

### Persistent Volume

![Slika deploy](/images/volume1.PNG)

Kot se vidi na sliki, potrebujemo za persistent volume deployment, Persistent Volume claim zanj, Storage Class, Persistent volume sam in pa secret.
Postopek je bolje opisan [na tem linku](https://pascalnaber.wordpress.com/2018/01/26/persistent-storage-and-volumes-using-kubernetes-on-azure-with-aks-or-azure-container-service/) *(pod 'Static Persistent Volume')*

