//
//  RMFooterLoadingCollectionReusableView.swift
//  Rick And Morty
//
//  Created by Uzkassa on 22/03/23.
//

import UIKit

final class RMFooterLoadingCollectionReusableView: UICollectionReusableView {
    static let identifier = "RMFooterLoadingCollectionReusableView";
    
    private let indicator:UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium);
        spinner.hidesWhenStopped = true;
        spinner.tintColor = .label;
        spinner.translatesAutoresizingMaskIntoConstraints = false;
        return spinner;
    }();
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        layout();
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension RMFooterLoadingCollectionReusableView{
    private func layout(){
        addSubview(indicator);
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]);
    }
    public func startAnimating(){
        indicator.startAnimating();
    }
}
