//
//  PensamentosGerenciador.swift
//  Pensamentos
//
//  Created by Lucas Azevedo on 10/07/20.
//  Copyright © 2020 Lucas Azevedo. All rights reserved.
//

import Foundation

class PensamentosGerenciador {
    
    let quotes: [Quotes]
    
    init() {
        
        let fileURL = Bundle.main.url(forResource: "quotes", withExtension: "json")!
        let jsonData = try! Data(contentsOf: fileURL)
        let jsonDecoder = JSONDecoder()
        quotes = try! jsonDecoder.decode([Quotes].self, from: jsonData)
        
    }
    
    func getQuoteRandom () -> Quotes {
        
        let index = Int(arc4random_uniform(UInt32(quotes.count)))
        return quotes[index]
    }
    
}
