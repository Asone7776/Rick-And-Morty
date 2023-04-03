//
//  RMLocationViewViewModel.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 01/04/23.
//

import UIKit
protocol RMLocationViewViewModelDelegate: AnyObject {
    func didLoadInitialLocations()
    func didLoadMoreLocations(with indexes:[IndexPath])
    func didSelectLocation(location:RMLocation)
}

final class RMLocationViewViewModel:NSObject {
    weak var delegate: RMLocationViewViewModelDelegate?
    
    private var apiInfo: RMGetAllLocationsResponseInfo?
    private var isLoadingLocations = false
    
    public var shouldShowLoadMoreIndicator: Bool{
        return apiInfo?.next != nil
    }
    
    private var locations = [RMLocation](){
        didSet{
            for location in locations {
                let cellViewModel = RMLocationTableViewCellViewModel(location: location);
                if !cellViewModels.contains(cellViewModel){
                    cellViewModels.append(cellViewModel);
                }
            }
        }
    }
    public private(set) var cellViewModels = [RMLocationTableViewCellViewModel]();
    
    public func location(at index:Int)->RMLocation? {
        locations[index]
    }
    
    private var hasMoreResults: Bool {
        false
    }
    
    override init() {
        super.init()
    }
    
    
    public func fetchLocation(){
        RMService.shared.execute(.listLocationsRequest, expecting:RMGetAllLocationsResponse.self) {[weak self] result in
            switch result {
            case .success(let success):
                self?.apiInfo = success.info;
                self?.locations = success.results;
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialLocations()
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    //MARK: Fetch additional locations
    public func fetchAdditionalLocations(url:URL){
        guard !isLoadingLocations else{
            return
        }
        isLoadingLocations = true
        
        guard let request = RMRequest(url: url) else{
            return
        }
        RMService.shared.execute(request, expecting: RMGetAllLocationsResponse.self) {[weak self] result in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(let success):
                
                strongSelf.apiInfo = success.info;
                let originalCount = strongSelf.locations.count;
                let newCount = success.results.count;
                let total = originalCount + newCount;
                let startingIndex = total - newCount;
                let indexPathsToAdd:[IndexPath] = Array(startingIndex..<(startingIndex+newCount)).compactMap {
                    return IndexPath(row: $0, section: 0);
                }
                strongSelf.locations.append(contentsOf: success.results);
                DispatchQueue.main.async {
                    strongSelf.delegate?.didLoadMoreLocations(with:indexPathsToAdd);
                    strongSelf.isLoadingLocations = false;
                }
            case .failure(let failure):
                print(failure.localizedDescription);
                strongSelf.isLoadingLocations = false;
            }
        }
    }
}

//MARK: Table setup

extension RMLocationViewViewModel: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellViewModels.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RMLocationTableViewCell.identifier) as? RMLocationTableViewCell else{
            fatalError("There is no such cell");
        }
        let item = cellViewModels[indexPath.row];
        cell.configure(with: item);
        return cell;
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: RMLocationFooterLoadingTableReusableView.identifier) as? RMLocationFooterLoadingTableReusableView else{
            fatalError("No such view");
        }
        view.startAnimating();
        return view;
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard shouldShowLoadMoreIndicator else{
            return .zero
        }
        return RMLocationFooterLoadingTableReusableView.rowHeight
    }
}


extension RMLocationViewViewModel: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let location = location(at: indexPath.row) else {
            return
        }
        delegate?.didSelectLocation(location: location);
    }
}

//MARK: On Scroll
extension RMLocationViewViewModel:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator,
              !isLoadingLocations,
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
                strongSelf.fetchAdditionalLocations(url: url);
            }
            timer.invalidate();
        }
    }
}
