//
//  RMLocationView.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 01/04/23.
//

import UIKit

protocol RMLocationViewDelegate: AnyObject {
    func didSelectLocation(_ view: RMLocationView,location: RMLocation)
}

class RMLocationView: UIView {
    weak var delegate: RMLocationViewDelegate?
    var viewModel = RMLocationViewViewModel();
    
    private let spinner: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large);
        view.hidesWhenStopped = true;
        view.translatesAutoresizingMaskIntoConstraints = false;
        return view;
    }();
    
    public lazy var locationTable:UITableView = {
        let table = UITableView(frame: .zero, style: .grouped);
        table.translatesAutoresizingMaskIntoConstraints = false;
        table.dataSource = viewModel;
        table.delegate = viewModel;
        table.rowHeight = RMLocationTableViewCell.rowHeight;
        table.isHidden = true;
        table.alpha = 0;
        table.register(RMLocationTableViewCell.self, forCellReuseIdentifier: RMLocationTableViewCell.identifier)
        table.register(RMLocationFooterLoadingTableReusableView.self, forHeaderFooterViewReuseIdentifier: RMLocationFooterLoadingTableReusableView.identifier)
        return table;
    }();
    
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        spinner.startAnimating();
        viewModel.delegate = self;
        viewModel.fetchLocation();
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension RMLocationView{
    private func style(){
        translatesAutoresizingMaskIntoConstraints = false;
    }
    private func layout(){
        addSubviews(locationTable,spinner);
        NSLayoutConstraint.activate([
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            locationTable.leadingAnchor.constraint(equalTo: leadingAnchor),
            locationTable.topAnchor.constraint(equalTo: topAnchor),
            locationTable.trailingAnchor.constraint(equalTo: trailingAnchor),
            locationTable.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}



extension RMLocationView: RMLocationViewViewModelDelegate{
    func didLoadMoreLocations(with indexes: [IndexPath]) {
        locationTable.performBatchUpdates {
            locationTable.insertRows(at: indexes, with: .automatic)
        }
    }

    
    func didSelectLocation(location: RMLocation) {
        delegate?.didSelectLocation(self, location: location)
    }
    
    func didLoadInitialLocations() {
        spinner.stopAnimating()
        locationTable.isHidden = false
        locationTable.reloadData()
        UIView.animate(withDuration: 0.3) {
            self.locationTable.alpha = 1
        }
    }
}

