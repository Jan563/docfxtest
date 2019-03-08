# DevOps Agent na lastnem računalniku

Kadar želimo, da se Agent Job izvaja na našem računalniku in ne hostu od Azure, navigiramo v Azure DevOps v **settings** (spodaj levo) kjer najdemo tab **agent pools**.

Nato lahko uporabimo ali **Default (Default)** pool ali pa naredimo svojega z klikom na *New agent pool*. V default ali v našem pool-u navigiramo v tab **Roles** kjer dodamo uporabnika, s katerim delamo, kot administratorja z klikom na gumb **(+ Add).** 

Ko smo kreirali pool ali pa se odločili za default, stisnemo **Download Agent** gumb- ta nam vedno da enake datoteke, ne glede na to kje v UI-ju smo.

Downloadamo njihov .zip file in nato sledimo preprostim navodilom. [Podrobnejša navodila so tu.](https://docs.microsoft.com/sl-si/azure/devops/pipelines/agents/v2-windows?view=azure-devops)

Pri kreiranju samega Agenta si lahko izberemo, ali bo le ta delal kakor Windows service ali se poganja kar iz Command Line.

Ko je vse vzpostavljeno, lahko izberemo naš Agent Pool pri kateremkoli build-u ali release-u.

Pri vsem tem si moramo zapomniti, da lahko ima en Agent Pool **več** Agentov hkrati, vendar pri Azure konfiguraciji brez dodatnih plačil lahko zmerom dela le eden.

![Slika Agent Pools](/images/pic6.PNG)


