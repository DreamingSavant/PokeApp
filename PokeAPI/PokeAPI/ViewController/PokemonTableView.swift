//
//  SwiftUIView.swift
//  PokeAPI
//
//  Created by Roderick Presswood on 6/6/22.
//

import SwiftUI

struct SwiftUIView: View {
    
    let subText = "Gotta Catch em all!"
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            Image("Pokemon-Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 1000, height: 300, alignment: .center)
                .accessibilityElement()
                .accessibilityAddTraits(.isImage)
                .accessibilityLabel("Pokemon Logo")
                
            Text(subText)
                .padding()
                .frame(width: 1000, height: 30, alignment: .center)
                .accessibilityAddTraits(.isStaticText)
                .accessibilityLabel("Gotta Catch em all!")
                .accessibilityIdentifier("This is the slogan for Pokemon")
        }
        .padding([.leading, .trailing])
        .padding(.top, 10)
//        .padding(.bottom, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .accessibilityElement()
        
        PokemonTableVC()
            .accessibilityElement()
            .padding([.leading, .trailing])
            .padding(.top, 10)
            .padding(.bottom, 10)
            
    }
}

struct PokemonTableVC: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> PokeTableViewController {
        
        let viewController = PokeTableViewController()
        viewController.tableView?.reloadData()
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: PokeTableViewController, context: Context) {
        
        
    }
    
    
    typealias UIViewControllerType = PokeTableViewController
    
    var controllers: [UIViewController] = []
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
