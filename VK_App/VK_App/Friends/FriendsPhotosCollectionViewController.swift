//
//  FriendsPhotosCollectionViewController.swift
//  VK_App
//
//  Created by Nikolay Zhukov on 14.05.2020.
//  Copyright © 2020 Nikolay Zhukov. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class FriendsPhotosCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var photos = [Photo]()
    var photosURLInHighQuality = [String]()
    var photosURLInLowQuality = [String]()
    let vkAPI = VKAPI()
    var id: Int = 0
    let countCells = 2
    let offset: CGFloat = 2

    override func viewDidLoad() {
        super.viewDidLoad()
        
        vkAPI.getPhotos(token: Session.defaultSession.token, ownerId: id, handler: {result in
            switch result {
            case .success(let photos):
                self.photos = photos
                photos.forEach {
                    guard let photoURLInHighQuality = $0.sizes.first(where: {$0.type == "w"})?.url else { return }
                    guard let photoURLInLowQuality = $0.sizes.first(where: {$0.type == "x"})?.url else { return }
                    self.photosURLInLowQuality.append(photoURLInLowQuality)
                    self.photosURLInHighQuality.append(photoURLInHighQuality)
                }
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        })
        
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosURLInLowQuality.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCollectionViewCell
        
        AF.request(photosURLInLowQuality[indexPath.row]).responseImage { response in
            if case .success(let image) = response.result {
                cell.friendPhoto.image = image
            }
        }
//        cell.friendPhoto.image = photos[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let frameCV = collectionView.frame
        let widthCell = frameCV.width / CGFloat(countCells)
        let heightCell = widthCell
        let spacing = CGFloat((countCells + 1)) * offset / CGFloat(countCells)
        return CGSize(width: widthCell - spacing, height: heightCell - (offset * 2))
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showFullSizePhoto" else { return }
        let destination = segue.destination as! FullSizePhotoViewController
        let cell: PhotoCollectionViewCell = sender as! PhotoCollectionViewCell
        destination.photosURLInHighQuality = photosURLInHighQuality
        destination.selectedPhotoIndex = self.collectionView.indexPath(for: cell)?.row
    }

}
