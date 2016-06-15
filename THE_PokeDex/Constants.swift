//
//  Constants.swift
//  THE_PokeDex
//
//  Created by Jordan Cech on 6/15/16.
//  Copyright © 2016 Jordan Cech. All rights reserved.
//
//  Globally accessible!

import Foundation

//base URL
let URL_BASE = "http://pokeapi.co"
let URL_POKEMON = "/api/v1/pokemon/"

//Create a closure! (block of code that is called in a specified place.)
//Call when a download of data is complete.
public typealias DownloadComplete = () -> ()