//
//  LoginManger.swift
//  MeInfoGram
//
//  Created by Moban Michael on 20/11/2020.
//

import Foundation

class LoginManager {
    
    static let shared :LoginManager = LoginManager()
    
    enum AuthenticationState {
        case loggedin, loggedout
    }

    var state = AuthenticationState.loggedout {

        didSet {
            print(state)
        }
    }

}
