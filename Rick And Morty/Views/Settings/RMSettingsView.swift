//
//  RMSettingsView.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 31/03/23.
//

import UIKit

protocol RMSettingsViewDelegate: AnyObject{
    func didSelectUrl(url:URL)
    func didRatePressed()
}

final class RMSettingsView: UIView {
    
    weak var delegate: RMSettingsViewDelegate?
    
    private let viewModel = RMSettingsViewViewModel(cellViewModels: RMSettingsOption.allCases.compactMap({ type in
        return RMSettingsCellViewModel(type: type)
    }))
    
    
    public lazy var settingsTable:UITableView = {
        let table = UITableView();
        table.translatesAutoresizingMaskIntoConstraints = false;
        table.dataSource = self;
        table.delegate = self;
        table.rowHeight = 60
        table.register(RMSettingsTableViewCell.self, forCellReuseIdentifier: RMSettingsTableViewCell.identifier)
        return table;
    }();
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension RMSettingsView {
    private func style(){
        translatesAutoresizingMaskIntoConstraints = false;
    }
    
    private func layout(){
        addSubview(settingsTable);
        NSLayoutConstraint.activate([
            settingsTable.leadingAnchor.constraint(equalTo: leadingAnchor),
            settingsTable.topAnchor.constraint(equalTo: topAnchor),
            settingsTable.trailingAnchor.constraint(equalTo: trailingAnchor),
            settingsTable.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension RMSettingsView:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RMSettingsTableViewCell.identifier) as? RMSettingsTableViewCell else{
            fatalError("No cell")
        }
        let item = viewModel.cellViewModels[indexPath.row];
        cell.configure(title: item.title, image: item.image,color: item.iconColor)
        return cell;
    }
}

extension RMSettingsView:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = viewModel.cellViewModels[indexPath.row]
        if item.type == .rateApp{
            delegate?.didRatePressed();
        }else{
            if let url = item.type.url {
                delegate?.didSelectUrl(url: url);
            }
        }
    }
}

