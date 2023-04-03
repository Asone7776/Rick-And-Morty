//
//  RMLocationFooterLoadingTableReusableView.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 03/04/23.
//

import UIKit

final class RMLocationFooterLoadingTableReusableView: UITableViewHeaderFooterView{
    static let identifier = "location-footer-view"
    static let rowHeight: CGFloat = 100
    
    private let indicator:UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium);
        spinner.hidesWhenStopped = true;
        spinner.tintColor = .label;
        spinner.translatesAutoresizingMaskIntoConstraints = false;
        return spinner;
    }();
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        layout();
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func startAnimating(){
        indicator.startAnimating();
    }
}

extension RMLocationFooterLoadingTableReusableView{
    private func layout(){
        contentView.addSubview(indicator);
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
