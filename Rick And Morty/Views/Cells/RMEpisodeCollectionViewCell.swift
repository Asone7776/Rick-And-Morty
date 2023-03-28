//
//  RMEpisodeCollectionViewCell.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 28/03/23.
//

import UIKit

/// Single cell for character
final class RMEpisodeCollectionViewCell: UICollectionViewCell {
    static let identifier = "episodesCell";
    
    let stack: UIStackView = {
        let view = UIStackView();
        view.axis = .vertical;
        view.distribution = .fillEqually
        view.alignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false;
        return view;
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
    
    let airLabel: UILabel = {
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
        nameLabel.text = nil
        statusLabel.text = nil
        airLabel.text = nil
    }
}
extension RMEpisodeCollectionViewCell{
    private func style(){
        contentView.backgroundColor = .systemGray5;
        setupLayer();
    }
    private func setupLayer(){
        contentView.layer.cornerRadius = 8;
        contentView.layer.borderColor = UIColor.systemBlue.cgColor;
        contentView.layer.borderWidth = 2
        contentView.clipsToBounds = true;
    }
    private func layout(){
        stack.addArrangedSubview(nameLabel);
        stack.addArrangedSubview(statusLabel);
        stack.addArrangedSubview(airLabel);
        contentView.addSubviews(stack);
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stack.topAnchor.constraint(equalTo: contentView.topAnchor),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ]);
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection);
        setupLayer();
    }
    public func configure(with viewModel:RMEpisodeCollectionViewCellViewModel){
        nameLabel.text = viewModel.episode;
        statusLabel.text = viewModel.name;
        airLabel.text = viewModel.air_date
    }
}
