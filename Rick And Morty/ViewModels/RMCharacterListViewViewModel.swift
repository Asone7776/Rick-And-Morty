//
//  CharacterListViewViewModel.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 20/03/23.
//

import UIKit

protocol RMCharacterListViewViewModelDelegate: AnyObject{
    func didLoadInitialCharacters()
}

final class RMCharacterListViewViewModel:NSObject {
    public weak var delegate:RMCharacterListViewViewModelDelegate?
    private var characters = [RMCharacter](){
        didSet{
            characters.forEach { char in
                let viewModel = RMCharacterCollectionViewCellViewModel(characterName: char.name, characterStatus: char.status, characterImageUrl: URL(string: char.image));
                cellViewModels.append(viewModel);
            }
        }
    }
    private var cellViewModels = [RMCharacterCollectionViewCellViewModel]();
    func fetchCharacters(){
        RMService.shared.execute(.listCharactersRequest, expecting: RMGetAllCharactersResponse.self) {[weak self] result in
            switch result{
            case .success(let model):
                self?.characters = model.results;
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacters();
                }
            case .failure(let error):
                print(error);
            }
        }
    }
}
extension RMCharacterListViewViewModel:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.identifier, for: indexPath) as? RMCharacterCollectionViewCell else{
            fatalError("Unsupported cell");
        }
        cell.configure(with: cellViewModels[indexPath.row]);
        return cell;
    }
    
}
extension RMCharacterListViewViewModel: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds;
        let width = (bounds.width - 30) / 2;
        return CGSize(width: width, height: width * 1.5 );
    }
}
