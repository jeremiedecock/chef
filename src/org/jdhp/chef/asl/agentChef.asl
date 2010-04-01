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
    .findall(elem(Num, Name), job(Name, commis) & .count(isCooking(Name, _), Num), List) &
    .sort(List, SortedList) &
    .length(SortedList, Size) &
    Size > 0 &
    .nth(0, SortedList, elem(Num, Name)) &
    .my_name(Me)
<-
    +isCooking(Name, CourseId);
    .send(Name, achieve, cook(entree, ELabel, CourseId, ServerName, Me)).


+!allocate(mainCourse, MLabel, CourseId, ServerName) :
    (not (MLabel == ratatouille)) &
    .findall(elem(Num, Name), job(Name, commis) & .count(isCooking(Name, _), Num), List) &
    .sort(List, SortedList) &
    .length(SortedList, Size) &
    Size > 0 &
    .nth(0, SortedList, elem(Num, Name)) &
    .my_name(Me)
<-
    +isCooking(Name, CourseId);
    .send(Name, achieve, cook(mainCourse, MLabel, CourseId, ServerName, Me)).


+!allocate(mainCourse, MLabel, CourseId, ServerName) :
    MLabel == ratatouille
<-
    //isBeingCooked(Type, Label, CourseId, ServerName);
    .send(ServerName, tell, isBeingCooked(mainCourse, MLabel, CourseId));
    .send(ServerName, untell, isWaiting(mainCourse, MLabel, CourseId));

    !cook(CourseId);

    .send(ServerName, tell, isReady(mainCourse, MLabel, CourseId));
    .send(ServerName, untell, isBeingCooked(mainCourse, MLabel, CourseId)).


+!allocate(dessert, DLabel, CourseId, ServerName) :
    job(PastryChefName, pastryChef) &               // pour savoir qui est le chef pâtissier
    .my_name(Me)
<-
    +isCooking(PastryChefName, CourseId);
    .send(PastryChefName, achieve, cook(DLabel, CourseId, ServerName, Me)).


+!allocate(dessert, DLabel, CourseId, ServerName) :
    not job(_, pastryChef)
<-
    //wait(3000);
    wait("+job(_, pastryChef)");
    !allocate(dessert, DLabel, CourseId, ServerName).


/* ************************************ */


+isReady(Name, CourseId) :
    true
<-
    -isCooking(Name, CourseId).


/* ************************************ */


+!cook(CourseId) :
    true
<-
    !!prepareMeals(CourseId);
    !prepareVegetables(CourseId);
    !prepareSauce(CourseId);
    .print("It's ready !").


+!prepareMeals(CourseId) :
    true
<-
    .print("I'm cooking meal for ", CourseId);
    .wait(500).


+!prepareVegetables(CourseId) :
    true
<-
    .print("I'm cooking vegetables for ", CourseId);
    .wait(500).


+!prepareSauce(CourseId) :
    true
<-
    .print("I'm cooking sauce for ", CourseId);
    .wait(500).

