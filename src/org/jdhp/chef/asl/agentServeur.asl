/* ***************************** INITIAL BELIEFS *************************** */

started.
myJob(server).

/* ****************************** INITIAL GOALS **************************** */



/* ********************************** PLANS ******************************** */


/* ************************************ */


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


/* ************************************ */


+!getOrder :
    location(kitchen)
<-
    goto(room);
    !getOrder.


+!getOrder :
    location(room)
<-
    getAnOrder;                        // env : appelle fonc de l'env qui génere la commande (aleatoirement) et qui ajoute les croyances enAttente
    !passAnOrder.                      // passe la commande auprès du chef
 

/* ************************************ */


+!passAnOrder :                                    // transmet une commande au chef
    location(room)
<-
    goto(kitchen);
    !passAnOrder.


+!passAnOrder :                                    // transmet une commande au chef
    location(kitchen)                       &
    isWaiting(entree,     ELabel, CourseId) &      // passe la commande en cuisine si l'env a mis en attente une commande
    isWaiting(mainCourse, MLabel, CourseId) &      // passe la commande en cuisine si l'env a mis en attente une commande
    isWaiting(dessert,    DLabel, CourseId) &      // passe la commande en cuisine si l'env a mis en attente une commande
    job(ChefName, chef)                     &      // pour savoir qui est le chef
    .my_name(MyName)                               // récupere mon nom
<-
    isBeingCooked(ELabel, MLabel, DLabel, CourseId);         // supp plats en attente et passe encours
    .send(ChefName, achieve, entree(    ELabel, CourseId, MyName));
    .send(ChefName, achieve, mainCourse(MLabel, CourseId, MyName));
    .send(ChefName, achieve, dessert(   DLabel, CourseId, MyName)).


/* ************************************ */


+!serveOrder(CourseId) :
    location(kitchen)
<-
    goto(room);
    !serveOrder(CourseId).
 

+!serveOrder(CourseId) :
    isReady(entree,     ELabel, CourseId) &
    isReady(mainCourse, MLabel, CourseId) &
    isReady(dessert,    DLabel, CourseId) &
    location(room)
<-
    serveClient;                      // env : fonc de l'env qui supprime les 3 litéraux "pret" // ???
    .abolish(isWaiting(_, _, CourseId));
    .abolish(isReady(_, _, CourseId));
    !getOrder.


