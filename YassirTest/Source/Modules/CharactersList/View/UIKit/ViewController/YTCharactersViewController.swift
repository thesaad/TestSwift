//
//  YTCharactersViewController.swift
//  YassirTest
//
//  Created by Saad on 13/09/2024.
//

import UIKit
import SwiftUI

/// To display list of characters
///
class YTCharactersViewController: UIViewController {
    
    ///Tableivew to diplay list of properties
    ///
    var tableView: UITableView!
    let viewModel = YTCharactersViewModel()
    let refreshControl = UIRefreshControl()
    var pagingHandler: ((_ isFinished: Bool) -> ())?
    let filterStackView = UIStackView()

    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    // MARK: - View LifeCycle
    override func loadView() {
        super.loadView()
        
        // We setup UI in loadview
        setupFilterButtons()
        setupTableView()
        self.title = "Characters"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        viewModel.loadFirstPage()
        viewModel.datahandler = { [weak self] sucess, error in
            if sucess {
                // updating UI on main thread
                DispatchQueue.main.async {
                    if self?.viewModel.list.count == 0 {
                        self?.setInfo(text: "No Results to Show!")
                    } else {
                        self?.tableView.isHidden = false
                        self?.infoLabel.isHidden = true
                        self?.refreshControl.endRefreshing()
                        self?.tableView.reloadData()
                        self?.pagingHandler?(true)
                        if self?.viewModel.currentPage == 0 {
                            self?.tableView.setContentOffset(CGPointZero, animated:false)
                        }
                    }
                }
            } else {
                self?.setInfo(text: error?.localizedDescription ?? "Something went wrong.")
            }
        }
        
    }
    
    // MARK: Filters Setup
    private func setupFilterButtons() {
        // Define button titles
        let buttonTitles = ["Alive", "Dead", "Unknown"]
        
        // Create a stack view
        filterStackView.axis = .horizontal
        filterStackView.alignment = .leading
        filterStackView.distribution = .fillEqually
        filterStackView.spacing = 20 // Adjust the spacing between buttons
        filterStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add buttons to the stack view
        for (index, title) in buttonTitles.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.layer.cornerRadius = 15 // Set the corner radius to make it rounded
            button.backgroundColor = .clear // Set the background color
            button.setTitleColor(.black, for: .normal) // Set the title color
            button.setTitleColor(.black, for: .selected) // Set the title color

            button.tag = index + 1 // Assign a unique tag (1, 2, 3)
            button.layer.borderWidth = 1.5
            button.layer.borderColor = UIColor.lightGray.cgColor
            button.tintColor = .clear
            // Add target for button actions
            button.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
            
            filterStackView.addArrangedSubview(button)
        }
        
        // Add the stack view to the main view
        view.addSubview(filterStackView)
        
        // Set constraints for the stack view
        NSLayoutConstraint.activate([
            filterStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            filterStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            filterStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            filterStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

    }
    
    //MARK: Info Label
    private func setupInfoLabel() {
        view.addSubview(infoLabel)
        NSLayoutConstraint.activate([
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    private func setInfo(text: String) {
        self.tableView.isHidden = true
        self.infoLabel.isHidden = false
        self.infoLabel.text = text
    }
    // MARK: Tableview Setup
    private func setupTableView() {
        // Set up the table view
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        // Add the table view to the view controller's view
        view.addSubview(tableView)
        
        // Set up constraints for the table view
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // Register a basic cell class
        tableView.register(YTCharacterTableViewCell.self, forCellReuseIdentifier: "YTCharacterTableViewCell")
        

        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl) // not required when using UITableViewController

    }
    
    // MARK: User Interaction

    @objc func refresh(_ sender: AnyObject) {
        viewModel.loadFirstPage()
    }
    
}

// MARK: - Extension to separate out UITableViewDataSource
extension YTCharactersViewController: UITableViewDataSource {
    
    /// Default number of sections is 1 but we have metioned here if customization is needed
    ///
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    /// Default number of records to be displayed
    ///
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.list.count
    }
    
    /// Default number of sections is 1 but we have metioned here if customization is needed
    ///
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YTCharacterTableViewCell", for: indexPath) as? YTCharacterTableViewCell
        cell?.setItem(character: viewModel.list[indexPath.row])
        return cell!
    }
    /// Default height for all rows 80 + 10 for padding
    ///
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    // MARK: - Pull To refresh, Pagination, Load More
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = viewModel.list.count - 1
        if !viewModel.isLoadingData && viewModel.hasMorePages && indexPath.row == lastElement {
            viewModel.loadNext()
        }
    }
}

// MARK: - Extension to separate out UITableViewDelegate
extension YTCharactersViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailView = YTCharacterDetailView(id: viewModel.list[indexPath.row].id)
        let hostingVC = UIHostingController(rootView: detailView)
        self.navigationController?.pushViewController(hostingVC, animated: true)
    }
}

// MARK: - Filtering Content
extension YTCharactersViewController {
    @objc func filterButtonTapped(_ sender: UIButton) {
        // we only have possibility to filter with one status
        for button in filterStackView.subviews {
            (button as? UIButton)?.isSelected = false
            button.backgroundColor = .clear
        }
        sender.isSelected = !sender.isSelected
        sender.backgroundColor = sender.isSelected ? UIColor(red: 235/256.0, green: 241/256.0, blue: 256/256.0, alpha: 1.0) : .clear
        let buttonTag = sender.tag
        
        switch buttonTag {
        case 1:
            viewModel.filterStatus = .Alive
        case 2:
            viewModel.filterStatus = .Dead
        case 3:
            viewModel.filterStatus = .unknown
        default:
            viewModel.filterStatus = nil
        }
        viewModel.loadFirstPage()
        
    }

}

