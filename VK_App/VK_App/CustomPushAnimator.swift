//
//  CustomPushAnimator.swift
//  VK_App
//
//  Created by Nikolay Zhukov on 04.06.2020.
//  Copyright © 2020 Nikolay Zhukov. All rights reserved.
//

import UIKit

final class CustomPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
 
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from) else { return }
        guard let destination = transitionContext.viewController(forKey: .to) else { return }
        
        transitionContext.containerView.addSubview(destination.view)
        destination.view.frame = source.view.frame
        destination.view.layer.position = .zero
        destination.view.layer.anchorPoint = .zero
        source.view.layer.anchorPoint = .zero
        source.view.layer.position = .zero
        destination.view.transform = CGAffineTransform(rotationAngle: -.pi/2)
        
        UIView.animate(withDuration: 0.6,
                       animations: {
                        destination.view.transform = .identity
                        source.view.transform = CGAffineTransform(rotationAngle: .pi/2)
        },
                       completion: { finished in
                           if finished && !transitionContext.transitionWasCancelled {
                               source.view.transform = .identity
                           }
                           transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
                       })
        
    }
    
    
}

final class CustomPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
 
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from) else { return }
        guard let destination = transitionContext.viewController(forKey: .to) else { return }
        
        transitionContext.containerView.addSubview(destination.view)
        destination.view.frame = source.view.frame
        destination.view.layer.position = .zero
        destination.view.layer.anchorPoint = .zero
        source.view.layer.anchorPoint = .zero
        source.view.layer.position = .zero
        destination.view.transform = CGAffineTransform(rotationAngle: .pi/2)
        
        UIView.animate(withDuration: 0.6,
                       animations: {
                        destination.view.transform = .identity
                        source.view.transform = CGAffineTransform(rotationAngle: -.pi/2)
        },
                       completion: { finished in
                           if finished && !transitionContext.transitionWasCancelled {
                               source.removeFromParent()
                           } else if transitionContext.transitionWasCancelled {
                            destination.view.transform = .identity
                        }
                            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
                       })
        
    }
    
    
}

class CustomInteractiveTransition: UIPercentDrivenInteractiveTransition {
    
    var hasStarted: Bool = false
    var shouldFinish: Bool = false

}

class CustomNavigationController: UINavigationController {
    
    let interactiveTransition = CustomInteractiveTransition()
    private let animator = CustomPushAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
        let screenEdgeRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleScreenEdgeGesture(_:)))
        screenEdgeRecognizer.edges = .left
        view.addGestureRecognizer(screenEdgeRecognizer)

    }
    
    func navigationController(_ navigationController: UINavigationController,
                              interactionControllerFor animationController: UIViewControllerAnimatedTransitioning)
                              -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition.hasStarted ? interactiveTransition : nil
    }
    
    @objc func handleScreenEdgeGesture(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            // Пользователь начал тянуть - стартуем pop-анимацию, и выставляем флаг hasStarted
            interactiveTransition.hasStarted = true
            self.popViewController(animated: true)
            
        case .changed:
            // Пользователь продолжает тянуть
            // рассчитываем размер экрана
            guard let width = recognizer.view?.bounds.width else {
                interactiveTransition.hasStarted = false
                interactiveTransition.cancel()
                return
            }
            // рассчитываем длину перемещения пальца
            let translation = recognizer.translation(in: recognizer.view)
            // рассчитываем процент перемещения пальца относительно размера экрана
            let relativeTranslation = translation.x / width
            let progress = max(0, min(1, relativeTranslation))
            
            // выставляем соответствующий прогресс интерактивной анимации
            interactiveTransition.update(progress)
            interactiveTransition.shouldFinish = progress > 0.35
            
        case .ended:
            // Завершаем анимацию в зависимости от пройденного прогресса
            interactiveTransition.hasStarted = false
            interactiveTransition.shouldFinish ? interactiveTransition.finish() : interactiveTransition.cancel()
            
        case .cancelled:
            interactiveTransition.hasStarted = false
            interactiveTransition.cancel()
            
        default:
            break
        }
    }

    
}

extension CustomNavigationController: UINavigationControllerDelegate {
    
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController)
                              -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return CustomPushAnimator()
        } else if operation == .pop {
            return CustomPopAnimator()
        }
        return nil
    }

}

extension CustomNavigationController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animator
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animator
    }
}
