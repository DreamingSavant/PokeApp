//
//  PokeViewModel.swift
//  PokeAPI
//
//  Created by Roderick Presswood on 1/12/22.
//

import UIKit


class PokemonViewModel {
    
    private var pokemon: [Pokemon]
    private var pokemonDetails: PokemonDetail?
    private var network = PokeNetwork()
    private var imageCache = ImageCache.sharedCache
    
    init(pokemon: [Pokemon] = []) {
        self.pokemon = pokemon
    }
    
    func getPokemon(completion: @escaping () -> Void) {
        
        network.getPokeModel(url: PokeNetwork.PokeConstants.pokeList(getPokemonCount()).url) { (page: PokemonPage?) in
            
            guard let results = page?.results else { return }
            self.pokemon.append(contentsOf: results)
            print(results)
            completion()
        }
        
    }
    
    func getPokemonDetail(at index: Int, completion: @escaping (PokemonDetail) -> Void) {
        network.getPokeModel(url: PokeNetwork.PokeConstants.pokemonDetail(getPokemonURL(at: index)).url) { (pokemonDetail: PokemonDetail?) in
            
            guard let results = pokemonDetail.self else { return }
            self.pokemonDetails = results
            guard let pokemonDetails = self.pokemonDetails else { return }
            print("These are the pokemon Details:", pokemonDetails)
            completion(pokemonDetails)
        }
    }
    
    func fetchImage(with URL: String, completion: @escaping (UIImage?)->()) {
        let urlString = URL
        if let data = self.imageCache.get(url: urlString) {
            print("Cache")
            completion(UIImage(data: data))
            return
        }
        completion(nil)
        self.network.fetchImage(urlString: urlString, completion: { (result) in
            guard let data = result else {
                completion(nil)
                return print("No Data was present")
            }
            self.imageCache.set(data: data, url: urlString)
            completion(UIImage(data: data))
        })
    }
    
    func getPokemonCount() -> Int {
        return pokemon.count
    }
    
    func getPokemonName(at index: Int) -> String {
        return pokemon[index].name
    }
    
    func getPokemonURL(at index: Int) -> String {
        return pokemon[index].url
    }
    
    func getPokemonID(at index: Int) -> String {
        return "\(index)"
    }
    
    func getPokemonImage() -> UIImage? {
        
        return UIImage()
    }
    
    func getPokemonId() -> Int {
        guard let pokemonId = pokemonDetails?.id else { return 0 }
        return pokemonId
    }
    
    func getPokemonWeight() -> Int {
        guard let pokemonWeight = pokemonDetails?.weight else { return 0 }
        return pokemonWeight
    }
    
    func getPokemonHeight() -> Int {
        guard let pokemonHeight = pokemonDetails?.height else { return 0 }
        return pokemonHeight
    }
}
