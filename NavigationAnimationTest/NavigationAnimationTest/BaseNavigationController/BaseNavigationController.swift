//
//  BaseNavigationController.swift
//  NavigationAnimationTest
//
//  Created by Hyunwoo Jang on 2023/01/19.
//

import UIKit

protocol NavigationPushPopAnimatable: AnyObject {
  func animationTransition(operation: UINavigationController.Operation) -> UIViewControllerAnimatedTransitioning?
}

class BaseNavigationController: UINavigationController {
  override func viewDidLoad() {
    super.viewDidLoad()
    self.delegate = self
  }
}

extension BaseNavigationController: UINavigationControllerDelegate {
  
  /// 네비게이션 스택에 푸시할 때마다 내비게이션 컨트롤러가 기본 제공 전환을 사용해야 하는지 사용자 지정 전환을 사용해야 하는지 델리게이트에게 묻습니다.
  /// - Parameters:
  ///   - navigationController: 네비게이션 컨트롤러를 구별할 때 사용
  ///   - operation: push or pop
  ///   - fromVC: 현재 화면에 보이는 뷰 컨트롤러
  ///   - toVC: 전환할 뷰 컨트롤러
  func navigationController(
    _ navigationController: UINavigationController,
    animationControllerFor
    operation: UINavigationController.Operation,
    from fromVC: UIViewController,
    to toVC: UIViewController
  ) -> UIViewControllerAnimatedTransitioning? {
    if operation == .push, let animatable = toVC as? NavigationPushPopAnimatable {
      return animatable.animationTransition(operation: operation)
    }
    
    if operation == .pop, let animatable = fromVC as? NavigationPushPopAnimatable {
      return animatable.animationTransition(operation: operation)
    }
    
    return nil
  }
}
