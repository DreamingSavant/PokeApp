//
//  PokeTableViewController.swift
//  PokeAPI
//
//  Created by Roderick Presswood on 1/12/22.
//

import UIKit

class PokeTableViewController: UIViewController {
    
    var tableView: UITableView?
    
    var viewModel = PokemonViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
        requestPage()
        tableView?.isAccessibilityElement = true
        tableView?.accessibilityLabel = "Pokemon index."
        tableView?.accessibilityHint = "This is the Pokemon index."
    }
    
    private func setupTableView() {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.prefetchDataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.tableView = tableView
    }
    
    func requestPage() {
        viewModel.getPokemon() {
            DispatchQueue.main.async {
                self.tableView?.reloadData()
            }
        }
    }
}

extension PokeTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getPokemonCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.getPokemonName(at: indexPath.row)
        cell.detailTextLabel?.text = viewModel.getPokemonID(at: indexPath.row)
        cell.isAccessibilityElement = true
        return cell
    }
    
    
}

extension PokeTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigateToDetail(with: indexPath.row, viewModel: self.viewModel)
    }
    
    private func navigateToDetail(with index: Int, viewModel: PokemonViewModel) {
        DispatchQueue.main.async {
            let detailVC = DetailViewController(for: viewModel, at: index)
            let navVC = UINavigationController()
            navVC.viewControllers = [detailVC]
            self.modalPresentationStyle = .overFullScreen
            self.present(navVC, animated: true, completion: nil)
        }
    }
}

extension PokeTableViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let lastIndexPath = IndexPath(row: viewModel.getPokemonCount() - 1, section: 0)
        guard indexPaths.contains(lastIndexPath) else { return }
        requestPage()
    }
    
}

extension PokeTableViewController: DismissDetailDelegate {
    
    func dismissDetail() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
}
