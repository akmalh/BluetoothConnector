//
//  ViewController.swift
//  BluetoothConnector
//
//  Created by Akmal Hossain on 25/08/2015.
//  Copyright (c) 2015 Akmal Hossain. All rights reserved.
//

import UIKit
import CoreBluetooth


class ViewController: UIViewController , CBCentralManagerDelegate, CBPeripheralDelegate{
    
    var bluetoothOn: Bool = false
    var cManager = CBCentralManager()
    var pManager = CBPeripheralManager()

    @IBOutlet weak var outputTextView: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func centralManagerDidUpdateState(central: CBCentralManager!) {
        
    }
    
    func tLog(msg: String) {
        self.outputTextView.text = "\r\n\r\n".stringByAppendingString(self.outputTextView.text)
        self.outputTextView.text = msg.stringByAppendingString(self.outputTextView.text)
    }
    
    @IBAction func startAction(sender: AnyObject) {
        
        if (!self.bluetoothOn)
        {
            self.tLog("Bluetooth is off")
            return
        }
        
        cManager.scanForPeripheralsWithServices(nil, options: nil)
    }


}

