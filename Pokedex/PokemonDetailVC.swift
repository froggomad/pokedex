//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Kenneth Dubroff on 6/10/17.
//  Copyright © 2017 Hazy Studios Development LLC. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
  
  @IBOutlet weak var nameLbl: UILabel!
  
  var pokemon: Pokemon!

    override func viewDidLoad() {
      nameLbl.text = pokemon.name
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

  }
