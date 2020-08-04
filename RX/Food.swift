//
//  Food.swift
//  RX
//
//  Created by Павел on 7/29/20.
//  Copyright © 2020 Павел. All rights reserved.
//

import Foundation
import UIKit

struct Food{
    let name: String
    let flickrID: String
    var image: UIImage?
    
    init(name: String, flickrID: String){
        self.name = name
        self.flickrID = flickrID
        image = UIImage(named: flickrID)
    }
}

extension Food: CustomStringConvertible{
    var description: String{
        return "\(name): flickr.com/\(flickrID)"
    }
}
