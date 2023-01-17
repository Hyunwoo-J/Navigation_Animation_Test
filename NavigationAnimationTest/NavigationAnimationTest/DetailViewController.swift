//
//  DetailViewController.swift
//  NavigationAnimationTest
//
//  Created by Hyunwoo Jang on 2023/01/17.
//

import BonMot
import SnapKit
import Then
import UIKit

class DetailViewController: UIViewController {
  
  private let contentView = ContentView()
  
  weak var storedContext: UIViewControllerContextTransitioning?
  
  override func loadView() {
    self.view = self.contentView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
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
      
      self.titleLabel.snp.makeConstraints {
        $0.center.equalToSuperview()
      }
    }
  }
}
