//
//  ViewController.swift
//  ScrollView
//
//  Created by 김건우 on 10/10/23.
//

import UIKit

class ViewController: UIViewController {

    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let scrollStackViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let subView1: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 200).isActive = true
        view.backgroundColor = UIColor.blue
        return view
    }()
    
    private let subView2: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 300).isActive = true
        view.backgroundColor = UIColor.cyan
        return view
    }()
    
    private let subView3: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 400).isActive = true
        view.backgroundColor = UIColor.gray
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        setupScrollView()
    }

    private func setupScrollView() {
        let margins = view.layoutMarginsGuide
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(scrollStackViewContainer)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        
//        scrollView.showsVerticalScrollIndicator = false
//        scrollView.indicatorStyle = .black
//        scrollView.refreshControl = UIRefreshControl()
//        scrollView.keyboardDismissMode = .onDrag
        
        scrollStackViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        scrollStackViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        scrollStackViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        scrollStackViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        // ⭐️ UIScrollView에게 스크롤 가능한 콘텐츠 뷰의 크기를 알려주기 위함.
        scrollStackViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        // ⭐️ Horizontal ScrollView를 구현하려면 HeightAnchor를 ScrollView의 Height에 맞추어야 함.
        
        configureContainerView()
    }
    
    private func configureContainerView() {
        scrollStackViewContainer.addArrangedSubview(subView1)
        scrollStackViewContainer.addArrangedSubview(subView2)
        scrollStackViewContainer.addArrangedSubview(subView3)
    }

}

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        print("y의 좌표: \(y)")
    }
    
}

