//
//  RMSearchOptionPickerViewController.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 04/04/23.
//

import UIKit

final class RMSearchOptionPickerViewController: UIViewController {
    
    public typealias optionSelectionType = (String) -> Void
    
    private let selectionBlock:(optionSelectionType)
    
    private let selectedOption: RMSearchInputViewViewModel.DynamicOption
    
    let tableCellId = "RMSearchOptionPickerViewControllerCell"
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: tableCellId)
        return table
    }()
    
    init(selectedOption: RMSearchInputViewViewModel.DynamicOption,selection: @escaping optionSelectionType) {
        self.selectionBlock = selection
        self.selectedOption = selectedOption
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layout()
    }
}
extension RMSearchOptionPickerViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedOption.choises.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellId)!
        let item = selectedOption.choises[indexPath.row]
        var config = cell.defaultContentConfiguration()
        config.text = item.capitalized
        cell.contentConfiguration = config
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = selectedOption.choises[indexPath.row]
        selectionBlock(item)
        dismiss(animated: true)
    }
}
extension RMSearchOptionPickerViewController{
    private func layout(){
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
