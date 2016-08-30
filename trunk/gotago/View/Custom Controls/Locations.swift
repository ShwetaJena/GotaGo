//
//  Locations.swift
//  Carousel
//
//  Created by Saurabh Chakraborty on 22/07/16.
//  Copyright © 2016 Intelegencia. All rights reserved.
//

import UIKit

class Locations {
    
    var title = ""
    var description = ""
    var numberOfMembers = 0
    var numberOfPosts = 0
    var featuredImage: UIImage!
    
    init(title: String, description: String, featuredImage: UIImage!) {
        
        self.title = title
        self.description = description
        self.featuredImage = featuredImage
        numberOfMembers = 1
        numberOfPosts = 1
        
    }
    
    
    static func createLocations() -> [Locations] {
        
        return[
            Locations(title:"", description: "", featuredImage: UIImage(named:"L1")),
            Locations(title:"", description: "", featuredImage: UIImage(named:"L5")),
            Locations(title:"", description: "", featuredImage: UIImage(named:"L6")),
            Locations(title:"", description: "", featuredImage: UIImage(named:"L7")),
        ]
    }
}
