// Environment code for project chef.mas2j

package org.jdhp.chef;

import jason.asSyntax.*;
import jason.environment.*;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map.Entry;
import java.util.logging.Logger;

public class Env extends Environment {
	
	public final static int tickDuration = 1000;   // tick duration in ms
	
	private int orderId, waitingOrder;
	
	private Logger logger = Logger.getLogger(Env.class.getName());
	
	private HashMap<String, String> jobMap;
	
	private HashMap<String, String> positionMap;
	
	private HashMap<String, Window> windowMap;
	
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
    	this.windowMap = new HashMap<String, Window>();
    	
		//int random = (int) ((10 - 1) * Math.random());
		//addPercept(Literal per);  // Ajoute une perception dans l'environement (ie pour tout le monde)
		//addPercept(String agName, Literal arg1); // Ajoute une perception pour l'agent agName
    }

	/**
	 * Execute les actions définies dans les fichiers .asl
	 */
    @Override
    public boolean executeAction(String agName, Structure action) {
        logger.info("[" + agName + "] : " + action);
		
        if(action.getFunctor().equals("register")) {
        	
        	System.out.println(agName + " = " + action.getTerm(0));
        	this.jobMap.put(agName, action.getTerm(0).toString());
        	this.windowMap.put(agName, new Window(agName));
        	
        } else if(action.getFunctor().equals("init")) { // punch in
        	
        	logger.info("Init " + agName + " -> clear percepts and set location");
        	this.clearPercepts(agName);
        	this.positionMap.put(agName, location[0]);
        	this.addPercept(agName, Literal.parseLiteral("location(" + this.positionMap.get(agName) + ")"));
        	
        } else if(action.getFunctor().equals("goto")) {
        	
        	System.out.println(agName + " move from " + this.positionMap.get(agName) + " to " + action.getTerm(0));
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
	        	logger.info("Get an order : " + entreeOredred + ", " + mainCourseOredred + ", " + dessertOredred);
	        	this.addPercept(agName, Literal.parseLiteral("isWaiting(entree, " + entreeOredred + ", " + this.orderId + ")"));
	        	this.addPercept(agName, Literal.parseLiteral("isWaiting(mainCourse, " + mainCourseOredred + ", " + this.orderId + ")"));
	        	this.addPercept(agName, Literal.parseLiteral("isWaiting(dessert, " + dessertOredred + ", " + this.orderId + ")"));
        	}
        	
        } else if(action.getFunctor().equals("placeAnOrder")) {
        	
        	logger.info("le chef s'est enregistré");
        
        } else if(action.getFunctor().equals("cook")) {
        	
        	logger.info("executing: " + action + ", but not implemented!");
        
        } else if(action.getFunctor().equals("updateAttente")) {
        	
        	logger.info("executing: " + action + ", but not implemented!");
        	
        } else if(action.getFunctor().equals("serveOrder")) {
        	
        	this.waitingOrder--;
        	
        }
        
        // Update all agent's window
        for(Entry<String, Window> entry : this.windowMap.entrySet()) {
			String agent  = entry.getKey();
			Window window = entry.getValue();
			
			if((window != null) && (agent != null) && (this.getPercepts(agent) != null)) {
				List<Literal> percepts = this.getPercepts(agent);
				System.out.println(percepts);
				/*
				Iterator<Literal> it = percepts.iterator();
				while(it.hasNext()) {
					System.out.println(it.next().toString());
				}
				//System.out.println(percepts.toString());
				window.setPercepts(this.getPercepts(agent).toString());
				*/
			}
        }
        
        // Slow down execution
        if(Env.tickDuration > 0) {
	        try {
				Thread.sleep(Env.tickDuration);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
        }
		
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

