//
//  Animator.swift
//  NavigationAnimationTest
//
//  Created by Hyunwoo Jang on 2023/01/17.
//

import UIKit

public class Animator: NSObject, UIViewControllerAnimatedTransitioning {
  
  /// 애니메이션 지속 시간
  let animationDuration = 1.0
  
  var operation: UINavigationController.Operation
  
  weak var storedContext: UIViewControllerContextTransitioning?
  
    init(operation: UINavigationController.Operation) {
    self.operation = operation
  }
  
  /// 전환이 지속되는 시간을 확인하기 위해 사용됩니다.
  public func transitionDuration(
    using transitionContext: UIViewControllerContextTransitioning?
  ) -> TimeInterval {
    return animationDuration
  }
  
  /// 사용자 지정 전환 애니메이션 코드를 호출합니다.
  public func animateTransition(
    using transitionContext: UIViewControllerContextTransitioning
  ) {
    storedContext = transitionContext
    
    if operation == .push {
      let toVC = transitionContext.viewController(forKey: .to)!
      
      transitionContext.containerView.addSubview(toVC.view)
      toVC.view.frame = transitionContext.finalFrame(for: toVC)
      
      let fadeIn = CABasicAnimation(keyPath: "opacity")
      fadeIn.fromValue = 0.0
      fadeIn.toValue = 1.0
      fadeIn.duration = animationDuration
      fadeIn.fillMode = .forwards
      fadeIn.delegate = self
      
      let fadeLayer : CALayer = toVC.view.layer
      fadeLayer.add(fadeIn, forKey: nil)
      
      toVC.view.layer.add(fadeIn, forKey: nil)
    } else {
      let fromView = transitionContext.view(forKey: .from)!
      let toView = transitionContext.view(forKey: .to)!

      transitionContext.containerView.insertSubview(toView, belowSubview: fromView)
      
      UIView.animate(withDuration: animationDuration, delay: 0.0, options: .curveEaseIn, animations: {
        fromView.alpha = 0.0
      }, completion: { _ in
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
      })
    }
  }
  
  public func animationDidStop(
    _ anim: CAAnimation,
    finished flag: Bool) {
      if let context = storedContext {
        context.completeTransition(!context.transitionWasCancelled)
      }
      
      storedContext = nil
  }
}

extension Animator: CAAnimationDelegate {
  
}
