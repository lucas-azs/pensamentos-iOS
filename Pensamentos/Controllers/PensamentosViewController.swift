//
//  PensamentosViewController.swift
//  Pensamentos
//
//  Created by Lucas Azevedo on 10/07/20.
//  Copyright © 2020 Lucas Azevedo. All rights reserved.
//

import UIKit

class PensamentosViewController: UIViewController {
    
    @IBOutlet weak var ivFoto: UIImageView!
    @IBOutlet weak var ivFotoBG: UIImageView!
    @IBOutlet weak var lbPensamentos: UILabel!
    @IBOutlet weak var lbAutor: UILabel!
    @IBOutlet weak var ctTop: NSLayoutConstraint!
    
    let pensamentosGerenciador = PensamentosGerenciador()
    
    var time: Timer?
    
    let config = ConfigPensamentos.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "Refresh"), object: nil, queue: nil) { (Notification) in
            self.formatView()
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        formatView()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        prepareQuote()
    }
    
    func prepareQuote() {
        time?.invalidate()
        
        if config.autoRefresh {
            time = Timer.scheduledTimer(withTimeInterval: config.timeInterval, repeats: true, block: { (time) in
                self.showRandomQuote()
            })
        }
        
        showRandomQuote()
        
    }
    
    func formatView() {
        view.backgroundColor = config.colorScheme == 0 ? .white : UIColor(red: 156.0/255.0, green: 68.0/255.0, blue: 15.0/255.0, alpha: 1.0)
        
        lbPensamentos.textColor = config.colorScheme == 0 ? .black : .white
        lbAutor.textColor = config.colorScheme == 0 ? UIColor(red: 192.0/255.0, green: 96.0/255.0, blue: 49.0/255.0, alpha: 1.0) : .yellow
        
        prepareQuote()
        
    }
    
    func showRandomQuote() {
        let quote = pensamentosGerenciador.getQuoteRandom()
        lbPensamentos.text = quote.quote
        lbAutor.text = quote.author
        ivFoto.image = UIImage(named: quote.image)
        ivFotoBG.image = ivFoto.image
        
        lbPensamentos.alpha = 0.0
        lbAutor.alpha = 0.0
        ivFoto.alpha = 0.0
        ivFotoBG.alpha = 0.0
        ctTop.constant = 50
        view.layoutIfNeeded()
        
        UIView.animate(withDuration: 2.5) {
            self.lbPensamentos.alpha = 1.0
            self.lbAutor.alpha = 1.0
            self.ivFoto.alpha = 1.0
            self.ivFotoBG.alpha = 0.25
            self.ctTop.constant = 10
            self.view.layoutIfNeeded()
        }
        
    }

}
