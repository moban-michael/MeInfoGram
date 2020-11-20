//
//  LoginViewController.swift
//  MeInfoGram
//
//  Created by Moban Michael on 20/11/2020.
//

import Foundation
import UIKit
import LocalAuthentication

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginWithFaceIDButton: UIButton!
    @IBOutlet weak var loginWithAppleButton: UIButton!
    
    var context = LAContext()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK: UI
    fileprivate func setUpUI(){
        self.loginWithAppleButton.layer.cornerRadius = 10
        self.loginWithFaceIDButton.layer.cornerRadius = 10
    }
    
    
    @IBAction func loginWithFaceIDTapped(_ sender: Any) {
        self.loginWithFaceID()
    }
    
    @IBAction func loginWithAppleTapped(_ sender: Any) {
        self.loginWithAppleID()
    }
}

private typealias LoginWithFaceID = LoginViewController
extension LoginWithFaceID {
        
    func loginWithFaceID(){
        
        context = LAContext()
        context.localizedCancelTitle = "Sign in with Apple "
        var errorDesc = "Failed to authenticate"
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            
            let reason = "Log in to your account"
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason ) { success, error in
                
                if success {
                    // Move to the main thread because a state update triggers UI changes.
                    DispatchQueue.main.async { [unowned self] in
                        LoginManager.shared.state = .loggedin
                        performSegue(withIdentifier: "showMyInfo", sender: nil)
                    }
                } else {
                    errorDesc = "Failed to authenticate"
                    print(error?.localizedDescription ?? errorDesc)
                    self.loginWithAppleID()
                }
            }
        } else {
            errorDesc = "Can't evaluate policy"
            print(error?.localizedDescription ?? errorDesc)
            self.showAlert(errorDesc)
            LoginManager.shared.state = .loggedout
        }
    }
    
    func loginWithAppleID(){
        self.showAlert("Login with Apple")
        //performSegue(withIdentifier: "showMyInfo", sender: sender)
    }
}
