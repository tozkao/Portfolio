/* 2ème PARTIE : Requêtes SQL 
CARON Samuel
MOURONVAL Laurane
SAE 1.4 */

/* Question 1 : Il semble en effet que certains articles ou catégories ne soient jamais commandés est-ce le cas ? */ 

/* Requête : */
SELECT numarticle FROM article WHERE NOT numarticle IN (SELECT numarticle FROM detailcommande);

/* Résultat : */
 numarticle
------------
          7
(1 row)



/* Question 2 : Une action commerciale a été menée il y a 3 semaines sur les clients basés en Suisse. L’entreprise souhaiterait savoir s’il y a eu un effet sur les 
commandes. (Indice : Vous présenterez les résultats de vente cad le chiffre d’affaires par mois et le chiffre d’affaires par numéro de semaine). */

/* Requête : Pour montant toute taxes comprise pour chaque mois */
SELECT SUM(MONTANTTTC), date_part('month', datecommande) FROM commande WHERE numclient IN (SELECT numclient FROM client WHERE adressepaysclient LIKE 'Suisse') group by date_part('month', datecommande);

/* Résultat : */
   sum    | date_part
----------+-----------
  7044.00 |        10
 11340.00 |        11
 60921.00 |        12
(3 rows)

/* Requête : Pour montant toute taxes comprise pour chaque semaines */
SELECT SUM(MONTANTTTC), date_part('week', datecommande) FROM commande WHERE numclient IN (SELECT numclient FROM client WHERE adressepaysclient LIKE 'Suisse') group by date_part('week', datecommande);

/* Résultat : */
   sum    | date_part
----------+-----------
  7044.00 |        10
 11340.00 |        11
 60921.00 |        12
(3 rows)


/* Requête : Pour montant toute taxes comprise pour chaque mois */
SELECT SUM(MONTANTHT), date_part('month', datecommande) FROM commande WHERE numclient IN (SELECT numclient FROM client WHERE adressepaysclient LIKE 'Suisse') group by date_part('month', datecommande);

/* Résultat : */
   sum    | date_part
----------+-----------
  5870.00 |        10
  9450.00 |        11
 50767.50 |        12
(3 rows)

/* Requête : Pour montant toute taxes comprise pour chaque mois */
SELECT SUM(MONTANTHT), date_part('week', datecommande) FROM commande WHERE numclient IN (SELECT numclient FROM client WHERE adressepaysclient LIKE 'Suisse') group by date_part('week', datecommande);

/* Résultat : */
   sum    | date_part
----------+-----------
  5870.00 |        41
  9450.00 |        45
 50767.50 |        50
(3 rows)

/* Nous avons utilisé l'outil date_part qui permet de choisir si on recherche dans les dates par années, par mois, par semaines ou bien par jour. */



/* Question 3 : Existe-t-il des clients qui n’ont jamais passé de commandes ? Existe-t-il des clients d’un pays entier qui n’ont jamais passé de commandes ? */ 

/* Requête : Existe-t-il des clients qui n’ont jamais passé de commandes ? */ 
SELECT numclient FROM client WHERE NOT numclient IN (SELECT numclient FROM commande);

/* Résultat : */
 numclient
-----------
         6
         7
        14
        15
        18
        19
        20
(7 rows)


/* Requête 2 : Existe-t-il des clients d’un pays entier qui n’ont jamais passé de commandes ? */
SELECT adressepaysclient FROM client WHERE adressepaysclient NOT IN ( SELECT adressepaysclient FROM client WHERE numclient IN ( SELECT numclient FROM commande)) 
GROUP BY adressepaysclient ;

/* Résultat : */
 adressepaysclient
-------------------
 Royaume-Uni
(1 row)



/* Question 4 : Il semble que certaines commandes ne soient pas livrées totalement le phénomène est-il inquiétant ? */ 

/* Requête : */
SELECT numcommande FROM detailcommande WHERE quantitecommandee > quantitelivree ;

/* Résultat : */
 numcommande
-------------
           1
           3
           3
           3
           5
          13
          23
(7 rows)