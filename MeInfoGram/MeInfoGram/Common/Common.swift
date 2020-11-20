//
//  Common.swift
//  moBz
//
//  Created by Moban Michael on 19/11/2020.
//

import Foundation

func onMainQueue(_ closure: @escaping () -> Void) {
    DispatchQueue.main.async {
        closure()
    }
}

class Common {
    
    
}
