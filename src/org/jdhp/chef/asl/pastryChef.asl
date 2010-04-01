/* ***************************** INITIAL BELIEFS *************************** */

started.
myJob(pastryChef).

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


+!cook(Label, CourseId, ServerName, ChefName) :
    .my_name(Me)
<-
    .print("I'm cooking ", Label);
    .send(ServerName, tell, isBeingCooked(dessert, Label, CourseId));
    .send(ServerName, untell, isWaiting(dessert, Label, CourseId));

    .wait(500);

    .print("It's ready !");
    .send(ChefName, tell, isReady(Me, CourseId));
    .send(ServerName, tell, isReady(dessert, Label, CourseId));
    .send(ServerName, untell, isBeingCooked(dessert, Label, CourseId)).

