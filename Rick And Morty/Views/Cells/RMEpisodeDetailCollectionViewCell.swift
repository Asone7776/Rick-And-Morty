//
//  RMEpisodeDetailCollectionViewCell.swift
//  Rick And Morty
//
//  Created by Uzkassa on 30/03/23.
//

import UIKit

class RMEpisodeDetailCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "episodeDetailCell";
    
    let stack: UIStackView = {
        let view = UIStackView();
        view.axis = .vertical;
        view.distribution = .fillEqually
        view.alignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false;
        return view;
    }();
    
    let titleLabel: UILabel = {
        let label = UILabel();
        label.textColor = .label;
        label.font = .systemFont(ofSize: 18, weight: .medium);
        label.translatesAutoresizingMaskIntoConstraints = false;
        return label;
    }();
    
    let valueLabel: UILabel = {
        let label = UILabel();
        label.textColor = .secondaryLabel;
        label.font = .systemFont(ofSize: 16, weight: .regular);
        label.translatesAutoresizingMaskIntoConstraints = false;
        return label;
    }();
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse();
        titleLabel.text = nil
        valueLabel.text = nil
    }
    
    public func configure(with model: RMEpisodeInfoCollectionViewCellViewModel){
        titleLabel.text = model.title;
        valueLabel.text = model.value;
    }
}
extension RMEpisodeDetailCollectionViewCell{
    private func style(){
        contentView.backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 8
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    private func layout(){
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(valueLabel)
        contentView.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            stack.topAnchor.constraint(equalTo: contentView.topAnchor),
            stack.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ]);
    }
}
