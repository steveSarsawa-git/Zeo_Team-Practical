//
//  WebServices.swift
//  Flicker_Fetching
//
//  Created by Bhavesh's Mac on 11/04/25.
//

import Foundation

/// WebService class responsible for fetching images from the Flickr API.
class WebServices {


    /// Fetches Flickr images from the API.
    ///
    /// - Parameter completion: A closure returning an array of `FlickrItem` on the main thread.

    func fetchImages(completion: @escaping ([FlickrItem]) -> Void) {

        // Validate the base URL
        guard let url = URL(string: ApiManager.Endpoints.publicPhotos) else {
            print("Invalid URL: \(ApiManager.Endpoints.publicPhotos)")
            return
        }

        // Create a data task for the URL
        URLSession.shared.dataTask(with: url) { data, response, error in

            // Handle networking error
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                return
            }

            // Ensure data exists
            guard let data = data else {
                print("No data received.")
                return
            }

            do {
                // Decode the JSON data into FlickrData
                let feed = try JSONDecoder().decode(FlickrData.self, from: data)

                // Return items on the main thread
                DispatchQueue.main.async {
                    completion(feed.items)
                }

            } catch {
                print("Failed to decode JSON: \(error)")
            }

        }.resume()
    }
}
