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
    
    
    //Web View for the video.
    @IBOutlet weak var videoWebView: UIWebView!
    
    //Query label
    @IBOutlet weak var queryLabel: UILabel!
    
    //Outlet that connects the table for the videos.
    @IBOutlet weak var allVideos: UITableView!
    
    //View for the video.
    @IBOutlet var videoView: UIView!
    
    //Outlet for the blur effect.
    @IBOutlet weak var blurEffect: UIVisualEffectView!
    
    //Effect variable.
    var effect : UIVisualEffect!
    
    //Query for the search.
    var search_query : String?
    
    //Sample videos to loop from.
    var sample_vids = ["Video 1", "Video Two", "Video 3"]
    
    //Video data array.
    var VideoData : JSON?
    
    // Video Count.
    var VideoCount : Int?
    
    // Stringify the Video Data
    var VideoData_Stringed : AnyObject?
    
    // Query when the back button is pressed after a video.
    var Return_query : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Disable the effect of the blur.
        effect = blurEffect.effect
        //blurEffect.effect = nil
        blurEffect.isHidden = true
        
      // blurEffect.removeFromSuperview()
        
        
        
        //Make the table delegate itself to this class.
        allVideos.delegate = self
        
        // Tables datasource goes here.
        allVideos.dataSource = self
        
        var API_KEY = "AIzaSyCjQGG6FSax58c2VZsDNducwsswZCz0MNM"
        
        var base_url = "https://www.googleapis.com/youtube/v3"
        var search_endpoint = "/search?&q=\(search_query!)&type=video&key=\(API_KEY)&part=snippet&maxResults=50"
        
        var full_url = base_url + search_endpoint
        
        
        //Change the query label text.
        queryLabel.text = "Query: \(search_query!)"
        
        
        Alamofire.request(full_url.addingPercentEncoding(withAllowedCharacters:  NSCharacterSet.urlQueryAllowed )!).responseJSON { response in
           
            
            
            if let rendered_json = response.result.value {
                
                
                let parsed_data = JSON(rendered_json)
               
                
                /* GETS ONE DATA OBJECT. */
             //   print(parsed_data["items"][0])
                
                
                // Video Data
                self.VideoData = parsed_data["items"]
                self.VideoCount = parsed_data["items"].count
                
            
                
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
            return VideoCount!
        }
       
    }
    
    // Function that gives the number of sections in the application.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    //Function for selecting a row.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(VideoData == nil){
            return
        }else{
            
            //Retrieve the video title and ID.
            let _title = VideoData![indexPath.row]["snippet"]["title"]
            let _video_id = VideoData![indexPath.row]["id"]["videoId"]
            
            
            // Turn all of the json into strings.
            if let title = _title.string {
                
                if let video_id = _video_id.string{
            
                    //Function that animates a video.
                    animateVid(id: video_id, title : title)
                    
                }
            }
            
           
        }
    
        
    }
    
    //Function to render each cell.
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
            
           
            
        // Data that we get from Youtube.
            let _id = VideoData![indexPath.row]["id"]["videoId"];
            let _title = VideoData![indexPath.row]["snippet"]["title"]
            let _description = VideoData![indexPath.row]["snippet"]["description"]
            let _thumbnail = VideoData![indexPath.row]["snippet"]["thumbnails"]["default"]["url"]
            
            

            //Set the title.
            if let title = _title.string {
                
                
                //Set the video title for each video.
                cell.videoTitle.text = title
                
            }
          
            
            //Set the description.
            if let description = _description.string{
                
                cell.videoDescription.text = description
                
            }
            
            
            //Set the image
            if let thumbnail = _thumbnail.string{
            
                let image_url = URL(string : thumbnail)!
                
                let image_data = try? Data(contentsOf: image_url)
                
                if let imageData = image_data {
                    cell.videoImage.image = UIImage(data: imageData)
                }
            }
            
            
            /*
             Data that gets returned boiiiii
             
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
            
        
    
            // Return dis
            return cell
        }
       
    
    }
    
    // Function that animates a popover video.
    func animateVid(id : String = "Test", title : String = "Test"){
        
        let youtube_url = "https://www.youtube.com/embed/\(id)"
        
        let url = NSURL(string: youtube_url);
        let request = NSURLRequest(url: url! as URL);
        videoWebView.loadRequest(request as URLRequest);
        
        //Add the video view.
        self.view.addSubview(videoView)
        videoView.center = self.view.center
        
        //Stylistic changes to the video view.
        videoView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        videoView.alpha = 0
        
        //Animation so shit looks cool.
        UIView.animate(withDuration: 0.4) {
            self.blurEffect.isHidden = false
            self.videoView.alpha = 1
            self.videoView.transform = CGAffineTransform.identity
        }
        
        
    }
    
    //Function that removes a popover video.
    func removeVid(){
        UIView.animate(withDuration: 0.3, animations: {
            self.videoView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.videoView.alpha = 0
            
            self.blurEffect.isHidden = true
            
        }) { (success:Bool) in
            self.videoView.removeFromSuperview()
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
    
    
    //Close Video Button
    @IBAction func closeVideo(_ sender: Any) {
        
        //Function that removes the video.
        removeVid()
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
