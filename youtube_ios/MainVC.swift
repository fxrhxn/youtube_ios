//
//  ViewController.swift
//  youtube_ios
//
//  Created by Farhan Rahman on 10/19/17.
//  Copyright © 2017 Farhan Rahman. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UISearchBarDelegate {
    
    //Search bar outlet for youtube vids.
    @IBOutlet weak var youtubeSearch: UISearchBar!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        youtubeSearch.delegate = self;
    }
    
    
    //Search button is clicked.
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
        
        //Query to search for objects.
        let search_query = searchBar.text!
        
        
        //Create a seque that sends the data to another view. 
        performSegue(withIdentifier: "searchSegue", sender: search_query)
        
      
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Segue for the search.
        if (segue.identifier == "searchSegue") {
            
            //Set the destination for the view controller.
            let vc = segue.destination as! VideoVC
            
            //Turn the data from the sender to a boolean string.
            if let data = sender as? String{
                    vc.search_query = data
            }
            
        }

        
    }
    
    

}

