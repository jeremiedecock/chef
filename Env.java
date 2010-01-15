// Environment code for project chef.mas2j

import jason.asSyntax.*;
import jason.environment.*;

import java.util.logging.Logger;

public class Env extends Environment {
	
	private Logger logger = Logger.getLogger(Env.class.getName());
	
	private String chefName;
	
    /** 
	 * Called before the MAS execution with the args informed in .mas2j
	 */
    @Override
    public void init(String[] args) {
		int random = (int) ((10 - 1) * Math.random());
		
		//addPercept(Literal per);  // Ajoute une perception dans l'environement (ie pour tout le monde)
		//addPercept(String agName, Literal arg1); // Ajoute une perception pour l'agent agName
    }

	/**
	 * Execute les actions définies dans les fichiers .asl
	 */
    @Override
    public boolean executeAction(String agName, Structure action) {
        logger.info("executing: " + action);
		
        if(action.getFunctor().equals("informChef")) {
        	this.chefName = agName;
        	logger.info("le chef s'est enregistré");
        	
        } else if(action.getFunctor().equals("cook")) {
        	
        	logger.info("executing: " + action + ", but not implemented!");
        	
        } else if(action.getFunctor().equals("init")) {
        	
        	addPercept(agName, Literal.parseLiteral("location(cuisine)"));
        	
        } else if(action.getFunctor().equals("moveTo")) {
        	
        	System.out.println(agName + " move to " + action.getTerm(0));
        	// on ne peut pas supprimer des percepts suivant un motif : il faut le prédicat précis (ici mettre le départ en arg)
        	//this.removePercept(agName, Literal.parseLiteral("location"));
        	this.addPercept(agName, Literal.parseLiteral("location(" + action.getTerm(0) + ")"));
        	
        } else if(action.getFunctor().equals("passerCommandeClient")) {
        	
        	logger.info("executing: " + action + ", but not implemented!");
        	
        } else if(action.getFunctor().equals("updateAttente")) {
        	
        	logger.info("executing: " + action + ", but not implemented!");
        	
        } else if(action.getFunctor().equals("servirClient")) {
        	
        	logger.info("executing: " + action + ", but not implemented!");
        	
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

