//
//  InterfaceWithCodeViewController.swift
//  ScrollView
//
//  Created by 김건우 on 11/7/23.
//

import UIKit

class InterfaceWithCodeViewController: UIViewController {

    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let contentView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let titleLabel: UILabel = {
        let v = UILabel()
        v.text = "Hello, World!"
        v.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let spot1ImageView: UIImageView = {
        let v = UIImageView()
        v.image = UIImage(named: "spot1")
        v.contentMode = .scaleAspectFit
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let spot2ImageView: UIImageView = {
        let v = UIImageView()
        v.image = UIImage(named: "spot2")
        v.contentMode = .scaleAspectFit
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let spot3ImageView: UIImageView = {
        let v = UIImageView()
        v.image = UIImage(named: "spot3")
        v.contentMode = .scaleAspectFit
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var stackView: UIStackView = {
        let s = UIStackView(arrangedSubviews: [spot1ImageView, spot2ImageView, spot3ImageView])
        s.axis = .vertical
        s.alignment = .fill
        s.distribution = .fillEqually
        s.spacing = 8
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubViews()
        setupConstraints()
    }
    
    func addSubViews() {
        view.addSubview(scrollView)
        // ⭐️ 스크롤 뷰 위에 contentView를 올리기
        // contentView의 컨텐츠에 따라서 그 크기가 결정되어 스크롤되기 때문에 필요함.
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
        // ⭐️ 수직 스크롤을 위해서 contentView의 너비를 스크롤 뷰의 너비와 똑같이 맞춰야 함.
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            spot1ImageView.widthAnchor.constraint(equalToConstant: 300),
            spot1ImageView.heightAnchor.constraint(equalToConstant: 300),
            spot2ImageView.widthAnchor.constraint(equalToConstant: 300),
            spot2ImageView.heightAnchor.constraint(equalToConstant: 300),
            spot3ImageView.widthAnchor.constraint(equalToConstant: 300),
            spot3ImageView.heightAnchor.constraint(equalToConstant: 300),
        ])
    }

}
