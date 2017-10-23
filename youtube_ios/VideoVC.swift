//
//  VideoVC.swift
//  youtube_ios
//
//  Created by Farhan Rahman on 10/19/17.
//  Copyright © 2017 Farhan Rahman. All rights reserved.
//

import UIKit
import Alamofire


class VideoTableViewCell : UITableViewCell {
    
    
    
}

class VideoVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Query label
    @IBOutlet weak var queryLabel: UILabel!
    
    //Outlet that connects the table for the videos.
    @IBOutlet weak var allVideos: UITableView!
    
    //Query for the search.
    var search_query : String?
    
    //Sample videos to loop from.
    var sample_vids = ["Video 1", "Video Two", "Video 3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Make the table delegate itself to this class.
        allVideos.delegate = self
        
        // Tables datasource goes here.
        allVideos.dataSource = self
        
        var API_KEY = "AIzaSyCjQGG6FSax58c2VZsDNducwsswZCz0MNM"
        
        var base_url = "https://www.googleapis.com/youtube/v3"
        var search_endpoint = "/search?&q=\(search_query!)&type=video&key=\(API_KEY)&part=snippet"
        
        var full_url = base_url + search_endpoint
        
        
        
        //Change the query label text.
        queryLabel.text = "Query: \(search_query!)"
        
        
        Alamofire.request(full_url).responseJSON { response in
           
            
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
        
//            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
//                print("Data: \(utf8Text)") // original server data as UTF8 string
//            }
        
        
        }
        
        
        
    }
    
    // Function that returns the amount of cells in the application.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sample_vids.count
    }
    
    // Function that gives the number of sections in the application.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
// OLD FUNCTION
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cellIdentifier = "videoCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? UITableViewCell  else {
            fatalError("The dequeued cell is not an instance of UITableViewCell")
        }
        
        let meal = sample_vids[indexPath.row]

        print(cell)
        return cell
    
    }
    


    
//    //MARK: - Tableview Delegate & Datasource
//    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int
//    {
//        return 10
//    }
//    
//    
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int
//    {
//        return 1
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
//    {
//        
//        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "MyTestCell")
//        return cell
//    }
//    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
//    {
//        
//    }


    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
