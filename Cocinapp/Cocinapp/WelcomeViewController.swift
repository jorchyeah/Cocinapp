//
//  WelcomeViewController.swift
//  Cocinapp
//
//  Created by mac on 16/01/19.
//  Copyright © 2019 Cocinapp. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    var nameText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //métodos para el manejo de viewController
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func done(sender: AnyObject) {
        
        self.nameText = textField.text!
        
        performSegueWithIdentifier("name", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let vc = segue.destinationViewController as? BusquedaTableViewController
        
          do {
            
            vc!.finalName = self.nameText }
        
        catch {
            
            print("error")
        }
    }
}
