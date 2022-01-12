//
//  ViewController.swift
//  PokeAPI
//
//  Created by Roderick Presswood on 1/12/22.
//

import UIKit

class ViewController: UIViewController {
    
    var tableView: UITableView?
    
    var viewModel = PokemonViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
        requestPage()
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
        tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
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

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getPokemonCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.getPokemonName(at: indexPath.row)
        
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
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

extension ViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let lastIndexPath = IndexPath(row: viewModel.getPokemonCount() - 1, section: 0)
        guard indexPaths.contains(lastIndexPath) else { return }
        requestPage()
    }
    
}

extension ViewController: DismissDetailDelegate {
    
    func dismissDetail() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
}
