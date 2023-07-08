//
//  RankingView.swift
//  Modori_PT_Proto
//
//  Created by 이성주 on 2022/02/04.
//

import SwiftUI


struct RankingItem : Identifiable {
    var id = UUID()
    var name : String
    var score : String
    var imageName : String
    
}


struct RankingListContent: View {
    
    var listData : [RankingItem] = []
    
    
    init()
    {
        // 점수에 따른 오름차순 정렬 추가 해야 함.
        for index in 1...15 {
            let value: Int = Int(drand48() * 100)
            listData.append(RankingItem(name: "이름 : \(index)", score: "점수 : \(value)점" ,imageName: "person.fill"))
        }
    }
    
    var body: some View
    {
        VStack{
            List(listData) {
                item in RankingListCell(item)
                    
            }
            .navigationBarHidden(true)
        }
    }
}



struct RankingListCell: View {
    var item: RankingItem?
    
    init(_ item: RankingItem) {
        self.item = item
        
    }
    
    var body: some View {
        HStack {
            
            Image(systemName: item!.imageName)
            Text("\(item!.name)")
            Spacer()
            Text("\(item!.score)")
        }
    }
}


//struct RankingView: View {
//    var body: some View {
//        Text("운동랭킹입니다.")
//            .navigationBarHidden(true)
//    }
//}

struct RankingView_Previews: PreviewProvider {
    static var previews: some View {
        RankingListContent()
    }
}
