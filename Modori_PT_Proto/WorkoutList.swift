//
//  WorkoutList.swift
//  Modori_PT_Proto
//
//  Created by 이태경 on 2022/05/09.
//

import Foundation

struct WorkoutList: Codable{
    var Crunch : Int64 = 0
    var Lunge : Int64 = 0
    var Squat : Int64 = 0
    var Jumping_Jacks : Int64 = 0
    
    /*enum CodingKeys : String, CodingKey{
        case Crunch
        case Lunge
        case Squat_videos
        case situp
    }
    
    init(from decoder: Decoder) throws{
        let values = try decoder.container(keyedBy: CodingKeys.self)
        Crunch = (try? values.decode(Int64.self, forKey:.Crunch)) ?? 0
        Lunge = (try? values.decode(Int64.self, forKey:.Lunge)) ?? 0
        Squat_videos = (try? values.decode(Int64.self, forKey:.Squat_videos)) ?? 0
        situp = (try? values.decode(Int64.self, forKey:.situp)) ?? 0
    }
    */
    
}
