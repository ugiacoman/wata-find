//: Playground - noun: a place where people can play

import UIKit
import Alamofire
import SwiftyJSON

var str = "Hello, playground"

Alamofire.request(.GET, "https://limitless-gorge-96236.herokuapp.com/")
    .validate(statusCode: 200..<300)
    .responseJSON { response in
        if (response.result.error == nil) {
            //                    debugPrint("HTTP Response Body: \(response.data)")
            let json = JSON(response.result.value!)
            //                    print(json)
            print(json["routes"])
        }
        else {
            debugPrint("HTTP Request failed: \(response.result.error)")
        }
}
