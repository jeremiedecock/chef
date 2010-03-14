/* Initial beliefs */

started.
myJob(server).

/* Initial goals */



/* Plans */

+started :
    myJob(J) &
    .my_name(N)
<-
    register(J);                                 // se présente à l'environement
    .broadcast(tell, job(N, J));                 // se présente aux autres agents
    .broadcast(tell, lookingForIntroduce(N));    // demander aux autres agents de se présenter
    init;                                        // set initial location
    !getOrder.


+lookingForIntroduce(Name) :
    myJob(Job) &
    .my_name(Me)
<-
    .send(Name, tell, job(Me, Job));
    .abolish(lookingForIntroduce(Name)).


+!getOrder :
    location(kitchen)
<-
    goto(room);
    !getOrder.


+!getOrder :
    location(room)
<-
    getAnOrder;                        // env : appelle fonc de l'env qui génere la commande (aleatoirement) et qui ajoute les croyances enAttente
    !placeAnOrder.                     // passe la commande auprès du chef // placeAnOrder
    //!getOrder.                         // TODO ?????
 

+!placeAnOrder :
    location(room)
<-
    goto(kitchen);
    !placeAnOrder.


+!placeAnOrder :
    location(kitchen)           &
    isWaiting(entree, X, P)     &      // passe la commande en cuisine si l'env a mis en attente une commande
    isWaiting(mainCourse, Y, P) &      // passe la commande en cuisine si l'env a mis en attente une commande
    isWaiting(dessert, Z, P)    &      // passe la commande en cuisine si l'env a mis en attente une commande
    job(C, chef)                &      // pour savoir qui est le chef
    .my_name(N)                        // récupere mon nom
<-
    isBeingCooked(X, Y, Z, P);         // supp plats en attente et passe encours
    .send(C, achieve, entree(X, P, N));
    .send(C, achieve, plat(Y, P, N));
    .send(C, achieve, dessert(Z, P, N)).


+!serveOrder(N) :
    location(kitchen)
<-
    goto(kitchen);
    !serveOrder(N).
 

+!serveOrder(N) :
    isReady(entree, X, N)     &
    isReady(mainCourse, Y, N) &
    isReady(dessert, Z, N)    &
    location(room)
<-
    serveClient.                      // env : fonc de l'env qui supprime les 3 litéraux "pret" // ???


