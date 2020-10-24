//
//  SignInVC.swift
//  FitMove
//
//  Created by Peter Andrew on 14/10/20.
//

import UIKit


class SignInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.performSegue(withIdentifier: "toHomeScreen", sender: false)
    }

    @IBAction func signIn(_ sender: UIButton) {
        Auth.login(authVC: self) { err, data in
            if err == nil {
                self.performSegue(withIdentifier: "toHomeScreen", sender: true)
            } else {
                // ERROR (V.2) add Error Message
            }
        }
    }
    
    
    private func performSegueIfLoggedIn() {
        if (self.userIsLoggedIn()) {
            print("heelo")
            performSegue(withIdentifier: "toHomeScreen", sender: nil)
        }
    }
    
    
    private func userIsLoggedIn()->Bool {
        return LocalDB.getTokenID() != nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            case "toHomeScreen": break
            case .none: break
            case .some(_): break
        }
    }
}

