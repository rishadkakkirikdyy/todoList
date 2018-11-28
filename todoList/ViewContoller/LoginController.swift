//
//  LoginController.swift
//  todoList
//
//  Created by rishad k on 28/11/18.
//  Copyright © 2018 Riley Norris. All rights reserved.
//

import UIKit
import FBSDKLoginKit
class LoginController: UIViewController,FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var labellogginedStatus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //creating the facebook login button
        let btnFBlogin = FBSDKLoginButton()
        btnFBlogin.readPermissions=["public_profile","email","user_friends"]
        btnFBlogin.center=self.view.center
        btnFBlogin.delegate=self
        self.view.addSubview(btnFBlogin)
        
        
        if FBSDKAccessToken.current() != nil
        {self.labellogginedStatus.text="loggined in"}
        else
        {self.labellogginedStatus.text="Not logged in"}
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil{
            self.labellogginedStatus.text=error.localizedDescription
            
        }
        else if result.isCancelled
        {labellogginedStatus.text="User cancelled log in"}
        else
        {
            //if the login is sccess the it will rediracting to our task list page
            self.labellogginedStatus.text="User logged in"
            let homeController=self.storyboard?.instantiateViewController(withIdentifier: "HomeNavigation_ID") as! UINavigationController
            self.present(homeController, animated: false, completion: nil)
            
            
        }
    }
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        self.labellogginedStatus.text="User logged out"
    }
    
    
    
}
