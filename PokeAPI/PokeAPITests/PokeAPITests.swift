//
//  PokeAPITests.swift
//  PokeAPITests
//
//  Created by Roderick Presswood on 1/12/22.
//

import XCTest
@testable import PokeAPI

class PokeAPITests: XCTestCase {
    
    var model: PokemonViewModel!
    var viewController: PokeTableViewController!
    var pokeView: SwiftUIView!
    
    
    func loadMock() -> PokemonPage {
        guard let path = Bundle(for: PokeAPITests.self).path(forResource: "Pokemon", ofType: "json"), let data = try? Data(contentsOf: URL(fileURLWithPath: path)), let response = try? JSONDecoder().decode(PokemonPage.self, from: data)  else { fatalError("Cannot find Pokemon.json file") }
        return response
    }
    
    override func setUp() {
        let pokemon = loadMock().results
        model = PokemonViewModel(pokemon: pokemon)
        viewController = PokeTableViewController()
        pokeView = SwiftUIView()
    }
    
    override func tearDown() {
        model = nil
        viewController = nil
        pokeView = nil
    }
    
    func testMockResponseInVM() {
        XCTAssertEqual(model.getPokemonCount(), 30)
        XCTAssertEqual(model.getPokemonName(at: 0), "bulbasaur")
        XCTAssertEqual(model.getPokemonName(at: 29), "nidorina")
    }
    
    func testSwiftUIView() {
        let text = pokeView.subText
        XCTAssertEqual(text, "Gotta Catch em all!")
        let body = pokeView.body
        XCTAssertNotNil(body, "Did not find body")
    }
}
