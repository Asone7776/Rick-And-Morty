//
//  RMNoSearchResultView.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 03/04/23.
//

import UIKit

final class RMNoSearchResultView: UIView {
    
    private let viewModel = RMNoSearchResultViewViewModel();
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20,weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = viewModel.title
        return label
    }();
    
    lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 60))
        imageView.image = UIImage(systemName: viewModel.imageName,withConfiguration: config)
        imageView.tintColor = .label
        return imageView
    }();
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func show(){
        isHidden = false
    }
    
    public func hide(){
        isHidden = true
    }
}
 
extension RMNoSearchResultView {
    private func style(){
        isHidden = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    private func layout(){
        addSubviews(label,image)
        NSLayoutConstraint.activate([
            image.centerYAnchor.constraint(equalTo: centerYAnchor),
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.topAnchor.constraint(equalToSystemSpacingBelow: image.bottomAnchor, multiplier: 2),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
