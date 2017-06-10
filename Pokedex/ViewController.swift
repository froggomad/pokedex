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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collection.dataSource = self
    collection.delegate = self
    searchBar.delegate = self
    
    parsePokemonCSV()
    initAudio()
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
      print(rows)
      
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
      
      let poke = pokemon[indexPath.row]
      cell.configureCell(pokemon: poke)
      
      return cell
    } else {
      return UICollectionViewCell()
    }
    
  }
  
  func collectionView(_collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
