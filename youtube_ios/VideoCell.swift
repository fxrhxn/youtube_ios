//
//  VideoCell.swift
//  youtube_ios
//
//  Created by Farhan Rahman on 10/23/17.
//  Copyright © 2017 Farhan Rahman. All rights reserved.
//

import UIKit

class VideoCell: UITableViewCell {
    
    // Video Image.
    @IBOutlet weak var videoImage: UIImageView!
    
    // Video Title.
    @IBOutlet weak var videoTitle: UILabel!
    
    // Video Description.
    @IBOutlet weak var videoDescription: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //Do some shit here boiii
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
