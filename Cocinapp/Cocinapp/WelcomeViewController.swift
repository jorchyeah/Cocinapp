//
//  WelcomeViewController.swift
//  Cocinapp
//
//  Created by mac on 16/01/19.
//  Copyright © 2019 Cocinapp. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    var nameText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

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
