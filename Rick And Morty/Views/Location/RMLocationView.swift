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
        let table = UITableView();
        table.translatesAutoresizingMaskIntoConstraints = false;
        table.dataSource = self;
        table.delegate = self;
        table.rowHeight = RMLocationTableViewCell.rowHeight;
        table.isHidden = true;
        table.alpha = 0;
        table.register(RMLocationTableViewCell.self, forCellReuseIdentifier: RMLocationTableViewCell.identifier)
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

//MARK: Table setup

extension RMLocationView: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellViewModels.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RMLocationTableViewCell.identifier) as? RMLocationTableViewCell else{
            fatalError("There is no such cell");
        }
        let item = viewModel.cellViewModels[indexPath.row];
        cell.configure(with: item);
        return cell;
    }
}


extension RMLocationView: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let location = viewModel.location(at: indexPath.row) else {
            return
        }
        delegate?.didSelectLocation(self, location: location);
    }
}

extension RMLocationView: RMLocationViewViewModelDelegate{
    func didLoadInitialLocations() {
        spinner.stopAnimating()
        locationTable.isHidden = false
        locationTable.reloadData()
        UIView.animate(withDuration: 0.3) {
            self.locationTable.alpha = 1
        }
    }
}
