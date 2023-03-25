//
//  RMCharacterEpisodeCollectionViewCell.swift
//  Rick And Morty
//
//  Created by Uzkassa on 24/03/23.
//

import UIKit

final class RMCharacterEpisodeCollectionViewCell: UICollectionViewCell {
    static let identifier = "RMCharacterEpisodeCollectionViewCell";
    
    private let stack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }();
    
    private let nameLabel: UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.textColor = .label;
        label.textAlignment = .center;
        return label;
    }();
    
    private let episodeLabel: UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.textColor = .label;
        label.textAlignment = .center;
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
        episodeLabel.text = nil;
    }
    
}
extension RMCharacterEpisodeCollectionViewCell{
    private func style(){
        contentView.backgroundColor = .systemGray5;
        contentView.layer.cornerRadius = 8;
        contentView.clipsToBounds = true;
    }
    
    private func layout(){
        stack.addArrangedSubview(episodeLabel);
        stack.addArrangedSubview(nameLabel);
        contentView.addSubview(stack);
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    public func configure(with model:RMCharacterEpisodeCollectionViewCellViewModel){
        model.getEpisode {[weak self] result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self?.nameLabel.text = success.name
                    self?.episodeLabel.text = success.episode
                }
            case .failure(let failure):
                print(failure);
            }
        }
    }
}
