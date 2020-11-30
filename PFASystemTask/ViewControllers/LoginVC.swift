//
//  LoginVC.swift
//  PFASystemTask
//
//  Created by Velozion Mac on 03/July/2019A.
//

import UIKit
import FirebaseAuth

// Login credentials
// username : manager@gmail.com, password : manager
// username : employer@gmail.com, password : employer
// username : employee@gmail.com, password : employee

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
                    getResponse { (result) in
                        switch result {
                        case .success(let response):
                            for data in response["articles"] as! [[String: Any]] {
                                responseData.append(data)
                            }
                            print(response)
                        case .failure(let error):
                            print(error)
                        }
                        print(responseData)
                        for details in responseData {
                            if details["urlToImage"] as? String != nil {
                                bannerImage.append(details["urlToImage"] as! String)
                            }
                        }
                        DispatchQueue.main.async {
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReponseVC") as! ReponseVC
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                } else {
                    self.displayAlertMsg(title: "Invalid user", message: "Enter valid username and password")
                }
            }
        } else {
            displayAlertMsg(title: "", message: "Fill all the fields")
        }
    }
}
