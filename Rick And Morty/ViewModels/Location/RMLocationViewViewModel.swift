//
//  RMLocationViewViewModel.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 01/04/23.
//

import Foundation
protocol RMLocationViewViewModelDelegate: AnyObject {
    func didLoadInitialLocations()
}

final class RMLocationViewViewModel {
    weak var delegate: RMLocationViewViewModelDelegate?
    
    private var apiInfo: RMGetAllLocationsResponseInfo?
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
    
    init(){
        
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
}
