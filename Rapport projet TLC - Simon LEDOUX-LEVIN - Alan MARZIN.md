Simon LEDOUX-LEVIN 
Alan MARZIN

Projet TLC - Google App Engine
ISTIC - Master 2 ILA - 2017/2018

URL APPLICATION : https://proj-pub-cuicui.appspot.com/

 1 - Développement de l'application 'MegaAds4U' 

Pour le projet de TLC, nous avons développé une application web avec les technologies JAVA : servlet et JSP.
Cette application a été développée dans le cadre d'un développement dans le cloud Google app engine.
Le principe étant de déployer à travers une infrastructure distribuée une application autonome.
Le but de l'appli était de permettre à des utilisateurs d'ajouter des annonces/publicités dans une liste afin que d'autres
utilisateurs puissent visualisés les annonces postés (dans la catégorie choisie).

Plusieurs fonctionnalités ont été implémentés : 
    -Visualiser la liste des pub d'une catégorie
    -Changer de catégorie
    -Ajouter une pub 
    -Ajouter une liste de pub 
    -Supprimer une pub
    -Filtrer la liste des pubs avec un mot-clé 

Les données ont été stockés dans un datastore de Google app engine, un base de données noSQL accessible depuis l'application web.

Voici les types de données (collections) insérées dans le datastore :
    - Category (possède : un nom, une liste de Ads)
    - Ads (possède : un titre, une prix, une description, et une date d'ajout)

Nous avons utilisé la librairie Bootstrap pour le style de notre application web.


2 - Test de charge et de performance

Pour verifier le comportement de notre application dans le cloud, nous avons créer un programme
qui permet de controler la latence de notre application. Pour ce faire, nous avons tester d'abord notre appli
sur notre ordinateur localhost (sans profiter des avantages de google app engine). 

Nous avons alors créer un programme Java qui initialise 10 Thread qui effectuent un création de Ads a partir d'une liste.
Le nom de ce projet est measure. 

Résultat des tests de performance et de charge :

APPLI EN LOCALHOST :
    ******** DEBUT lancement des threads)*********
    ******** FIN lancement des threads)*********
    [REQ Num3] latence = 3975 ms
    [REQ Num1] latence = 4843 ms
    [REQ Num7] latence = 6608 ms
    [REQ Num9] latence = 7509 ms
    [REQ Num0] latence = 8816 ms
    [REQ Num4] latence = 9161 ms
    [REQ Num6] latence = 9300 ms
    [REQ Num2] latence = 9507 ms
    [REQ Num5] latence = 10321 ms
    [REQ Num8] latence = 10371 ms

Nous remarquons que la temps de latence augmente fortement au fur et a mesure qu'il y a des requetes a traités.
Notre serveur ne peut parallèlisé le traitement de nos requetes. 


APPLI GOOGLE APP ENGINE :
******** DEBUT lancement des threads)*********
******** FIN lancement des threads)*********
[REQ Num2] latence = 1278 ms
[REQ Num7] latence = 1274 ms
[REQ Num3] latence = 1508 ms
[REQ Num0] latence = 1913 ms
[REQ Num9] latence = 2065 ms
[REQ Num4] latence = 2603 ms
[REQ Num8] latence = 2806 ms
[REQ Num6] latence = 3073 ms
[REQ Num5] latence = 3079 ms
[REQ Num1] latence = 3607 ms


Ici, nous avons executé le même programme sur notre serveur web Google app engine.
Le temps de latence de nos threads est complémentement différent.
Les traitements sont beaucoup plus rapide et même si il y a une augmentation du temps de latence,
elle est beaucoup plus lègere qu'en localhost.
Google app engine réduit cette latence car il peut initialisé plusieurs instances de notre application pour gérer la forte demande de requête.

3- Conclusion

Grace au module TLC, nous avons pu être initié au devéloppement dans le cloud.
Nous avons pu constater les différetns avantages du cloud du type PaaS.
Nous n'avons pas eu a nous soucier de notre infrastrcuture et de la gestion des données,
nous nou sommes focaliser sur le développement de l'appli.
De plus, Google App engine déploie automatiquement notre application sur plusieurs instances en fonction de la demande.
Il aurait était compliqué pour nous de gérer cete partie de nos application (load balancing, ...)
Cependant, nous avons constaté aussi que l'installation de l'environnement (SDK, projet maven, ...) nous a posé 
quelques problèmes au début du projet ce qui nous a fait perdre un peu de temps.