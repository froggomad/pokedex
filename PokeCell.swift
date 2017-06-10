//
//  PokeCell.swift
//  Pokedex
//
//  Created by Kenneth Dubroff on 6/8/17.
//  Copyright © 2017 Hazy Studios Development LLC. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
  @IBOutlet weak var thumbImg: UIImageView!
  @IBOutlet weak var nameLbl: UILabel!
  
  var pokemon: Pokemon!
  
  required init?(coder aDecoder: NSCoder){
    super.init(coder: aDecoder)
    
    layer.cornerRadius = 15.0
  }
  
  
  func configureCell(pokemon: Pokemon) {
    self.pokemon = pokemon
    nameLbl.text = self.pokemon.name.capitalized
    thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
    
  }
}
