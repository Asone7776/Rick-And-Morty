//
//  RMEpisodeListViewViewModel.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 28/03/23.
//
import UIKit

protocol RMEpisodeListViewViewModelDelegate: AnyObject{
    func didLoadInitialCharacters()
    func didSelectEpisode(episode:RMEpisode)
    func didLoadMoreEpisodes(with newIndexPaths: [IndexPath])
}

final class RMEpisodeListViewViewModel:NSObject {
    public weak var delegate:RMEpisodeListViewViewModelDelegate?
    private var apiInfo: RMGetAllEpisodesResponseInfo?
    private var isLoadingCharacters = false
    private var characters = [RMEpisode](){
        didSet{
            for char in characters {
                let viewModel = RMEpisodeCollectionViewCellViewModel(name: char.name, air_date: char.air_date, episode: char.episode);
                if !cellViewModels.contains(viewModel){
                    cellViewModels.append(viewModel);
                }
            }
        }
    }
    private var cellViewModels = [RMEpisodeCollectionViewCellViewModel]();
    //MARK: Initial fetch
    func fetchEpisodes(){
        RMService.shared.execute(.listEpisodesRequest, expecting: RMGetAllEpisodesResponse.self) {[weak self] result in
            switch result{
            case .success(let model):
                self?.characters = model.results;
                self?.apiInfo = model.info;
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacters();
                }
            case .failure(let error):
                print(error.localizedDescription);
            }
        }
    }
    //MARK: Fetch additional characters
    public func fetchAdditionalEpisodes(url:URL){
        guard !isLoadingCharacters else{
            return
        }
        isLoadingCharacters = true
        
        guard let request = RMRequest(url: url) else{
            return
        }
        
        RMService.shared.execute(request, expecting: RMGetAllEpisodesResponse.self) {[weak self] result in
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
                    strongSelf.delegate?.didLoadMoreEpisodes(with:indexPathsToAdd);
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
extension RMEpisodeListViewViewModel:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMEpisodeCollectionViewCell.identifier, for: indexPath) as? RMEpisodeCollectionViewCell else{
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
extension RMEpisodeListViewViewModel: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds;
        let width = (bounds.width - 30) / 2;
        return CGSize(width: width, height: 150 );
    }
}
extension RMEpisodeListViewViewModel:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true);
        delegate?.didSelectEpisode(episode: characters[indexPath.row]);
    }
}

//MARK: On Scroll
extension RMEpisodeListViewViewModel:UIScrollViewDelegate{
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
                strongSelf.fetchAdditionalEpisodes(url: url);
            }
            timer.invalidate();
        }
    }
}
