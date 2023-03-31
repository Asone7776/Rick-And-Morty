//
//  RMSettingsTableViewCell.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 31/03/23.
//

import UIKit

final class RMSettingsTableViewCell: UITableViewCell {
    static let identifier = "settings-cell";
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let view: UIView = {
        let view = UIView();
        view.translatesAutoresizingMaskIntoConstraints = false;
        view.layer.cornerRadius = 8
        return view;
    }();
    
    let titleLabel: UILabel = {
        let label = UILabel();
        label.textColor = .label;
        label.font = .systemFont(ofSize: 16, weight: .semibold);
        label.translatesAutoresizingMaskIntoConstraints = false;
        return label;
    }();
    
    let icon: UIImageView = {
        let imageView = UIImageView();
        imageView.contentMode = .scaleAspectFit;
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        imageView.tintColor = .label
        return imageView;
    }();
    override func prepareForReuse() {
        super.prepareForReuse();
        titleLabel.text = nil;
        icon.image = nil
    }
}

extension RMSettingsTableViewCell{
    private func layout(){
        view.addSubview(icon);
        contentView.addSubviews(view,titleLabel);
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 1),
            view.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            view.widthAnchor.constraint(equalToConstant: 35),
            view.heightAnchor.constraint(equalToConstant: 35),
            titleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: 1.5),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            icon.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            icon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    public func configure(title: String,image: UIImage?,color:UIColor){
        self.titleLabel.text = title;
        self.icon.image = image
        self.view.backgroundColor = color
    }
}
