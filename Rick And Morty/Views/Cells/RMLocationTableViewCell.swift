//
//  RMLocationTableViewCell.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 01/04/23.
//

import UIKit

final class RMLocationTableViewCell: UITableViewCell {
    
    static let identifier = "RMLocationTableViewCellId";
    static let rowHeight: CGFloat = 100;
    
    let stack: UIStackView = {
        let stack = UIStackView();
        stack.axis = .vertical;
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false;
        return stack;
    }();
    
    let nameLabel: UILabel = {
        let label = UILabel();
        label.font = .systemFont(ofSize: 20, weight: .bold);
        label.translatesAutoresizingMaskIntoConstraints = false;
        return label;
    }();
    
    let typeLabel: UILabel = {
        let label = UILabel();
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 18, weight: .semibold);
        label.translatesAutoresizingMaskIntoConstraints = false;
        return label;
    }();
    
    let dimensionLabel: UILabel = {
        let label = UILabel();
        label.textColor = .tertiaryLabel
        label.font = .systemFont(ofSize: 16, weight: .regular);
        label.translatesAutoresizingMaskIntoConstraints = false;
        return label;
    }();

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse();
        nameLabel.text = nil
        typeLabel.text = nil
        dimensionLabel.text = nil
    }
    
    private func layout(){
        stack.addArrangedSubview(nameLabel)
        stack.addArrangedSubview(typeLabel)
        stack.addArrangedSubview(dimensionLabel)
        contentView.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 1),
            stack.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 1),
            contentView.bottomAnchor.constraint(equalToSystemSpacingBelow: stack.bottomAnchor, multiplier: 1),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: stack.trailingAnchor, multiplier: 1),
        ])
    }
    
    public func configure(with model:RMLocationTableViewCellViewModel){
        nameLabel.text = model.name
        typeLabel.text = model.type
        dimensionLabel.text = model.dimension
    }
}
