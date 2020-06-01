//
//  FullSizePhotoViewController.swift
//  VK_App
//
//  Created by Nikolay Zhukov on 31.05.2020.
//  Copyright © 2020 Nikolay Zhukov. All rights reserved.
//

import UIKit

enum PanDirection {
    case unknown
    case left
    case right
}

class FullSizePhotoViewController: UIViewController {

    @IBOutlet weak var firstPhoto: UIImageView!
    @IBOutlet weak var nextPhoto: UIImageView!
    
    var photos = [UIImage]()
    var selectedPhotoIndex: Int!
    
    private let transformDecrease = CGAffineTransform(scaleX: 0.9, y: 0.9)
    private let transformZero = CGAffineTransform(scaleX: 0, y: 0)
    private var panGesture: UIPanGestureRecognizer!
    private var currentPanDirection: PanDirection = .unknown
    private weak var currentImageView: UIImageView!
    private weak var nextImageView: UIImageView!
    
    private var nextPhotoIndex: Int {
        var photoIndex = 0
        if currentPanDirection == .unknown || currentPanDirection == .left {
            photoIndex = selectedPhotoIndex + 1
            photoIndex = min(photoIndex, photos.count - 1)
        } else if currentPanDirection == .right {
            photoIndex = selectedPhotoIndex - 1
            photoIndex = max(photoIndex, 0)
        }
        return photoIndex
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()

    }
    
    private func configureViewController() {
        currentImageView = firstPhoto
        currentImageView.isUserInteractionEnabled = true
        nextImageView = nextPhoto
        nextImageView.isUserInteractionEnabled = true
        
        nextImageView.alpha = 0
        nextImageView.transform = transformZero
        
        currentImageView.image = photos[selectedPhotoIndex]
        nextImageView.image = photos[nextPhotoIndex]
        
        if photos.count > 1 {
            panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
            panGesture.minimumNumberOfTouches = 1
            currentImageView.addGestureRecognizer(panGesture)
        }
    }
    
    @objc private func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            startPhotoTransformAnimation(transformDecrease)
        case .changed:
            let translation = recognizer.translation(in: currentImageView)
            currentPanDirection = translation.x > 0 ? .right : .left
            animatePhotoImageViewChanged(with: translation)
        case .ended:
            animatePhotoImageViewEnd()
//        case .cancelled:
//            currentImageView.center.x = self.view.center.x
//        case .failed:
//            <#code#>
        default: return
        }
    }
    
    private func startPhotoTransformAnimation(_ transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.2) {
            self.currentImageView.transform = transform
        }
    }
    
    private func animatePhotoImageViewChanged(with translation: CGPoint) {
        currentImageView.transform = CGAffineTransform(translationX: translation.x, y: 0).concatenating(transformDecrease)
    }
    
    private func animatePhotoImageViewEnd() {
        if currentPanDirection == .left {
            let isLastPhoto = selectedPhotoIndex == photos.count - 1
            if currentImageView.frame.maxX < view.center.x - 30 && !isLastPhoto {
                photoSwapping(direction: .left)
            } else {
                startPhotoTransformAnimation(.identity)
            }
        } else if currentPanDirection == .right {
            let isLastPhoto = selectedPhotoIndex == 0
            if currentImageView.frame.minX > view.center.x + 30 && !isLastPhoto {
                photoSwapping(direction: .right)
            } else {
                startPhotoTransformAnimation(.identity)
            }
        }
    }
    
    private func photoSwapping(direction: PanDirection) {
        self.nextImageView.image = photos[nextPhotoIndex]
        
        switch direction {
        case .left:
//            self.nextImageView.center.x = self.view.frame.maxX
            UIView.animate(withDuration: 0.4, animations: {
                self.currentImageView.alpha = 0
                self.nextImageView.alpha = 1
                self.nextImageView.transform = .identity
//                self.nextImageView.center.x = self.view.center.x
            }, completion: { _ in
                self.reconfigureImages()
            })
        case .right:
//            self.nextImageView.center.x = self.view.frame.minX
            UIView.animate(withDuration: 0.4, animations: {
                self.currentImageView.alpha = 0
                self.nextImageView.alpha = 1
                self.nextImageView.transform = .identity
//                self.nextImageView.center.x = self.view.center.x
            }, completion: { _ in
                self.reconfigureImages()
            })
        default: return
        }
    }
    
    private func reconfigureImages() {
        selectedPhotoIndex = nextPhotoIndex
        
        currentImageView.transform = transformZero
//        currentImageView.alpha = 0
        currentImageView.removeGestureRecognizer(panGesture)
        nextImageView.addGestureRecognizer(panGesture)
        
        if currentImageView == firstPhoto {
            currentImageView = nextPhoto
            nextImageView = firstPhoto
        } else if currentImageView == nextPhoto {
            currentImageView = firstPhoto
            nextImageView = nextPhoto
        }
    }


}
