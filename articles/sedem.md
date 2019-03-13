# Angular Unit Testing v Azure Pipelines

Če želimo našo zbirko Test Case-ov, ki smo jih naredili v našem Angular programu testirati v Azure Pipelines, potrebujemo agenta na Ubuntu osnovi.

Taski v njem se vrstijo tako:
1. **Delete JUnit files.** 
     V tem tasku izbrišemo datoteko prejšnega testa. Uporabimo task *'Delete files'*, v katerega damo kot source mapo **junit** in kot contents ***'TESTS*.xml'**
2. **Node.js tool installer.**
    Namesti poljubno verzijo Node.js.
3. **Command Line**
    V tem inštaliramo Angular CLI ter naredimo build našega programa. Nato zaženemo še testing. Koda naj bi izgledala tako:

        npm install -g @angular/cli
        npm install
        ng build --prod
        npm run test -- --watch=false --browsers=ChromeHeadless
4. **Publish Test Results**
    S tem najdemo in objavimo rezultate Angular testov.

   **Test results** naj bi bil: ** /TESTS*.xml
   
   **Search folder** pa: *$(System.DefaultWorkingDirectory)/junit*
5. **Publish Pipeline Artifact**
   Na koncu lahko še objavimo našo **dist** mapo za nadaljne korake v *Release* fazi.

![Test Units](/images/pic8.PNG)

Po končanem Build-u bi morali v *'Tests'* tabu videti analizo.

[Več informacij na tej povezavi](https://www.olivercoding.com/2019-01-19-angular-azure-devops/)
