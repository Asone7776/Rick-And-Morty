//
//  RMCharacterCollectionViewCell.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 20/03/23.
//

import UIKit

/// Single cell for character
final class RMCharacterCollectionViewCell: UICollectionViewCell {
    static let identifier = "characterCell";
    
    let imageView:UIImageView = {
        let imageView = UIImageView();
        imageView.contentMode = .scaleAspectFill;
        imageView.clipsToBounds = true;
        imageView.layer.cornerRadius = 8;
        imageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner];
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        return imageView;
    }();
    
    let nameLabel: UILabel = {
        let label = UILabel();
        label.textColor = .label;
        label.font = .systemFont(ofSize: 18, weight: .medium);
        label.translatesAutoresizingMaskIntoConstraints = false;
        return label;
    }();
    
    let statusLabel: UILabel = {
        let label = UILabel();
        label.textColor = .secondaryLabel;
        label.font = .systemFont(ofSize: 16, weight: .regular);
        label.translatesAutoresizingMaskIntoConstraints = false;
        return label;
    }();
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        style();
        layout();
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
        statusLabel.text = nil
    }
}
extension RMCharacterCollectionViewCell{
    private func style(){
        contentView.backgroundColor = .secondarySystemBackground;
        setupLayer();
    }
    private func setupLayer(){
        contentView.layer.cornerRadius = 8;
        contentView.layer.shadowColor = UIColor.label.cgColor;
        contentView.layer.shadowOffset = CGSize(width: 4, height: 4);
        contentView.layer.shadowOpacity = 0.4;
    }
    private func layout(){
        contentView.addSubviews(imageView,nameLabel,statusLabel);
        NSLayoutConstraint.activate([
            statusLabel.heightAnchor.constraint(equalToConstant: 30),
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            statusLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 1),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: statusLabel.trailingAnchor, multiplier: 1),
            contentView.bottomAnchor.constraint(equalToSystemSpacingBelow: statusLabel.bottomAnchor, multiplier: 1),
            
            nameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 1),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: nameLabel.trailingAnchor, multiplier: 1),
            nameLabel.bottomAnchor.constraint(equalTo: statusLabel.topAnchor),
            
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.topAnchor.constraint(equalToSystemSpacingBelow: imageView.bottomAnchor, multiplier: 1)
        ]);
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection);
        setupLayer();
    }
    public func configure(with viewModel:RMCharacterCollectionViewCellViewModel){
        nameLabel.text = viewModel.characterName;
        statusLabel.text = viewModel.characterStatusText;
        viewModel.fetchImage {[weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.imageView.image = image;
                }
            case .failure(let failure):
                print(failure);
            }
        }
    }
}
