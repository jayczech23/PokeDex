//
//  ViewController.swift
//  THE_PokeDex
//
//  Created by Jordan Cech on 6/2/16.
//  Copyright © 2016 Jordan Cech. All rights reserved.
//


import UIKit
import AVFoundation

//each protocol has their own methods. 
class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
                                            // ^         Protocols to enable use of CollectionView.      ^
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    var inSearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.delegate = self
        collection.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.Done 
        
        initAudio()
        parsePokemonCSV()
      
        
    }
//----------------------------------------------------------------------------------------
    //play audio on app startup.
    func initAudio() {
    
        let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")!
        
        do {
            
            musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1 //infinite loop
            musicPlayer.play()
        
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    
    }
    
    
//----------------------------------------------------------------------------------------
    
    //grab the csv file and run parser on it.
    func parsePokemonCSV() {
        
        //grab the PATH of the csv file (location)
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            //iterate through all the rows.
            for row in rows {
                //go into row, fetch pokeID from csv file. CONVERT into integer. (array of dictionaries.)
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]! //grab NAME of pokemon
                let poke = Pokemon(name: name, pokedexID: pokeId)
                pokemon.append(poke) //add pokemon to array of pokemon.
            }
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
//----------------------------------------------------------------------------------------
                                                                                                 //return cell (below)
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
                        //remember, to save memory, the OS reuses cells, so this grabs a free cell and puts it back onto the screen for use.
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell {
            
            //common line for
            let poke: Pokemon!
            
            if inSearchMode {
                poke = filteredPokemon[indexPath.row]
            } else {
                poke = pokemon[indexPath.row]
            }
            
            cell.configureCell(poke)
            return cell //if successfully able to grab cell of PokeCell type.
            
        } else {
            return UICollectionViewCell() //return generic CollectionView Cell.
        }
    
    
    }
//----------------------------------------------------------------------------------------
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        var poke: Pokemon!
        
        if inSearchMode {
            poke = filteredPokemon[indexPath.row]
        } else {
            poke = pokemon[indexPath.row]
        }
        
        
        performSegueWithIdentifier("PokemonDetailVC", sender: poke)
    }
//----------------------------------------------------------------------------------------
    
    //how many items in collection view. NEVER hard code! SHOULD ALWAYS BE DYNAMIC!
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            return filteredPokemon.count
        }
        return pokemon.count
        
    }
//----------------------------------------------------------------------------------------
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
//----------------------------------------------------------------------------------------
    //set the size of the grid.
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(105, 105)
    }
//----------------------------------------------------------------------------------------
    @IBAction func musicBtnPressed(sender: UIButton!) {
        
        if musicPlayer.playing {
            musicPlayer.stop()
            sender.alpha = 0.2 //faded
        } else {
            musicPlayer.play()
            sender.alpha = 1.0 //fully opaque
        }
        
    }
//----------------------------------------------------------------------------------------
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    
    
//----------------------------------------------------------------------------------------
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        //make a second array to hold the FILTERED pokemon.
        if(searchBar.text == nil || searchBar.text == "") {
            inSearchMode = false
            view.endEditing(true)
            collection.reloadData() //when text all deleted, TURN OFF SEARCH MODE.
        } else {
            inSearchMode = true
            let lower = searchBar.text!.lowercaseString
            
            //check if the word typed in exists.
            filteredPokemon = pokemon.filter({$0.name.rangeOfString(lower) != nil}) //go through the array, grab element's name, add to filteredPokemon if it exists.
            
            //refresh the list of data.
            collection.reloadData()
        }

        
        
    }
//----------------------------------------------------------------------------------------
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //grab destination viewController and cast as PokemonDetailVC. 
        //Then stuff 'poke' object into PokemonDetailVC.
        if segue.identifier == "PokemonDetailVC" {
            if let detailsVC = segue.destinationViewController as? PokemonDetailVC {
                if let poke = sender as? Pokemon {
                    detailsVC.pokemon = poke
                }
            }
        }
        
    }
    


}

