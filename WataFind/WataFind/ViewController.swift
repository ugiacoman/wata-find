//
//  ViewController.swift
//  WataFind
//
//  Created by Ulises Giacoman on 2/16/16.
//  Copyright © 2016 Ulises Giacoman. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tv = UITableView()
    var routes:[String] = []
    var inORout:[String] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         update()
        
        self.view.backgroundColor = UIColor(red:0.59, green:0.87, blue:0.85, alpha:1.0)
        tv = UITableView(frame: CGRect(x: 40, y: 100, width: self.view.frame.size.width-80, height: self.view.frame.size.height-240))
        tv.delegate = self
        tv.dataSource = self
        tv.backgroundColor = UIColor.clearColor()
        tv.separatorStyle = .None
        tv.allowsMultipleSelection = true
        self.view.addSubview(tv)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func update() {
        /**
        My API
        GET https://limitless-gorge-96236.herokuapp.com/
        */
        
        // Fetch Request
        Alamofire.request(.GET, "https://limitless-gorge-96236.herokuapp.com/")
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                if (response.result.error == nil) {
//                    debugPrint("HTTP Response Body: \(response.data)")
                    let json = JSON(response.result.value!)
//                    print(json)
                    for item in json["routes"].arrayValue {
                        if (item["type"].stringValue.rangeOfString("OUTBOUND") != nil) {
                            self.routes.append(item["time"].stringValue)
                            self.inORout.append("Monticello -> Caf")
                        }
                        if (item["type"].stringValue.rangeOfString("INBOUND") != nil) {
                            self.routes.append(item["time"].stringValue)
                            self.inORout.append("Sadler -> Monticello")

                        }
                        self.updateTable(self.routes)
                    }
                }
                else {
                    debugPrint("HTTP Request failed: \(response.result.error)")
                }
        }
    }
    
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func updateTable(username: [String]) {
        routes = username
        self.tv.reloadData()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        cell.backgroundColor = UIColor.clearColor()
        cell.accessoryType = .None
        cell.tintColor = UIColor.whiteColor()
        cell.selectionStyle = .None
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width-80, height: 62))
        label.font = UIFont(name: "UbuntuTitling-Bold", size: 16)
        label.textColor = UIColor.whiteColor()
        label.textAlignment = .Right
        label.text = routes[indexPath.item] //import users
        //label.backgroundColor = UIColor.redColor()
        cell.addSubview(label)
        
        let typeOf = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width-80, height: 62))
        typeOf.font = UIFont(name: "UbuntuTitling-Bold", size: 16)
        typeOf.textColor = UIColor.whiteColor()
        typeOf.textAlignment = .Left
        typeOf.text = inORout[indexPath.item] //import users
        //label.backgroundColor = UIColor.redColor()
        cell.addSubview(typeOf)
        
        let sep = UIView(frame: CGRect(x: 0, y: 59, width: cell.frame.size.width, height: 1))
        sep.backgroundColor = UIColor.whiteColor()
        cell.addSubview(sep)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)!.accessoryType = .Checkmark;
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)!.accessoryType = .None;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routes.count
    }


}

