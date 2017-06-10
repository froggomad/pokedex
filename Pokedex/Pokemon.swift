//
//  Pokemon.swift
//  Pokedex
//
//  Created by Kenneth Dubroff on 6/8/17.
//  Copyright © 2017 Hazy Studios Development LLC. All rights reserved.
//

import Foundation

class Pokemon {
  private var _name: String!
  private var _pokedexId: Int!
  
  var name: String {
    
    return _name
  }
  
  var pokedexId: Int {
    
    return _pokedexId
    
  }
  
  init(name: String, pokedexId: Int) {
    self._name = name
    self._pokedexId = pokedexId
  }
}
