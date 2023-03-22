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
    func didLoadMoreCharacters(with newIndexPaths: [IndexPath])
}

final class RMCharacterListViewViewModel:NSObject {
    public weak var delegate:RMCharacterListViewViewModelDelegate?
    private var apiInfo: RMGetAllCharactersResponseInfo?
    private var isLoadingCharacters = false
    private var characters = [RMCharacter](){
        didSet{
            for char in characters {
                let viewModel = RMCharacterCollectionViewCellViewModel(characterName: char.name, characterStatus: char.status, characterImageUrl: URL(string: char.image));
                if !cellViewModels.contains(viewModel){
                    cellViewModels.append(viewModel);
                }
            }
        }
    }
    private var cellViewModels = [RMCharacterCollectionViewCellViewModel]();
    //MARK: Initial fetch
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
    //MARK: Fetch additional characters
    public func fetchAdditionalCharacters(url:URL){
        guard !isLoadingCharacters else{
            return
        }
        isLoadingCharacters = true
        
        guard let request = RMRequest(url: url) else{
            return
        }
        
        RMService.shared.execute(request, expecting: RMGetAllCharactersResponse.self) {[weak self] result in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(let success):
                strongSelf.apiInfo = success.info;
                let originalCount = strongSelf.characters.count;
                let newCount = success.results.count;
                let total = originalCount + newCount;
                let startingIndex = total - newCount;
                let indexPathsToAdd:[IndexPath] = Array(startingIndex..<(startingIndex+newCount)).compactMap {
                    return IndexPath(row: $0, section: 0);
                }
                strongSelf.characters.append(contentsOf: success.results);
                DispatchQueue.main.async {
                    strongSelf.delegate?.didLoadMoreCharacters(with:indexPathsToAdd);
                    strongSelf.isLoadingCharacters = false;
                }
            case .failure(let failure):
                print(failure.localizedDescription);
                strongSelf.isLoadingCharacters = false;
            }
        }
    }
    public var shouldShowLoadMoreIndicator: Bool{
        return apiInfo?.next != nil
    }
}

//MARK: Characters Collection View DataSource
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier, for: indexPath) as? RMFooterLoadingCollectionReusableView else{
            fatalError("Unsupported");
        }
        footer.startAnimating();
        return footer;
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadMoreIndicator else{
            return .zero;
        }
        return CGSize(width: collectionView.bounds.width, height: 100);
    }
}

//MARK: Flow Layout and delegate
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

//MARK: On Scroll
extension RMCharacterListViewViewModel:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator,
              !isLoadingCharacters,
              let nextUrl = apiInfo?.next,
              !cellViewModels.isEmpty,
              let url = URL(string: nextUrl) else {
            return
        }
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] timer in
            guard let strongSelf = self else {
                return
            }
            let offset = scrollView.contentOffset.y;
            let totalContentHeight = scrollView.contentSize.height;
            let totalScrollViewHeight = scrollView.frame.size.height;
            if offset >= (totalContentHeight - totalScrollViewHeight) - 120 {
                strongSelf.fetchAdditionalCharacters(url: url);
            }
            timer.invalidate();
        }
    }
}
