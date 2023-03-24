//
//  RMCharacterInfoCollectionViewCell.swift
//  Rick And Morty
//
//  Created by Uzkassa on 24/03/23.
//

import UIKit

final class RMCharacterInfoCollectionViewCell: UICollectionViewCell {
    static let identifier = "RMCharacterInfoCollectionViewCell";
    
    private let valueLabel:UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.text = "Earth"
        return label;
    }()
    
    private let titleLabel:UILabel = {
        let label = UILabel();
        label.text = "Location"
        label.translatesAutoresizingMaskIntoConstraints = false;
        return label;
    }()
    
    private let iconImageView:UIImageView = {
        let icon = UIImageView();
        icon.image = UIImage(systemName: "globe");
        icon.translatesAutoresizingMaskIntoConstraints = false;
        return icon;
    }()
    
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
    
    public func configure(with model:RMCharacterInfoCollectionViewCellViewModel){
        
    }
}
extension RMCharacterInfoCollectionViewCell{
    private func style(){
        contentView.backgroundColor = .secondarySystemBackground;
        contentView.layer.cornerRadius = 8;
    }
    
    private func setupConstrains(){
        contentView.addSubviews(valueLabel,titleLabel,iconImageView);
        NSLayoutConstraint.activate([
            
        ]);
    }
}
