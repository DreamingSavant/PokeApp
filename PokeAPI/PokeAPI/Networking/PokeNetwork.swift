//
//  PokeNetwork.swift
//  PokeAPI
//
//  Created by Roderick Presswood on 1/12/22.
//

import Foundation

class PokeNetwork {
    
    enum PokeConstants {
        
        case pokeList(Int)
        case pokemonDetail(String)
        case pokeImage(String)
        
        var url: URL? {
            switch self {
            case .pokeList(let offset):
                let listStr = "https://pokeapi.co/api/v2/pokemon?limit=30&offset=\(offset)"
                return URL(string: listStr)
            case .pokemonDetail(let urlStr):
                return URL(string: urlStr)
            case .pokeImage(let urlStr):
                return URL(string: urlStr)
            }
        }
        
    }
    
    func getPokeModel<T: Decodable>(url: URL?, completion: @escaping (T?) -> Void) {
        guard let pokeURL = url else {
            return
        }
        
        let urlRequest = URLRequest.init(url: pokeURL)
        
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            guard error == nil else {
                completion(nil)
                return print(error.debugDescription)
            }
            
            guard let data = data else {
                completion(nil)
                return print("No data is present!")
            }
            
            let decode = JSONDecoder()
            
            do {
                let pokemonModel = try decode.decode(T.self, from: data)
                completion(pokemonModel)
            } catch {
                print(error)
                completion(nil)
            }            
        }.resume()
        
    }
    
    func fetchImage(urlString: String, completion: @escaping (Data?)->()) {
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
                completion(nil)
                return print(error.debugDescription)
            }
            
            guard let data = data else {
                return
            }
            
            completion(data)
            
        }.resume()
        
    }
}
