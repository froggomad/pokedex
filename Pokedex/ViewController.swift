//
//  ViewController.swift
//  Pokedex
//
//  Created by Kenneth Dubroff on 6/8/17.
//  Copyright © 2017 Hazy Studios Development LLC. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
  
  @IBOutlet weak var collection: UICollectionView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  var player: AVAudioPlayer!
  var pokemon = [Pokemon]()
  var filteredPokemon = [Pokemon]()
  var inSearchMode = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collection.dataSource = self
    collection.delegate = self
    searchBar.delegate = self
    
    searchBar.returnKeyType = UIReturnKeyType.done
    
    parsePokemonCSV()
    initAudio()
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    view.endEditing(true)
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchBar.text == nil || searchBar.text == "" {
      inSearchMode = false
      collection.reloadData()
      view.endEditing(true)
    } else {
      inSearchMode = true
      let lower = searchBar.text!.lowercased()
      filteredPokemon = pokemon.filter({$0.name.range(of:lower) != nil})
      collection.reloadData()
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    print("started")
    if segue.identifier == "PokemonDetailVC" {
      print("segueID Check passed")
      if let detailsVC = segue.destination as? PokemonDetailVC {
        print("destination passed")
        if let poke = sender as? Pokemon {
          print("data passed")
          detailsVC.pokemon = poke
        }
      }
    }
  }
  
  @IBAction func musicBtn(_ sender: UIButton) {
    if player.isPlaying {
      player.pause()
      sender.alpha = 0.75
    } else {
      player.play()
      sender.alpha = 1.0
    }
  }
  
  func initAudio() {
    let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
    do {
      player = try AVAudioPlayer(contentsOf: URL(string: path)!)
      player.prepareToPlay()
      player.numberOfLoops = -1
      player.play()
    } catch let err as NSError {
      print(err.debugDescription)
    }
  }
  
  func parsePokemonCSV() {
    let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
    
    do {
      let csv = try CSV(contentsOfURL: path!)
      let rows = csv.rows
      
      for row in rows {
        let pokeID = Int(row["id"]!)!
        let name = row["identifier"]!
        let poke = Pokemon(name: name, pokedexId: pokeID)
        pokemon.append(poke)
      }
      
    } catch let err as NSError {
      print(err.debugDescription)
    }
    
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
      let poke : Pokemon!
      
      if inSearchMode {
        poke = filteredPokemon[indexPath.row]
        cell.configureCell(pokemon: poke)
      } else {
        poke = pokemon[indexPath.row]
        cell.configureCell(pokemon: poke)
      }
      return cell
    } else {
      return UICollectionViewCell()
    }
    
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print("called")
    var poke: Pokemon!
    
    if inSearchMode {
      poke = filteredPokemon[indexPath.row]
    } else {
      poke = pokemon[indexPath.row]
    }
    print("bingo")
    performSegue(withIdentifier: "PokemonDetailVC", sender: poke)
    
    
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if inSearchMode {
      return filteredPokemon.count
    }
    return pokemon.count    
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 105, height: 105)
  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}
