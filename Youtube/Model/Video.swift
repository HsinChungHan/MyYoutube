//
//  Video.swift
//  Youtube
//
//  Created by 辛忠翰 on 27/11/17.
//  Copyright © 2017 辛忠翰. All rights reserved.
//

import UIKit
import Foundation

class Video: Decodable {
    let thumbnail_image_name: String?
    let title: String?
    let number_of_views: Int?
    let duration: Int?
    let channel: Channel?
}
class Channel: Decodable{
    let name: String?
    let profile_image_name: String?
}

//class Video: Decodable{
//    let thumbnailImgName: String?
//    let title: String?
//    let numberOfViews: NSNumber?
//    let uploadDate: NSDate?
//    let channel: Channel?
//}
//
//class Channel: Decodable{
//    let name: String?
//    let profileImgName: String?
//}

