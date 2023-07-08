//
//  MyDetailViewController.swift
//  Modori_PT_Proto
//
//  Created by 이성주 on 2022/05/09.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class MyDetailViewController: UIViewController {
    
    var gender: String = ""
    let email = Auth.auth().currentUser?.email ?? "고객"
    
    
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var selectGender: UISegmentedControl!
    @IBOutlet weak var userWeightLabel: UITextField!
    @IBOutlet weak var userPhoneLabel: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var ref: DatabaseReference!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = Database.database().reference()
        self.hideKeyboardWhenTappedAround()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Navigaion Bar 보이기
        navigationController?.navigationBar.isHidden = false
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        
        userEmailLabel.text = """
        환영합니다.
        \(email)님
        """
        
        
        
    }
    
    @IBAction func genderSelected(_ sender: Any) {
        
        switch selectGender.selectedSegmentIndex
            {
            case 0:
                gender = "남성"
            case 1:
                gender = "여성"
            default:
                break
            }
    }
    
   

    @IBAction func saveButtonTapped(_ sender: UIButton) {
        let weights = userWeightLabel.text ?? ""
        let phoneNumber = userPhoneLabel.text ?? ""
        let name = userNameLabel.text ?? ""
        let uid = Auth.auth().currentUser?.uid ?? "UID"
        
        self.ref.child("Info/Users/\(uid)/Email").setValue(email)
        self.ref.child("Info/Users/\(uid)/Name").setValue(name)
        self.ref.child("Info/Users/\(uid)/weight").setValue(weights)
        self.ref.child("Info/Users/\(uid)/phoneNumber").setValue(phoneNumber)
        self.ref.child("Info/Users/\(uid)/Gender").setValue(gender)
    }
    
}
