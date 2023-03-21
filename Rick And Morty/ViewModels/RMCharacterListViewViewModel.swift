//
//  CharacterListViewViewModel.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 20/03/23.
//

import UIKit

protocol RMCharacterListViewViewModelDelegate: AnyObject{
    func didLoadInitialCharacters()
    func didSelectCharacter(character:RMCharacter)
}

final class RMCharacterListViewViewModel:NSObject {
    public weak var delegate:RMCharacterListViewViewModelDelegate?
    private var apiInfo: RMGetAllCharactersResponseInfo?
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
                self?.apiInfo = model.info;
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacters();
                }
            case .failure(let error):
                print(error);
            }
        }
    }
    public var shouldShowLoadMoreIndicator: Bool{
        return apiInfo?.next != nil
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
extension RMCharacterListViewViewModel:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true);
        delegate?.didSelectCharacter(character: characters[indexPath.row]);
    }
}
extension RMCharacterListViewViewModel:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator else {
            return
        }
    }
}
