//
//  Animator.swift
//  NavigationAnimationTest
//
//  Created by Hyunwoo Jang on 2023/01/17.
//

import UIKit

public class Animator
: NSObject,
  UIViewControllerAnimatedTransitioning {
  
  let animationDuration = 2.0
  var operation: UINavigationController.Operation = .push
  
  public func transitionDuration(
    using transitionContext: UIViewControllerContextTransitioning?
  ) -> TimeInterval {
    return animationDuration
  }
  
  public func animateTransition(
    using transitionContext: UIViewControllerContextTransitioning
  ) {
    
  }
}
