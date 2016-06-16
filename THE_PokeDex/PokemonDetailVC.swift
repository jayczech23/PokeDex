//
//  PokemonDetailVC.swift
//  THE_PokeDex
//
//  Created by Jordan Cech on 6/14/16.
//  Copyright © 2016 Jordan Cech. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    
    
    
    var pokemon: Pokemon!

    override func viewDidLoad() {
        super.viewDidLoad()

        nameLbl.text = pokemon.name.capitalizedString
        var img = UIImage(named: "\(pokemon.pokedexID)")
        mainImg.image = img
        currentEvoImg.image = img
        
        
       pokemon.downloadPokemonDetails {
            //this will be called AFTER download is done
            //update fields with corresponding data.
            self.updateUI()
        
        }
    }
   
    
    func updateUI() {
        
        if let description = pokemon.description {
            descriptionLbl.text = pokemon.description
            typeLbl.text = pokemon.type
            defenseLbl.text = pokemon.defense
            heightLbl.text = pokemon.height
            pokedexLbl.text = "\(pokemon.pokedexID)"
            weightLbl.text = pokemon.weight
            attackLbl.text = pokemon.attack
            
            
            
            if pokemon.nextEvolutionId == "" {
                evoLbl.text = "No Evolution"
                nextEvoImg.hidden = true
            } else {
                nextEvoImg.hidden = false
                nextEvoImg.image = UIImage(named: pokemon.nextEvolutionId)
                var str = "Next Evolution: \(pokemon.nextEvolutionTxt)"
                
                if pokemon.nextEvolutionLvl != "" {
                    str += " - LVL \(pokemon.nextEvolutionLvl)"
                    evoLbl.text = str
                }
            }
            
        }
    }
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
