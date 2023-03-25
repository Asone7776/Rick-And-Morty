//
//  RMCharacterEpisodeCollectionViewCell.swift
//  Rick And Morty
//
//  Created by Uzkassa on 24/03/23.
//

import UIKit

final class RMCharacterEpisodeCollectionViewCell: UICollectionViewCell {
    static let identifier = "RMCharacterEpisodeCollectionViewCell";
    
    private let nameLabel: UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.textColor = .red;
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
        super.prepareForReuse();
        nameLabel.text = nil;
    }
    
}
extension RMCharacterEpisodeCollectionViewCell{
    private func style(){
        contentView.backgroundColor = .systemBlue;
        contentView.layer.cornerRadius = 8;
        contentView.clipsToBounds = true;
    }
    
    private func layout(){
        contentView.addSubview(nameLabel);
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    public func configure(with model:RMCharacterEpisodeCollectionViewCellViewModel){
        model.getEpisode {[weak self] result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self?.nameLabel.text = success.episode
                }
            case .failure(let failure):
                print(failure);
            }
        }
    }
}
