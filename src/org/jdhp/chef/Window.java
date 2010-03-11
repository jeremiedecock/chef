/*
 * Copyright (c) 2009,2010 Jérémie DECOCK <gremy@tuxfamily.org>,
 *                         Antoine DESOLLE <desolle.antoine@gmail.com>
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 * 
 */

package org.jdhp.chef;

import java.awt.GridBagLayout;
import java.awt.GridLayout;
import java.awt.event.WindowEvent;
import java.awt.event.WindowListener;

import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextArea;

public class Window extends JFrame implements WindowListener {

	private JTextArea perceptsArea;
	
	public Window(String title) {
		//super();
		
		this.setTitle(title);
		//this.setResizable(false);

		JPanel panel = new JPanel();
		panel.setLayout(new GridLayout(1,2));
		
        GridBagLayout layout = new GridBagLayout();
        this.getContentPane().setLayout(layout);
        
        panel.add(new JLabel("Percepts :"));
        this.perceptsArea = new JTextArea(20, 20);
        panel.add(this.perceptsArea);
        
        this.addWindowListener(this);
        
		this.getContentPane().add(panel);

		this.pack();
        //this.setSize(this.panel.getSize());

		//Dimension dim = Toolkit.getDefaultToolkit().getScreenSize();
		//this.setLocation(dim.width/2 - this.getWidth()/2, dim.height/2 - this.getHeight()/2);

		this.setVisible(true);
	}

	public void setPercepts(String percepts) {
		this.perceptsArea.setText(String.valueOf(percepts));
	}

	///////////////////////////////////////////////////////////////////////////
	
	
	public void windowActivated(WindowEvent e) { }

	public void windowClosed(WindowEvent e) { }

	public void windowClosing(WindowEvent e) {
		//
	}

	public void windowDeactivated(WindowEvent e) { }

	public void windowDeiconified(WindowEvent e) { }

	public void windowIconified(WindowEvent e) { }

	public void windowOpened(WindowEvent e) { }
	
	
}
