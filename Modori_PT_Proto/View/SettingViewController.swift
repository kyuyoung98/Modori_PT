//
//  MainViewController.swift
//  Modori_PT_Proto
//
//  Created by 이성주 on 2022/01/25.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SettingViewController: UIViewController {
    var ref: DatabaseReference!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var resetPasswordButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = Database.database().reference()
        self.hideKeyboardWhenTappedAround()
        // 네이게이션 뒤로가기 버튼 비활성화 (로그인 후 메인 화면에서 뒤로가기 하면 ?? 어색)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 네비게이션 바 숨기기
        navigationController?.navigationBar.isHidden = true
        
        // Firebase 이메일 가져와서 출력 없으면 고객
        let email = Auth.auth().currentUser?.email ?? "고객"
        
        welcomeLabel.text = """
        환영합니다.
        \(email)님
        """
        
        // 구글 애플이 아닌 이메일 방식으로 로그인 여부 확인
        let isEmailSignIn = Auth.auth().currentUser?.providerData[0].providerID == "password"
        resetPasswordButton.isHidden = !isEmailSignIn
    }
    
    
    
        
    
    
    
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
            //self.navigationController?.popToRootViewController(animated: true)
            self.LoginViewController()
        } catch let sighOutError as NSError {
            print("LogOut 중에 Error 발생 : \(sighOutError.localizedDescription)")
        }
        
        //self.LoginViewController()
    }
    
    
    private func LoginViewController() {
    
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let loginViewController = storyboard.instantiateViewController(identifier: "InitialView")

        loginViewController.modalPresentationStyle = .fullScreen
        loginViewController.modalTransitionStyle = .flipHorizontal

        navigationController?.show(loginViewController, sender: nil)
        
    }
    
    // 비밀번호 변경 버튼을 눌렀을때 등록한 이메일로 비밀번호 초기화 메일 보냄
    @IBAction func resetPasswordButtonTapped(_ sender: UIButton) {
        let email = Auth.auth().currentUser?.email ?? ""
        Auth.auth().sendPasswordReset(withEmail: email, completion: nil)
    }
}


extension UIViewController {
    // 키보드 숨기기
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
