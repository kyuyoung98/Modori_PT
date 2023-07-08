//
//  AppDelegate.swift
//  Modori_PT_Proto
//
//  Created by 이성주 on 2022/01/25.
//

import UIKit
import Firebase
import GoogleSignIn
// import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Fire base 초기화 코드
        FirebaseApp.configure()
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("ERROR Google Sign In \(error.localizedDescription)")
            return
        }
        
        // 구글로부터 로그인 인증값 받아옴.
        guard let authentication = user.authentication else { return }
        
        // 구글 accessToken 부여받음
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { _, _ in
            self.showMainViewController()
        }
    }
    
    private func showMainViewController() {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let menuTabController = storyboard.instantiateViewController(identifier: "MenuTabController")
            menuTabController.modalPresentationStyle = .fullScreen
            UIApplication.shared.windows.first?.rootViewController?.show(menuTabController, sender: nil)
        }




}

