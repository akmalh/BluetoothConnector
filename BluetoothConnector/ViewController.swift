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
    var pManager = CBPeripheral()

    @IBOutlet weak var outputTextView: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tLog("BlueTooth LE Device Scanner\r\n\r\nProgramming the Internet of Things for iOS")
        self.bluetoothOn = false
        //self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
        self.cManager = CBCentralManager(delegate: self, queue: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func centralManagerDidUpdateState(central: CBCentralManager!) {
        
        if (central.state != CBCentralManagerState.PoweredOn) {
            self.tLog("Bluetooth Off")
            self.bluetoothOn = false
        }
        else {
            self.tLog("Bluetooth On")
            self.bluetoothOn = true
        }
        
    }
    
    func tLog(msg: String) {
        self.outputTextView.text = "\r\n\r\n".stringByAppendingString(self.outputTextView.text)
        self.outputTextView.text = msg.stringByAppendingString(self.outputTextView.text)
    }
    
    @IBAction func startAction(sender: UIButton!) {
        
        if (!self.bluetoothOn)
        {
            self.tLog("Bluetooth is off")
            return
        }
        
        cManager.scanForPeripheralsWithServices(nil, options: nil)
    }
    
    func centralManager(central: CBCentralManager!, didDiscoverPeripheral peripheral: CBPeripheral!, advertisementData: [NSObject : AnyObject]!, RSSI: NSNumber!) {
        
        
        var advData = advertisementData.indexForKey("kCBAdvDataLocalName")
        self.tLog("Discovered \(advData), RSSI: \(RSSI)\n")
        pManager = peripheral
        
        //self.centralManager.connectPeripheral(peripheral, options: nil)
        cManager.connectPeripheral(peripheral, options: nil)
        
    }
    
    func centralManager(central: CBCentralManager!, didFailToConnectPeripheral peripheral: CBPeripheral!, error: NSError!) {
        
        self.tLog("Fail to connect")
        
    }
    
    func centralManager(central: CBCentralManager!, didConnectPeripheral peripheral: CBPeripheral!) {
        
        peripheral.delegate = self
        //pManager.discoverServices(nil)
        peripheral.discoverServices(nil)
    }

    func peripheral(peripheral: CBPeripheral!, didDiscoverServices error: NSError!) {
        
        if((error) != nil)
        {
            self.tLog("\(error.description)")
            return
        }
        
//        for service: CBService in peripheral.services {
//            self.tLog("Discovered Service: \(service.description())")
//            peripheral.discoverCharacteristics(nil, forService: service)
//        }
        
        for service in peripheral.services{
            
            self.tLog("Discovered Service: \(service.description)")
            peripheral.discoverCharacteristics(nil, forService: service as! CBService)
        
        }
        
    }
    
    func peripheral(peripheral: CBPeripheral!, didDiscoverCharacteristicsForService service: CBService!, error: NSError!) {
        
        if((error) != nil)
        {
            self.tLog("\(error.description)")
            return
        }
        
//        for characteristic: CBCharacteristic in service.characteristics{
//            self.tLog("Characteristics Found: \(characteristic.description())")
//        }
        
        for characteristic in service.characteristics {
           
            self.tLog("Characteristics Found: \(characteristic.description)")
            
        }
        
    }
    
    func peripheral(peripheral: CBPeripheral!, didUpdateValueForCharacteristic characteristic: CBCharacteristic!, error: NSError!) {
        
    }
    
    

}

