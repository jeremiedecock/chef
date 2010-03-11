/* Initial beliefs */

started.
myJob(chef).

/* Initial goals */



/* Plans */

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
    .send(Name, tell, job(Me, Job)).


+!entree(X, P, N) :
    true
<-
    cook(entree, X, P, N).


+!plat(X, P, N) :
    true
<-
    cook(plat, X, P, N).


+!dessert(X, P, N) :
    true
<-
    cook(dessert, X, P, N);
    .print(N);
    .send(N, achieve, deliverCommand(P)).

