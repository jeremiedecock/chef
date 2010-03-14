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


+!entree(Label, CourseId, ServerName) :
    true
<-
    .wait(500);
    cook(entree, Label, CourseId, ServerName);
    //isReady(entree, Label, CourseId);
    .send(ServerName, tell, isReady(entree, Label, CourseId)).


+!mainCourse(Label, CourseId, ServerName) :
    true
<-
    .wait(500);
    cook(mainCourse, Label, CourseId, ServerName);
    //isReady(mainCourse, Label, CourseId);
    .send(ServerName, tell, isReady(mainCourse, Label, CourseId)).


+!dessert(Label, CourseId, ServerName) :
    true
<-
    .wait(500);
    cook(dessert, Label, CourseId, ServerName);
    //isReady(dessert, Label, CourseId);
    .send(ServerName, tell, isReady(dessert, Label, CourseId));
    .send(ServerName, achieve, serveOrder(CourseId)).


/* ************************************ */


