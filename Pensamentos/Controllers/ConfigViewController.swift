//
//  ConfigViewController.swift
//  Pensamentos
//
//  Created by Lucas Azevedo on 10/07/20.
//  Copyright © 2020 Lucas Azevedo. All rights reserved.
//

import UIKit

class ConfigViewController: UIViewController {
    
    @IBOutlet weak var swAutomatico: UISwitch!
    @IBOutlet weak var slMudarApos: UISlider!
    @IBOutlet weak var scEsquemaCores: UISegmentedControl!
    @IBOutlet weak var lbIntervaloTempo: UILabel!
    
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
    
    func formatView() {
        swAutomatico.setOn(config.autoRefresh, animated: false)
        slMudarApos.setValue(Float(config.timeInterval), animated: false)
        scEsquemaCores.selectedSegmentIndex = config.colorScheme
        changeTimeinterval(with: config.timeInterval)
        
    }
    
    func changeTimeinterval(with value: Double) {
        lbIntervaloTempo.text = "Mudar após \(Int(value)) segundos"
        
    }
    
    @IBAction func acaoMudarAuto(_ sender: UISwitch) {
        config.autoRefresh = sender.isOn
    }
    
    @IBAction func acaoMudarTempo(_ sender: UISlider) {
        let value = Double(round(sender.value))
        changeTimeinterval(with: value)
        config.timeInterval = value
    }
    
    @IBAction func acaoEsquemaCores(_ sender: UISegmentedControl) {
        config.colorScheme = sender.selectedSegmentIndex
    }
    
}
