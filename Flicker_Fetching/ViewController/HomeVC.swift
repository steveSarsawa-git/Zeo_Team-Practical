//
//  HomeVC.swift
//  Flicker_Fetching
//
//  Created by Bhavesh's Mac on 11/04/25.
//

import Foundation
import UIKit



class HomeVC: UIViewController {


    //MARK: - Variables
    private var images: [FlickrItem] = []
    let webService = WebServices()

    //MARK: - Outlets
    @IBOutlet weak var collViewImageGrid: UICollectionView?
    @IBOutlet weak var loader: UIActivityIndicatorView?


    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }

}


//MARK: - Class setUp and Layout
extension HomeVC {

    func setLayout(){

        setUpCollectionView()

        webService.fetchImages { [weak self] data in
            self?.loader?.stopAnimating()
            self?.images = data
            self?.collViewImageGrid?.reloadData()
        }

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        collViewImageGrid?.refreshControl = refreshControl
    }

    /// Refresh Data is responsible to Data refresh from pull to refresh
    @objc private func refreshData() {

        webService.fetchImages { [weak self] data in
            DispatchQueue.main.async {
                self?.images = data
                self?.collViewImageGrid?.reloadData()
                self?.collViewImageGrid?.refreshControl?.endRefreshing()
            }
        }
    }
}


//MARK: - UICollectionView DataSource

extension HomeVC: UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollViewCell.id, for: indexPath) as? ImageCollViewCell else { return ImageCollViewCell()}

        let imageUrl = images[indexPath.item].media.m
        cell.configure(with: imageUrl)

        return cell
    }
}

//MARK: - UICollectionView SetUp + Delegate

extension HomeVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func setUpCollectionView(){

        self.collViewImageGrid?.setCollectionView(ImageCollViewCell.id, target: self)

    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((self.collViewImageGrid?.frame.size.width ?? (UIScreen.main.bounds.width - 60)) / 2) - 5

        let height = width + 30
        return CGSizeMake(width, height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }

}
