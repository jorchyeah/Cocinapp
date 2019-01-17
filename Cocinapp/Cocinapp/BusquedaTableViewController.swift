//
//  BusquedaTableViewController.swift
//  Cocinapp
//
//  Created by mac on 16/01/19.
//  Copyright © 2019 Cocinapp. All rights reserved.
//

import UIKit

class BusquedaTableViewController: UITableViewController {
    
    @IBOutlet var myTableView: UITableView!
    
    @IBAction func back(sender: AnyObject) {
        
        performSegueWithIdentifier("return", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        _ = segue.destinationViewController as? WelcomeViewController
        
    }
    
    var finalName = ""
    
    var tableViewDataSource = [RecipesInfo]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let urlString = "http://www.recipepuppy.com/api/?i=" + finalName
        
        let session = NSURLSession.sharedSession()
        
        let recetaUrl = NSURL(string: urlString)
        
        let task = session.dataTaskWithURL(recetaUrl!){
            (data, response, error) -> Void in
            
            
            if error != nil {
                print(error?.localizedDescription)
            }
                
            else {
                
                do {
                    let object = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                    
                    if let jsonData = object as? [String: AnyObject] {
                        self.readJSON(jsonData)
                    }
                    
                } catch let jsonError as NSError {
                    
                    print(jsonError.localizedDescription)
                }
                
            }
            
        }
        
        task.resume()

    }

    
    override func tableView( tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath ) -> CGFloat {
        
        return 210
    }
    
    override func tableView( tableView: UITableView, numberOfRowsInSection section: Int ) -> Int {
        
        return tableViewDataSource.count
    }
    
override     
    func tableView( tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath ) -> UITableViewCell {
        
        let myCell = tableView.dequeueReusableCellWithIdentifier("reuseCell", forIndexPath: indexPath)
        
        let myImageView = myCell.viewWithTag(11) as! UIImageView
        
        let myTitleLabel = myCell.viewWithTag(12) as! UILabel
        
        let myIngredientLabel = myCell.viewWithTag(13) as! UILabel
        
        let myIngredientLabel1 = myCell.viewWithTag(15) as! UILabel
        
        //let myLinkLabel = myCell.viewWithTag(14) as! UILabel
        
        myTitleLabel.text = "Nombre: " + tableViewDataSource[indexPath.row].title
        
        myIngredientLabel.text = tableViewDataSource[indexPath.row].ingredients
        
        myIngredientLabel1.text = "Ingredientes: "
        
        //myLinkLabel.text = tableViewDataSource[indexPath.row].href
        
        let myUrl = tableViewDataSource[indexPath.row].thumbnail
        
        loadImage(myUrl, to: myImageView)
        
        return myCell
        
    }
    
    func readJSON(object: [String: AnyObject]) {
        
        var myRecipes = RecipesInfo()
        
        guard
            
            let title = object["title"] as? String,
            
            let href = object["href"] as? String,
            
            let version = object["version"] as? Float
            
            else {
                
                return
        }
        
        _ = "version \(version) " + title + " " + href
        
        if let myResults = object["results"] as? [[String: AnyObject]] {
            
            var titles: [String]
            
            var ingredients: [String]
            
            var thumbnails: [String]
            
            var hrefs: [String]
            
            titles = []
            
            ingredients = []
            
            thumbnails = []
            
            hrefs = []
            
            for value in myResults {
                
                if let myTitle = value["title"] as? String{
                    
                    titles.append(myTitle)
                    
                    myRecipes.title =  myTitle
                    
                }
                
                if let myIngredients = value["ingredients"] as? String{
                    
                    ingredients.append(myIngredients)
                    
                    myRecipes.ingredients =  myIngredients
                }
                
                
                if let myHref = value["href"] as? String {
                    
                    hrefs.append(myHref)
                    
                    myRecipes.href = myHref
                }
                
                if let myThumbnail = value["thumbnail"] as? String {
                    
                    thumbnails.append(myThumbnail)
                    
                    myRecipes.thumbnail = myThumbnail
                }
                
                self.tableViewDataSource.append(myRecipes)
            }
            
            dump (self.tableViewDataSource)
            
            dispatch_async(dispatch_get_main_queue()) {
                
                self.myTableView.reloadData()
            }
            
        }
        
    }
    
    func loadImage(url: String, to imageView: UIImageView) {
        
        let url = NSURL(string: url)
        
        NSURLSession.sharedSession().dataTaskWithURL(url!){
            (data, response, error) -> Void in
            
            guard let data = data
                
                else {
                    
                    return
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                
                imageView.image = UIImage(data: data)
            }
            
            }.resume()
    }
    
}
