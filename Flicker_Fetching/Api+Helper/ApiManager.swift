//
//  ApiManager.swift
//  Flicker_Fetching
//
//  Created by Bhavesh's Mac on 11/04/25.
//

import Foundation

struct ApiManager{

    static let baseUrl = "https://www.flickr.com/services/feeds"

    struct Endpoints {
        static let publicPhotos = "\(baseUrl)/photos_public.gne?format=json&nojsoncallback=1"
    }
}
