/* ***************************** INITIAL BELIEFS *************************** */

started.
myJob(chef).

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
    init.                                        // set initial location


+lookingForIntroduce(Name) :
    myJob(Job) &
    .my_name(Me)
<-
    .send(Name, tell, job(Me, Job));
    .abolish(lookingForIntroduce(Name)).


/* ************************************ */



+!allocate(entree, ELabel, CourseId, ServerName) :
    true
<-
    .send(ServerName, tell, isBeingCooked(entree, ELabel, CourseId));
    .send(ServerName, untell, isWaiting(entree, ELabel, CourseId));

    !cook(entree, ELabel, CourseId, ServerName);

    .send(ServerName, tell, isReady(entree, ELabel, CourseId));
    .send(ServerName, untell, isBeingCooked(entree, ELabel, CourseId)).


+!allocate(mainCourse, MLabel, CourseId, ServerName) :
    true
<-
    .send(ServerName, tell, isBeingCooked(mainCourse, MLabel, CourseId));
    .send(ServerName, untell, isWaiting(mainCourse, MLabel, CourseId));

    !cook(mainCourse, MLabel, CourseId, ServerName);

    .send(ServerName, tell, isReady(mainCourse, MLabel, CourseId));
    .send(ServerName, untell, isBeingCooked(mainCourse, MLabel, CourseId)).


+!allocate(dessert, DLabel, CourseId, ServerName) :
    true
<-
    .send(ServerName, tell, isBeingCooked(dessert, DLabel, CourseId));
    .send(ServerName, untell, isWaiting(dessert, DLabel, CourseId));

    !cook(dessert, DLabel, CourseId, ServerName);

    .send(ServerName, tell, isReady(dessert, DLabel, CourseId));
    .send(ServerName, untell, isBeingCooked(dessert, DLabel, CourseId)).
    


/* ************************************ */


+!cook(Type, Label, CourseId, ServerName) :
    true
<-
    .abolish(isWaiting(Type, Label, CourseId));
    isBeingCooked(Type, Label, CourseId);
    .wait(500);
    .abolish(isBeingCooked(Type, Label, CourseId));
    isReady(Type, Label, CourseId, ServerName).


