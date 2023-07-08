//
//  CameraViewController.swift
//  Modori_PT_Proto
//
//  Created by 이성주 on 2022/01/27.
//

import UIKit

class MenuTabController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 네이게이션 뒤로가기 버튼 비활성화 (로그인 후 메인 화면에서 뒤로가기 하면 ?? 어색)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 네비게이션 바 숨기기
        navigationController?.navigationBar.isHidden = true
        
    }
    
}
