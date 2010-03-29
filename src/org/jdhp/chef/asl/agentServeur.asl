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
    .send(ChefName, achieve, allocate(entree,     ELabel, CourseId, MyName));
    .send(ChefName, achieve, allocate(mainCourse, MLabel, CourseId, MyName));
    .send(ChefName, achieve, allocate(dessert,    DLabel, CourseId, MyName)).


/* ************************************ */


-isWaiting(Type, Label, CourseId)[source(_)] :
    true
<-
    .abolish(isWaiting(Type, Label, CourseId)).


+!serveOrder(CourseId) :
    location(kitchen)
<-
    goto(room);
    !serveOrder(CourseId).


+!serveOrder(CourseId) :                                // Entree
    isReady(entree, ELabel, CourseId) &
    location(room)
<-
    .abolish(isWaiting(entree, ELabel, CourseId));
    .abolish(isReady(entree, ELabel, CourseId));
    hasBeenServed(entree, ELabel, CourseId).            // + gestion emplacement + envoi environement
 

//+!serveOrder(CourseId) :
//    not hasBeenServed(entree, _, CourseId) &              // TODO
//    isReady(mainCourse, MLabel, CourseId)   &
//    location(room)
//<-
//    .print("wait");
//    wait("+hasBeenServed(entree, _, CourseId)");              // TODO
//    !serveOrder(CourseId).
 

+!serveOrder(CourseId) :
    //hasBeenServed(entree, _, CourseId) &              // TODO
    isReady(mainCourse, MLabel, CourseId)   &
    location(room)
<-
    .abolish(isWaiting(mainCourse, MLabel, CourseId));
    .abolish(isReady(mainCourse, MLabel, CourseId));
    hasBeenServed(mainCourse, MLabel, CourseId).        // + gestion emplacement + envoi environement
 

+!serveOrder(CourseId) :
    //hasBeenServed(mainCourse, _, CourseId) &              // TODO
    isReady(dessert, _, CourseId)          &
    location(room)
<-
    .abolish(isWaiting(dessert, _, CourseId));
    .abolish(isReady(dessert, _, CourseId));
    .abolish(hasBeenServed(entree, _, CourseId));
    .abolish(hasBeenServed(mainCourse, _, CourseId));
    !getOrder.

 

