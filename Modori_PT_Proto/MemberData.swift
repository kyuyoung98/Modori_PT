//
//  MemberData.swift
//  Modori_PT_Proto
//
//  Created by 이성주 on 2022/03/15.
//

import Foundation
import FirebaseAuth

//UserRank테이블의 각 uid 별로 가지고 있는 요소
struct MemberData: Codable {
    let TotalPoint: Int
    let Name: String
    let EachPoints: ExerciseDetail
}

//그 안의 detail 안에 존재하는 요소
struct ExerciseDetail: Codable {
    let Crunch: Int
    let Lunge: Int
    let Squat: Int
    let Jumping_Jacks: Int
}
