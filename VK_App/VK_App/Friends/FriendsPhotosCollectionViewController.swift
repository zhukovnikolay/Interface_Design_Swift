//
//  FriendsPhotosCollectionViewController.swift
//  VK_App
//
//  Created by Nikolay Zhukov on 14.05.2020.
//  Copyright © 2020 Nikolay Zhukov. All rights reserved.
//

import UIKit

class FriendsPhotosCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var photos = [UIImage]()
    let vkAPI = VKAPI()
    var id: Int = 0
    let countCells = 2
    let offset: CGFloat = 2

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        vkAPI.getPhotos(token: Session.defaultSession.token, ownerId: id, handler: {result in
//            switch result {
//            case .success(let photos):
//                self.photos = photos
//                self.collectionView.reloadData()
//            case .failure(let error):
//                print(error)
//            }
//        })
        
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCollectionViewCell
        cell.friendPhoto.image = photos[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let frameCV = collectionView.frame
        let widthCell = frameCV.width / CGFloat(countCells)
        let heightCell = widthCell
        let spacing = CGFloat((countCells + 1)) * offset / CGFloat(countCells)
        return CGSize(width: widthCell - spacing, height: heightCell - (offset * 2))
        
    }
    
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        photoIndex = indexPath.row
//    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showFullSizePhoto" else { return }
        let destination = segue.destination as! FullSizePhotoViewController
        let cell: PhotoCollectionViewCell = sender as! PhotoCollectionViewCell
        destination.photos = photos
        destination.selectedPhotoIndex = self.collectionView.indexPath(for: cell)?.row
    }
    
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
