//
//  PagesViewController.swift
//  ScrollView
//
//  Created by 김건우 on 11/5/23.
//

import UIKit

class PagesViewController: UIViewController {

    @IBOutlet weak var stackContainer: UIStackView!
    @IBOutlet weak var pageCounter: UIPageControl!
    
    var mainScroll: UIScrollView!
    var page: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let images = ["spot1", "spot2", "spot3"]
        pageCounter.numberOfPages = images.count
        pageCounter.pageIndicatorTintColor = UIColor.black
        pageCounter.currentPageIndicatorTintColor = UIColor.systemMint
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
        let scrollWidth = stackContainer.frame.size.width
        let scrollHeight = stackContainer.frame.size.height - 300
        
        mainScroll = UIScrollView(frame: .zero)
        mainScroll.contentSize = CGSize(width: scrollWidth * CGFloat(images.count), height: scrollHeight)
        mainScroll.contentInsetAdjustmentBehavior = .never
        mainScroll.showsHorizontalScrollIndicator = false
        // ⭐️ 컨텐츠를 페이징할 지 말지 결정
        mainScroll.isPagingEnabled = true
        mainScroll.delegate = self
        
        var posX: CGFloat = 0.0
        for img in images {
            let imageView = UIImageView(frame: CGRect(x: posX, y: 0, width: scrollWidth, height: scrollHeight))
            imageView.image = UIImage(named: img)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            
            mainScroll.addSubview(imageView)
            posX = posX + scrollWidth
        }
        stackContainer.addArrangedSubview(mainScroll)
    }

}

extension PagesViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = stackContainer.frame.size.width
        let getPage = round(scrollView.contentOffset.x / pageWidth)
        let currentPage = Int(getPage)
        
        page = currentPage
        pageCounter.currentPage = page
    }
    
}
