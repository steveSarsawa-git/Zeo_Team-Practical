//
//  ResponseModel.swift
//  Flicker_Fetching
//
//  Created by Bhavesh's Mac on 11/04/25.
//

import Foundation


struct FlickrData: Decodable {
    let items: [FlickrItem]
}

struct FlickrItem: Decodable {
    let title: String
    let media: Media

    struct Media: Decodable {
        let m: String
    }
}
