//
//  MasterViewController.swift
//  NavigationAnimationTest
//
//  Created by Hyunwoo Jang on 2023/01/17.
//

import RxCocoa
import RxSwift
import SnapKit
import Then
import UIKit

class MasterViewController: UIViewController {
  
  private let contentView = ContentView()
  
  private let disposeBag: DisposeBag = .init()
  
  override func loadView() {
    self.view = self.contentView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.bind()
  }
  
  private func bind() {
    self.bindNextButton()
  }
  
  private func bindNextButton() {
    self.contentView.nextButton.rx.tap
      .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
      .bind(with: self) { this, _ in
        let detailVC = DetailViewController()
        this.navigationController?.pushViewController(detailVC, animated: true)
      }
      .disposed(by: self.disposeBag)
  }
}

extension MasterViewController {
  public class ContentView: UIView {
    
    public let nextButton = UIButton().then {
      $0.backgroundColor = .cyan
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
      
      self.addSubview(self.nextButton)
      
      self.nextButton.snp.makeConstraints {
        $0.size.equalTo(80)
        $0.center.equalToSuperview()
      }
    }
  }
}


