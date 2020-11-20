//
//  MyInfo.swift
//  MeInfoGram
//
//  Created by Moban Michael on 20/11/2020.
//

import Foundation

enum Type : String{
    
    case Password   = "Password"
    case Info       = "info"
    
}

enum Category : String{
    
    case India          = "India"
    case UK             = "UK"
    case Bank           = "Banking"
    case OnlineShopping = "Online Shopping"
    
}

struct MyInfo: Equatable {
    
    var items : [Item]
    var category: Category
    
    init(item: [Item],category:Category) {
        
        self.items       = item
        self.category   = category
    }
}

struct Item: Equatable  {
    
    var ID          : String
    var type        : Type
    var category    : Category
    var headerTitle : String
    var userName    : String
    var password    : String
    var subValues   : [(String,String)]
    
    init(ID: String = UUID().uuidString,type: Type,category:Category , headerTitle: String, userName: String = "",password: String = "",subValues: [(String,String)] = []) {
        
        self.ID             = ID
        self.type           = type
        self.category       = category
        self.headerTitle    = headerTitle
        self.userName       = userName
        self.password       = password
        self.subValues      = subValues
    }
    
    static func ==(lhs: Item, rhs: Item) -> Bool {
        return lhs.ID == rhs.ID
    }
}
