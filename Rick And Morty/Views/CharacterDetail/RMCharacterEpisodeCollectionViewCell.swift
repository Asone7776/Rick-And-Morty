//
//  RMCharacterEpisodeCollectionViewCell.swift
//  Rick And Morty
//
//  Created by Uzkassa on 24/03/23.
//

import UIKit

final class RMCharacterEpisodeCollectionViewCell: UICollectionViewCell {
    static let identifier = "RMCharacterEpisodeCollectionViewCell";
    
    override init(frame: CGRect) {
        super.init(frame: frame);
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse();
    }
    
    private func setupConstrains(){
        
    }
    
    public func configure(with model:RMCharacterEpisodeCollectionViewCellViewModel){
        
    }
}
