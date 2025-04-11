//
//  ImageCollViewCell.swift
//  Flicker_Fetching
//
//  Created by Bhavesh's Mac on 11/04/25.
//

import Foundation
import UIKit


class ImageCollViewCell: UICollectionViewCell {

    static let id = "ImageCollViewCell"


    //MARK: - Outlets
    @IBOutlet weak var imgView: UIImageView?
    @IBOutlet weak var innerLoader: UIActivityIndicatorView?



    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()

        self.imgView?.layer.cornerRadius = 6
    }



    //MARK: - Custom Access Methods

    func configure(with urlString: String) {
        if let cachedImage = ImageCache.shared.image(for: urlString) {
            self.innerLoader?.stopAnimating()
            self.imgView?.image = cachedImage
        } else {
            guard let url = URL(string: urlString) else { return }

            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    ImageCache.shared.save(image: image, for: urlString)
                    DispatchQueue.main.async {
                        self.innerLoader?.stopAnimating()
                        self.imgView?.image = image
                    }
                }
            }.resume()
        }
    }
}
