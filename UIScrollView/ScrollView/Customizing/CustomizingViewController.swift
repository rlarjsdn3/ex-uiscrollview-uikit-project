//
//  CustomizingViewController.swift
//  ScrollView
//
//  Created by 김건우 on 11/5/23.
//

import UIKit

class CustomizingViewController: UIViewController {

    @IBOutlet weak var stackContainer: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imgView = UIImageView(image: UIImage(named: "doll"))
        let imgWidth = imgView.frame.size.width
        let imgHeight = imgView.frame.size.height
        
        let mainScroll = UIScrollView(frame: .zero)
        // ⭐️ 컨텐츠의 크기를 설정
        mainScroll.contentSize = CGSize(width: imgWidth, height: imgHeight)
        // ⭐️ 컨텐츠의 Safe Area 오프셋을 설정
        mainScroll.contentInsetAdjustmentBehavior = .never
//        mainScroll.showsVerticalScrollIndicator = false
//        mainScroll.showsHorizontalScrollIndicator = true
//        mainScroll.alwaysBounceVertical = false
//        mainScroll.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0)
//        mainScroll.contentOffset = CGPoint(x: 50, y: 50)
        mainScroll.addSubview(imgView)
        
        let logoView = UIImageView(image: UIImage(named: "logo"))
        logoView.translatesAutoresizingMaskIntoConstraints = false
        mainScroll.addSubview(logoView)
        
        // ⭐️ frameLayoutGuide: 스크롤 뷰의 프레임을 나타냄.
        // ⭐️ contentLayoutGuide: (스크롤 뷰 속) 컨텐츠의 프레임을 나타냄.
        logoView.topAnchor.constraint(equalTo: mainScroll.frameLayoutGuide.topAnchor, constant: 25).isActive = true
        logoView.leadingAnchor.constraint(equalTo: mainScroll.frameLayoutGuide.leadingAnchor, constant: 25).isActive = true
        
        // ⭐️ 스택 뷰 안에 스크롤 뷰를 집어넣는 이유는
        // 스크롤 뷰에 별도 제약 조건을 설정해주지 않아도 된다는 데 있음.
        stackContainer.addArrangedSubview(mainScroll)
    }

}
