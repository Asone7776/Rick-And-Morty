//
//  RMCharacterPhotoCollectionViewCell.swift
//  Rick And Morty
//
//  Created by Uzkassa on 24/03/23.
//

import UIKit

final class RMCharacterPhotoCollectionViewCell: UICollectionViewCell {
    static let identifier = "RMCharacterPhotoCollectionViewCell";
    
    let imageView: UIImageView = {
        let imageView = UIImageView();
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        return imageView;
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
    }
    private func setupConstrains(){
        contentView.addSubview(imageView);
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]);
    }
    public func configure(with model:RMCharacterPhotoCollectionViewCellViewModel){
        model.fetchImage {[weak self] result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: success)
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
extension RMCharacterPhotoCollectionViewCell{
    private func style(){
        contentView.backgroundColor = .systemGray5
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
    }
}
