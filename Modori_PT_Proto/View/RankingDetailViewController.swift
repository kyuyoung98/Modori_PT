//
//  RankingDetailViewController.swift
//  Modori_PT_Proto
//
//  Created by 이성주 on 2022/03/15.
//

import UIKit
import Lottie
import Firebase

class RankingDetailViewController: UIViewController {
    var ExerciseList:[String : Int64] = [:]
    var PointList:[String:Int64] = [:]
    var Mets:[String:Double] = [:]
    
    var exerciseDetail: ExerciseDetail?
    
    @IBOutlet weak var lottieView: AnimationView!
    @IBOutlet weak var squatPoints: UILabel!
    @IBOutlet weak var lungePoints: UILabel!
    @IBOutlet weak var crunchPoints: UILabel!
    @IBOutlet weak var jumping_jacksPoints: UILabel!
    
    
    let ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ref.child("Mets").observe(DataEventType.value, with: { snapshot in
            var k = snapshot.value  as! [String:Double]
            k.forEach{
                self.Mets[String(($0).key)] = ($0).value
            }
        })

        //// Add lottie
//        let animationView = AnimationView(name: "dumbell")
//        lottieView.contentMode = .scaleAspectFit
//        lottieView.addSubview(animationView)
//        animationView.frame = lottieView.bounds
//        animationView.loopMode = .loop
//        animationView.play()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let uid = Auth.auth().currentUser?.uid ?? "UID"
        
        ref.child("Info/Users/\(uid)/weight").observe(DataEventType.value, with: { snapshot in
//            print(snapshot.value)
            let wei = snapshot.value as? Int ?? 60;

            var total = Int64(0)
            self.ExerciseList.forEach{
                var middle = 3.5*(Double(self.Mets[String(($0).key)] ?? 0))*Double(wei)/100
                middle *= (Double(($0).value)/12)
                self.PointList[String(($0).key)] = Int64(round(middle))
            }
            self.PointList.forEach{
                self.ref.child("Rank/Users/\(uid)/EachPoints/\(($0).key)").setValue(($0).value)
            }
            self.crunchPoints.text =
            "\(String(self.PointList["Crunch"] ?? 0))"
            
            self.lungePoints.text =
            "\(String(self.PointList["Lunge"] ?? 0))"
            
            self.squatPoints.text =
            "\(String( self.PointList["Squat"] ?? 0))"
            
            self.jumping_jacksPoints.text =
            "\(String( self.PointList["Jumping_Jacks"] ?? 0))"
        
            
 
            for i in self.PointList{
                total+=i.value
            }
            self.ref.child("Rank/Users/\(uid)/TotalPoint").setValue(total)
        })
        //4. 이름 달아주기(info에서)
        //5. 데이터베이스 각 변수명하고 테이블명 싹다 변경
    }
}
