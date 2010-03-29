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


+isReady(entree, Label, CourseId)[source(_)] :
    true
<-
    !takeCourse(entree, Label, CourseId).
 

+isReady(mainCourse, Label, CourseId)[source(_)]   :
    hasBeenServed(entree, _, CourseId)
<-
    !takeCourse(mainCourse, Label, CourseId).
 

+isReady(dessert, _, CourseId)[source(_)] : 
    hasBeenServed(mainCourse, _, CourseId)
<-
    !takeCourse(dessert, Label, CourseId);
    .abolish(hasBeenServed(entree, _, CourseId));
    .abolish(hasBeenServed(mainCourse, _, CourseId));
    .abolish(hasBeenServed(desert, _, CourseId));
    !getOrder.

 
/* ************************************ */


+!takeCourse(Course, Label, CourseId) :
    location(room)
<-
    goto(kitchen);
    !takeCourse(Course, Label, CourseId).


+!takeCourse(Course, Label, CourseId) :
    location(kitchen)
<-
    !serveCourse(Course, Label, CourseId).


+!serveCourse(Course, Label, CourseId) :
    location(kitchen)
<-
    goto(room);
    !serveCourse(Course, Label, CourseId).


+!serveCourse(Course, Label, CourseId) :
    location(room)
<-
    serveOrder(Course, Label, CourseId);
    .abolish(isWaiting(Course, Label, CourseId));
    .abolish(isReady(Course, Label, CourseId));
    hasBeenServed(Course, Label, CourseId).

