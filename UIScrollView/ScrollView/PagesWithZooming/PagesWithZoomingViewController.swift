//
//  PagesWithZoomingViewController.swift
//  ScrollView
//
//  Created by 김건우 on 11/5/23.
//

import UIKit

class PagesWithZoomingViewController: UIViewController {

    @IBOutlet weak var stackContainer: UIStackView!
    @IBOutlet weak var pageCounter: UIPageControl!
    
    var mainScroll: UIScrollView!
    var imageViews: [UIImageView] = []
    var page: Int = 0
    var rotation: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let images = ["spot1", "spot2", "spot3"]
        pageCounter.numberOfPages = images.count
        pageCounter.pageIndicatorTintColor = UIColor.black
        pageCounter.currentPageIndicatorTintColor = UIColor.orange
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        mainScroll = UIScrollView(frame: .zero)
        mainScroll.contentInsetAdjustmentBehavior = .never
        mainScroll.showsHorizontalScrollIndicator = false
        mainScroll.isPagingEnabled = true
        mainScroll.delegate = self
        
        for img in images {
            let childScroll = UIScrollView(frame: .zero)
            childScroll.contentInsetAdjustmentBehavior = .never
            childScroll.minimumZoomScale = 1.0
            childScroll.maximumZoomScale = 4.0
            childScroll.delegate = self
            
            let imgView = UIImageView(frame: .zero)
            imgView.image = UIImage(named: img)
            imgView.contentMode = .scaleAspectFill
            imgView.clipsToBounds = true
            imageViews.append(imgView)
            
            childScroll.addSubview(imgView)
            mainScroll.addSubview(childScroll)
        }
        stackContainer.addArrangedSubview(mainScroll)
        // ⭐️ 뷰에 서브 뷰를 추가만 해놓고 뷰의 크기는 나중에 계산하여 적용함.
        updateSize()
    }
    
    // ⭐️ (회전으로 인해) 뷰의 사이즈가 바뀌기 전에 호출되는 메서드
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        rotation = true
        coordinator.animate { context in
            let scroll = self.imageViews[self.page].superview as! UIScrollView
            scroll.setZoomScale(1.0, animated: true)
            
            self.updateSize()
            self.rotation = false
        }
    }
    
    func updateSize() {
        let scrollWidth = stackContainer.frame.size.width
        let scrollHeight = stackContainer.frame.size.height
        
        var posX: CGFloat = 0.0
        for imgView in imageViews {
            let scroll = imgView.superview as! UIScrollView
            scroll.frame = CGRect(x: posX, y: 0, width: scrollWidth, height: scrollHeight)
            scroll.contentSize = CGSize(width: scrollWidth, height: scrollHeight)
            imgView.frame = CGRect(x: 0, y: 0, width: scrollWidth, height: scrollHeight)
            posX = posX + scrollWidth
        }
        mainScroll.contentSize = CGSize(width: scrollWidth * CGFloat(imageViews.count), height: scrollHeight)
        
        let scrollView = imageViews[page].superview as! UIScrollView
        // ⭐️ 컨텐츠의 원점으로부터 얼만큼 떨어져 있을 건지 설정
        // 기기를 회전시키더라도 현재 페이지를 유지할 수 있도록 해줌.
        mainScroll.contentOffset = CGPoint(x: scrollView.frame.origin.x, y: 0)
    }

}

extension PagesWithZoomingViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageViews[page]
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 기기가 회전되어 뷰가 새로운 사이즈로 업데이트 될 때까지,
        // 현재 페이지를 계산하지 않도록 하기 위함.
        if !rotation {
            let pageWidth = stackContainer.frame.size.width
            let getPage = round(mainScroll.contentOffset.x / pageWidth)
            
            let currentPage = Int(getPage)
            if currentPage != page {
                let scroll = imageViews[page].superview as! UIScrollView
                scroll.setZoomScale(1.0, animated: true)
                page = Int(currentPage)
                pageCounter.currentPage = page
            }
        }
    }
    
}
