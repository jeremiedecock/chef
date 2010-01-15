!cookAll.

+!cookAll : true
            <-
			informChef.
			
+!entree(X, P, N) : true
                    <-
					cook(entree, X, P, N).

+!plat(X, P, N) : true
                  <-
				  cook(plat, X, P, N).

+!dessert(X, P, N) : true
                     <-
					 cook(dessert, X, P, N);
				     .print(N);
					 .send(N, achieve, deliverCommand(P)).

