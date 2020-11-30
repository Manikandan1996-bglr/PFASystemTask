//
//  LoginVC.swift
//  PFASystemTask
//
//  Created by Velozion Mac on 03/July/2019A.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var passWord: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func displayAlertMsg(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    @IBAction func siginTapped(_ sender: Any) {
        if userName.text?.isEmpty == false && passWord.text?.isEmpty == false {
            Auth.auth().signIn(withEmail: userName.text!, password: passWord.text!) { (user, error) in
                if error == nil {
                    print("Suucessfully logedin")
                    
                } else {
                    self.displayAlertMsg(title: "Invalid user", message: "Enter valid username and password")
                }
            }
        } else {
            displayAlertMsg(title: "", message: "Fill all the fields")
        }
    }
}
