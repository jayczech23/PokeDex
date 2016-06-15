//
//  PokeCell.swift
//  THE_PokeDex
//
//  Created by Jordan Cech on 6/2/16.
//  Copyright © 2016 Jordan Cech. All rights reserved.
//
//  Custom Collection View Cell!

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //make corners of images rounded.
        layer.cornerRadius = 5.0
    }
    
    func configureCell(pokemon: Pokemon) {
        self.pokemon = pokemon
        
        nameLbl.text = self.pokemon.name.capitalizedString
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexID)")
        
        
    }
    
}
