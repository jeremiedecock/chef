// Environment code for project chef.mas2j

package org.jdhp.chef;

import jason.asSyntax.*;
import jason.environment.*;

import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Restaurant extends Environment {
	
	public final static int tickDuration = 1000;   // tick duration in ms
	
	private int orderId, waitingOrder;
	
	private Logger logger = Logger.getLogger(Restaurant.class.getName());
	
	private HashMap<String, String> jobMap;
	
	private HashMap<String, String> positionMap;
	
	private String[] location = {"kitchen", "room"};
	
	private String[] entree = {"potato_salad ", "chicken_salad", "chef_salad "};
	
	private String[] mainCourse = {"ratatouille ", "pot_au_feu ", "omelette"};
	
	private String[] dessert = {"ice_cream", "chocolate_cake", "fruit salad"};
	
    /** 
	 * Called before the MAS execution with the args informed in .mas2j
	 */
    @Override
    public void init(String[] args) {
    	this.orderId = 0;
    	this.waitingOrder = 0;
    	this.jobMap = new HashMap<String, String>();
    	this.positionMap = new HashMap<String, String>();
    	
    	this.logger.setLevel(Level.INFO);
    	
		//int random = (int) ((10 - 1) * Math.random());
		//addPercept(Literal per);  // Ajoute une perception dans l'environement (ie pour tout le monde)
		//addPercept(String agName, Literal arg1); // Ajoute une perception pour l'agent agName
    }

	/**
	 * Execute les actions définies dans les fichiers .asl
	 */
    @Override
    public boolean executeAction(String agName, Structure action) {
        this.logger.log(Level.INFO, "[" + agName + "] : " + action);
		
        if(action.getFunctor().equals("register")) {
        	
        	this.logger.log(Level.INFO, "\t" + agName + " = " + action.getTerm(0));
        	this.jobMap.put(agName, action.getTerm(0).toString());
        	
        } else if(action.getFunctor().equals("init")) { // punch in
        	
        	this.logger.log(Level.INFO, "\t" + "init " + agName + " (clear percepts and set location)");
        	this.clearPercepts(agName);
        	this.positionMap.put(agName, location[0]);
        	this.addPercept(agName, Literal.parseLiteral("location(" + this.positionMap.get(agName) + ")"));
        	
        } else if(action.getFunctor().equals("goto")) {
        	
        	this.logger.log(Level.INFO, "\t" + agName + " is moving from " + this.positionMap.get(agName) + " to " + action.getTerm(0));
        	this.removePercept(agName, Literal.parseLiteral("location(" + this.positionMap.get(agName) + ")"));
        	this.positionMap.put(agName, action.getTerm(0).toString());
        	this.addPercept(agName, Literal.parseLiteral("location(" + action.getTerm(0) + ")"));
        	//on ne peut pas supprimer des percepts suivant un motif : il faut le prédicat précis (ici mettre le départ en arg)
        	//this.removePercept(agName, Literal.parseLiteral("location"));
        	
        } else if(action.getFunctor().equals("getAnOrder")) {
        	
        	if(this.waitingOrder < 5) {
	        	this.orderId++;
	        	this.waitingOrder++;
	        	String entreeOredred = this.entree[(int) ((this.entree.length - 1) * Math.random())];
	        	String mainCourseOredred = this.mainCourse[(int) ((this.mainCourse.length - 1) * Math.random())];
	        	String dessertOredred = this.dessert[(int) ((this.dessert.length - 1) * Math.random())];
	        	this.logger.log(Level.INFO, "\t" + agName + " <- menu(" + entreeOredred + ", " + mainCourseOredred + ", " + dessertOredred + ")");
	        	this.addPercept(agName, Literal.parseLiteral("isWaiting(entree, " + entreeOredred + ", " + this.orderId + ")"));
	        	this.addPercept(agName, Literal.parseLiteral("isWaiting(mainCourse, " + mainCourseOredred + ", " + this.orderId + ")"));
	        	this.addPercept(agName, Literal.parseLiteral("isWaiting(dessert, " + dessertOredred + ", " + this.orderId + ")"));
        	}
        	
        } else if(action.getFunctor().equals("placeAnOrder")) {
        	
        	this.logger.log(Level.INFO, "le chef s'est enregistré");
        
        } else if(action.getFunctor().equals("cook")) {
        	
        	this.logger.log(Level.INFO, "executing: " + action + ", but not implemented!");
        
        } else if(action.getFunctor().equals("updateAttente")) {
        	
        	this.logger.log(Level.INFO, "executing: " + action + ", but not implemented!");
        	
        } else if(action.getFunctor().equals("serveOrder")) {
        	
        	this.waitingOrder--;
        	
        }
        
        // Slow down execution (useless : use -debug instead)
        /*
        if(Env.tickDuration > 0) {
	        try {
				Thread.sleep(Env.tickDuration);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
        }
        */
		
        return true;
    }

    /**
	 * Called before the end of MAS execution
	 */
    @Override
    public void stop() {
        super.stop();
    }

}

