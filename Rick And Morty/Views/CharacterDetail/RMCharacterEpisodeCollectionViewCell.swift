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
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }();
    
    private let nameLabel: UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.textColor = .label;
        label.textAlignment = .center;
        label.numberOfLines = 0;
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 22,weight: .regular)
        return label;
    }();
    
    private let seasonLabel: UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.textColor = .label;
        label.textAlignment = .center;
        label.font = .systemFont(ofSize: 20,weight: .semibold)
        return label;
    }();
    
    private let airDateLabel: UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.textColor = .label;
        label.textAlignment = .center;
        label.font = .systemFont(ofSize: 18,weight: .light)
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
        seasonLabel.text = nil;
        airDateLabel.text = nil;
    }
    
}
extension RMCharacterEpisodeCollectionViewCell{
    private func style(){
        contentView.backgroundColor = .systemGray5;
        contentView.layer.cornerRadius = 8;
        contentView.clipsToBounds = true;
        contentView.layer.borderWidth = 2;
        contentView.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    private func layout(){
        stack.addArrangedSubview(seasonLabel);
        stack.addArrangedSubview(nameLabel);
        stack.addArrangedSubview(airDateLabel);
        contentView.addSubview(stack);
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 2),
            stack.topAnchor.constraint(equalTo: contentView.topAnchor),
//            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: stack.trailingAnchor, multiplier: 2),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    public func configure(with model:RMCharacterEpisodeCollectionViewCellViewModel){
        model.registerForData {[weak self] data in
            guard let self = self else {
                return
            }
            self.seasonLabel.text = "Episode - \(data.episode)"
            self.nameLabel.text = data.name
            self.airDateLabel.text = "On air - \(data.air_date)"
        }
        model.fetchEpisode();
    }
}
