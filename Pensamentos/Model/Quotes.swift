//
//  Pensamentos.swift
//  Pensamentos
//
//  Created by Lucas Azevedo on 10/07/20.
//  Copyright © 2020 Lucas Azevedo. All rights reserved.
//

import Foundation

struct Quotes: Codable {
    
    let quote: String
    let author: String
    let image: String
    
    var quoteFormatado: String {
        return " “" + quote + "” "
    }
    
    var authorFormatado: String {
        return "- " + author + " -"
    }
    
}
