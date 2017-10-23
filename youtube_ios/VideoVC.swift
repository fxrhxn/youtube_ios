//
//  VideoVC.swift
//  youtube_ios
//
//  Created by Farhan Rahman on 10/19/17.
//  Copyright © 2017 Farhan Rahman. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class VideoVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Query label
    @IBOutlet weak var queryLabel: UILabel!
    
    //Outlet that connects the table for the videos.
    @IBOutlet weak var allVideos: UITableView!
    
    //Query for the search.
    var search_query : String?
    
    //Sample videos to loop from.
    var sample_vids = ["Video 1", "Video Two", "Video 3"]
    
    //Video data array.
    var VideoData: JSON?
    
    // Stringify the Video Data
    var VideoData_Stringed : AnyObject?
    
    
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
                
                let parsed_data = JSON(json)
               
                /* GETS ONE DATA OBJECT. */
             //   print(parsed_data["items"][0])
                
                
                // Video Data
                self.VideoData = parsed_data["items"]
                
                
                //Reload the table view.
                self.allVideos.reloadData()

            }
            
        
//            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
//                print("Data: \(utf8Text)") // original server data as UTF8 string
//            }
        
        
        }
        
        
        
    }
    
    // Function that returns the amount of cells in the application.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if VideoData == nil{
            return 0
        }else{
            return VideoData!.count
        }
       
    }
    
    // Function that gives the number of sections in the application.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Test thumbnail.
        var test_image = UIImage(named: "test_image")
        
        //The identifier for each cell.
        var cellIdentifier = "videoCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? VideoCell  else {
            fatalError("The dequeued cell is not an instance of UITableViewCell")
        }
        
       // let video = sample_vids[indexPath.row]
        
        if(VideoData == nil){
            return cell
        }else{
            
           
            
            
            
            let _id = VideoData![indexPath.row]["id"]["videoId"];
            
            let _title = VideoData![indexPath.row]["title"]
            let _description = VideoData![indexPath.row]["description"]
            let _thumbnail = VideoData![indexPath.row]["snippet"]["thumbnails"]["default"]["url"]
            
        
            
            print(_title)
            
            /* 
             
             {
             "kind" : "youtube#searchResult",
             "id" : {
             "kind" : "youtube#video",
             "videoId" : "wACJG7pNZU0"
             },
             "etag" : "\"cbz3lIQ2N25AfwNr-BdxUVxJ_QY\/npOB4gEWAUK88y7Kuac95EOSav0\"",
             "snippet" : {
             "thumbnails" : {
             "default" : {
             "url" : "https:\/\/i.ytimg.com\/vi\/wACJG7pNZU0\/default.jpg",
             "width" : 120,
             "height" : 90
             },
             "high" : {
             "url" : "https:\/\/i.ytimg.com\/vi\/wACJG7pNZU0\/hqdefault.jpg",
             "width" : 480,
             "height" : 360
             },
             "medium" : {
             "url" : "https:\/\/i.ytimg.com\/vi\/wACJG7pNZU0\/mqdefault.jpg",
             "width" : 320,
             "height" : 180
             }
             },
             "channelId" : "UC3TlLRGt7eEWwXmcHIrfGOw",
             "title" : "HHH Aplica Pedigree a Kofi Kingston en WWE Live Santiago De Chile 2017",
             "publishedAt" : "2017-10-22T21:05:06.000Z",
             "description" : "",
             "liveBroadcastContent" : "none",
             "channelTitle" : "Sport Online HD"
             }
             }
             
             */
            
        
            //Set the video title for each video.
            cell.videoTitle.text = "STRING!"
            
//    
//            let image_url = URL(string : _thumbnail)
//            
//            let image_data = try? Data(contentsOf: image_url)
//            
//            if let imageData = image_data {
//                cell.videoImage.image = UIImage(data: imageData)
//            }
//            

            
            //Set the description for each cell.
            cell.videoDescription.text = "Description for"
            
            return cell
        }
       
    
    }
    

    //Function that turns the JSON into strings.
    func JSONStringify(value: JSON,prettyPrinted:Bool = false) -> String{
        
        let options = prettyPrinted ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions(rawValue: 0)
        
        
        if JSONSerialization.isValidJSONObject(value) {
            
            do{
                let data = try JSONSerialization.data(withJSONObject: value, options: options)
                if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    return string as String
                }
            }catch {
                
                print("error")
                //Access error here
            }
            
        }
        return ""
        
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
