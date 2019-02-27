//
//  ViewController.swift
//  GmailLoginApp
//
//  Created by Savannah Stoughton on 2/27/19.
//  Copyright © 2019 Savannah Stoughton. All rights reserved.
//

import UIKit
import GoogleSignIn


class ViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {

    
    //IBoutlets
    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var disconnectButton: UIButton!
    @IBOutlet weak var statusText: UILabel!
    
    func toggleAuthUI() {
        if GIDSignIn.sharedInstance().hasAuthInKeychain() {
            //Signed in
            signInButton.isHidden = true
            signOutButton.isHidden = false
            disconnectButton.isHidden = false
        } else {
            signInButton.isHidden = false
            signOutButton.isHidden = true
            signOutButton.isHidden = true
            statusText.text = "Google Sign in\niOS Demo"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
        statusText.text = "Initialized Swift app..."
        
        toggleAuthUI()
    }

    //method required for GIDSignInDelegate
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error:Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            //perform any operations on signed in user here
            //for client-side use only
            let userId = user.userID
            //safe to send to the server
            let idToken = user.authentication.idToken
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            print(userId!,"",idToken!,"",fullName!,"",givenName!,"",familyName!,"",email!)
            statusText.text = fullName!
            toggleAuthUI()
        }
    }
    
    //other method required for GIDSignInDelegate
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error:Error!) {
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapSignOut(_ sender: AnyObject) {
        GIDSignIn.sharedInstance().signOut()
        
        statusText.text = "Signed out."
        toggleAuthUI()
    }

    @IBAction func didTapDisconnect(_ sender: AnyObject) {
        GIDSignIn.sharedInstance().disconnect()
        statusText.text = "Disconnecting."
    }

}

