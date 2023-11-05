//
//  ZoomingViewController.swift
//  ScrollView
//
//  Created by 김건우 on 11/5/23.
//

import UIKit

class ZoomingViewController: UIViewController {

    @IBOutlet weak var stackContainer: UIStackView!
    var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ⭐️ 뷰가 로드 될 때,
        // ⭐️ Update Cycle 동안에 스크롤 뷰의 width와 height값이 제대로 업데이트되어 있지 않을 가능성이 있기 때문에,
        // ⭐️ 아래 메서드를 호출해 우리가 필요한 시점에 강제로 레이아웃을 업데이트하도록 함.
        // 다음 Update Cycle에 레이아웃을 업데이트하도록 함.
        view.setNeedsLayout()
        // 지금 즉시 레이아웃을 업데이트하도록 함.
        view.layoutIfNeeded()
        
        imgView = UIImageView(image: UIImage(named: "doll"))
        let imageWidth = imgView.frame.size.width
        let imageHeight = imgView.frame.size.height
        
        let mainScroll = UIScrollView(frame: .zero)
        mainScroll.contentSize = CGSize(width: imageWidth, height: imageHeight)
        mainScroll.contentInsetAdjustmentBehavior = .never
        mainScroll.delegate = self
        mainScroll.addSubview(imgView)
        
        let scrollWidth = stackContainer.frame.size.width
        let scrollHeight = stackContainer.frame.size.height
        let minScale = min(scrollWidth / imageWidth, scrollHeight / imageHeight)
        let maxScale = max(minScale * 4.0, 1.0)
        
        mainScroll.minimumZoomScale = minScale
        mainScroll.maximumZoomScale = maxScale
        
        stackContainer.addArrangedSubview(mainScroll)
    }

}

extension ZoomingViewController: UIScrollViewDelegate {
    
    // ⭐️ 어느 뷰를 줌인・아웃을 할 건지 결정하는 델리게이트 메서드
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imgView
    }
    
}
