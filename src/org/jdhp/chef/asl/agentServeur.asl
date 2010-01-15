!start.

+!start : true
          <-
		  init;                        // env : met ag ds cuisine
	      !commander.
						  
+!commander : location(cuisine)
              <-
			  moveTo(salle);
			  !commander.

+!commander : location(salle)
              <-
			  passerCommandeClient;    // env : appelle fonc de l'env qui génere la commande (aleatoirement) et qui ajoute les croyances enAttente
			  moveTo(cuisine);
			  !passerCommandeCuisine;  // passe la commande auprès du chef
			  moveTo(salle);
			  !commander.
			  
+!passerCommandeCuisine : enAttente(entree, X, P) &  // passe la commande en cuisine si l'env a mis en attente une commande
                          enAttente(plat, Y, P) &    // passe la commande en cuisine si l'env a mis en attente une commande
						  enAttente(dessert, Z, P) & // passe la commande en cuisine si l'env a mis en attente une commande
						  chef(C) &       // pour savoir qui est le chef
						  .my_name(N)     // récupere mon nom
						  <-
						  updateAttente(X, Y, Z, P);    // supp plats en attente et passe encours
						  .send(C, achieve, entree(X, P, N));
						  .send(C, achieve, plat(Y, P, N));
						  .send(C, achieve, desert(Z, P, N)).

+!delivrerCommande(N) : location(cuisine)
						<-
						moveTo(salle);
						!delivrerCommande(N).
						  
+!delivrerCommande(N) : pret(entree, X, N) &
                        pret(plat, Y, N) &
						pret(dessert, Z, N) &
						location(salle)
						<-
						servirClient.  // env : fonc de l'env qui supprime les 3 litéraux "pret" // ???


