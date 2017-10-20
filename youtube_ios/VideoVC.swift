//
//  VideoVC.swift
//  youtube_ios
//
//  Created by Farhan Rahman on 10/19/17.
//  Copyright © 2017 Farhan Rahman. All rights reserved.
//

import UIKit
import Alamofire


class VideoVC: UIViewController {
    
    //Query label
    @IBOutlet weak var queryLabel: UILabel!
    
    //Query for the search.
    var search_query : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        queryLabel.text = "Query: \(search_query!)"
        
        // Do any additional setup after loading the view.
    }


    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
