//
//  DetailViewController.swift
//  NavigationAnimationTest
//
//  Created by Hyunwoo Jang on 2023/01/17.
//

import BonMot
import QuartzCore
import RxCocoa
import RxSwift
import SnapKit
import Then
import UIKit

extension DetailViewController: NavigationPushPopAnimatable {
  func animationTransition(
    operation: UINavigationController.Operation
  ) -> UIViewControllerAnimatedTransitioning? {
    return operation == .push ? Animator(operation: .push) : Animator(operation: .pop)
  }
}

class DetailViewController: UIViewController {
  
  public let contentView = ContentView()
  
  private let disposeBag: DisposeBag = .init()
  
  override func loadView() {
    self.view = self.contentView
  }
  
  deinit {
    print("Detail")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.bind()
  }
  
  private func bind() {
    self.bindDismissButton()
  }
  
  private func bindDismissButton() {
    self.contentView.dismissButton.rx.tap
      .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
      .bind(with: self) { this, _ in
        this.navigationController?.popViewController(animated: true)
      }
      .disposed(by: self.disposeBag)
  }
}

extension DetailViewController {
  public class ContentView: UIView {
    
    private let titleLabel = UILabel().then {
      $0.attributedText = "Detail ViewController".styled(
        with: StringStyle(
          .color(.black),
          .font(.boldSystemFont(ofSize: 25))
        )
      )
    }
    
    public let dismissButton = UIButton().then {
      $0.setTitleColor(.white, for: .normal)
      $0.setTitle("닫기", for: .normal)
      $0.backgroundColor = .black
    }
    
    
    public override init(frame: CGRect) {
      super.init(frame: frame)
      self.setup()
    }
    
    public required init?(coder: NSCoder) {
      super.init(coder: coder)
      self.setup()
    }
    
    private func setup() {
      self.backgroundColor = .white
      
      self.addSubview(self.titleLabel)
      self.addSubview(self.dismissButton)
      
      self.titleLabel.snp.makeConstraints {
        $0.center.equalToSuperview()
      }
      
      self.dismissButton.snp.makeConstraints {
        $0.top.equalTo(self.titleLabel.snp.bottom).offset(20)
        $0.centerX.equalToSuperview()
        $0.width.equalTo(200)
        $0.height.equalTo(44)
      }
    }
  }
}
