//
//  ExersiseView.swift
//  Modori_PT_Proto
//
//  Created by 이성주 on 2022/02/03.
//

import SwiftUI

struct ExersiseView: View {
    
    let exerciseType = ["스쿼트"]
    var body: some View {
        
        NavigationView {
            List(0..<5) { row in
                NavigationLink(destination: Text("운동종목 \(row+1)")) {
                    Text("운동종목 \(row+1)")
                }
            }
        }
        .navigationBarHidden(true)
        }
    }


struct ExersiseView_Previews: PreviewProvider {
    static var previews: some View {
        ExersiseView()
    }
}
