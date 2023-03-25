//
//  RMCharacterInfoCollectionViewCell.swift
//  Rick And Morty
//
//  Created by Uzkassa on 24/03/23.
//

import UIKit

final class RMCharacterInfoCollectionViewCell: UICollectionViewCell {
    static let identifier = "RMCharacterInfoCollectionViewCell";
    
    private let valueLabel: UILabel = {
        let label = UILabel();
        label.numberOfLines = 2;
        label.text = "Earth"
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.textAlignment = .center
        return label;
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel();
        label.text = "Location"
        label.textAlignment = .center;
        label.font = .systemFont(ofSize: 18, weight: .medium);
        return label;
    }()
    
    private let iconImageView: UIImageView = {
        let icon = UIImageView();
        icon.image = UIImage(systemName: "globe");
        icon.contentMode = .scaleAspectFit;
        return icon;
    }()
    private let titleContainerView:UIView = {
        let view = UIView();
        view.translatesAutoresizingMaskIntoConstraints = false;
        view.backgroundColor = .secondarySystemBackground
        return view;
    }();
    
    private let stack: UIStackView = {
        let view = UIStackView();
        view.axis = .horizontal;
        view.spacing = 0;
        view.translatesAutoresizingMaskIntoConstraints = false;
        view.alignment = .center
        return view;
    }();
    override init(frame: CGRect) {
        super.init(frame: frame);
        style();
        setupConstrains();
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse();
        valueLabel.text = nil;
        titleLabel.text = nil;
        valueLabel.text = nil;
    }
    
 
}
extension RMCharacterInfoCollectionViewCell{
    private func style(){
        contentView.backgroundColor = .systemGray5
        contentView.layer.cornerRadius = 8;
        contentView.clipsToBounds = true
    }
    
    private func setupConstrains(){
        stack.addArrangedSubview(iconImageView);
        stack.addArrangedSubview(titleLabel);
        titleContainerView.addSubviews(stack);
        contentView.addSubviews(titleContainerView,valueLabel);
        NSLayoutConstraint.activate([
            titleContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleContainerView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.33),

            stack.topAnchor.constraint(equalTo: titleContainerView.topAnchor),
            stack.leadingAnchor.constraint(equalToSystemSpacingAfter: titleContainerView.leadingAnchor, multiplier: 1),
            titleContainerView.trailingAnchor.constraint(equalToSystemSpacingAfter: stack.trailingAnchor, multiplier: 1),
            stack.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor),
            
            iconImageView.heightAnchor.constraint(equalToConstant: 25),
            iconImageView.widthAnchor.constraint(equalToConstant: 25),
            
            valueLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 2),
            valueLabel.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 2),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: valueLabel.trailingAnchor, multiplier: 2),
            titleContainerView.topAnchor.constraint(equalToSystemSpacingBelow: valueLabel.bottomAnchor, multiplier: 2),
        ]);
    }
    public func configure(with model:RMCharacterInfoCollectionViewCellViewModel){
        titleLabel.text = model.title;
        valueLabel.text = model.displayValue.capitalized;
        iconImageView.image = UIImage(systemName: model.displayIconName);
        iconImageView.tintColor = model.tintColor
        titleLabel.textColor = model.tintColor
        valueLabel.textColor = model.tintColor
    }
}
