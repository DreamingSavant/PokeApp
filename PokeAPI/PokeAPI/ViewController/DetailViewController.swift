//
//  DetailViewController.swift
//  PokeAPI
//
//  Created by Roderick Presswood on 1/12/22.
//

import UIKit

protocol DismissDetailDelegate {
    func dismissDetail()
}

class DetailViewController: UIViewController {
    
    
    var viewModel: PokemonViewModel
    var index: Int
    
    init(for viewModel: PokemonViewModel, at index: Int) {
        self.viewModel = viewModel
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
    }
    
    private func setup() {
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let imageView = UIImageView(frame: .zero)
        imageView.backgroundColor = .black
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        let nameLabel = UILabel(frame: .zero)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = .black
        nameLabel.textAlignment = .left
        
        let orderLabel = UILabel(frame: .zero)
        orderLabel.translatesAutoresizingMaskIntoConstraints = false
        orderLabel.textAlignment = .left
        
        let heightLabel = UILabel(frame: .zero)
        heightLabel.translatesAutoresizingMaskIntoConstraints = false
        heightLabel.textAlignment = .left
        
        let weightLabel = UILabel(frame: .zero)
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        weightLabel.textAlignment = .left
        
        viewModel.getPokemonDetail(at: index) { [weak self] details in
            DispatchQueue.main.async {
                self?.viewModel.fetchImage(with: details.sprites.frontDefault) { image in
                    DispatchQueue.main.async {
                        guard let image = image else { return }
                        imageView.image = image
                    }
                }
                nameLabel.text = "Name: \(details.name)"
                orderLabel.text = "ID: \(details.id)"
                heightLabel.text = "Height: \(details.height) cm"
                weightLabel.text = "Weight: \(details.weight) kg"
            }
        }
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(orderLabel)
        stackView.addArrangedSubview(heightLabel)
        stackView.addArrangedSubview(weightLabel)
        
        let fillerView = UIView(frame: .zero)
        fillerView.translatesAutoresizingMaskIntoConstraints = false
        fillerView.setContentHuggingPriority(.defaultLow, for: .vertical)
        fillerView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        fillerView.backgroundColor = .clear
        stackView.addArrangedSubview(fillerView)
        
        self.view.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                                       constant: 24).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,
                                           constant: 24).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,
                                            constant: -24).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,
                                                    constant: -24).isActive = true
    }
    
    private func getImage(with URL: String) -> UIImage {
        return UIImage()
    }
}
