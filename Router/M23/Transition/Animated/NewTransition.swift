//
//  NewTransition.swift
//  M23
//
//  Created by Nor1 on 17.06.2022.
//

import UIKit

final class NewTransition: NSObject, UIViewControllerAnimatedTransitioning, AnimatedTransitionReady{
    var isPresenting: Bool = true
    let imageViewStop = UIImageView(image: UIImage(named: "stop"))
    let imageViewContinue = UIImageView(image: UIImage(named: "continue-button"))

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.5
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresenting {
            present(using: transitionContext)
        } else {
            dismiss(using: transitionContext)
        }
    }

    private func present(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.view(forKey: .to) else { return }
        let containerView = transitionContext.containerView
        toView.alpha = 0.0
        containerView.addSubview(toView)
        makeStop(view: toView)
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            toView.alpha = 1.0
            self.imageViewStop.alpha = 0.0
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }

    private func dismiss(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        makeContinue(view: fromView)
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            fromView.alpha = 0.0
            self.imageViewContinue.alpha = 0.7
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })

    }
    
    private func makeStop(view: UIView){
        view.addSubview(imageViewStop)
        imageViewStop.translatesAutoresizingMaskIntoConstraints = false
        imageViewStop.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageViewStop.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageViewStop.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        imageViewStop.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    private func makeContinue(view: UIView){
        view.addSubview(imageViewContinue)
        imageViewContinue.translatesAutoresizingMaskIntoConstraints = false
        imageViewContinue.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageViewContinue.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageViewContinue.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        imageViewContinue.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
}
