//
//  PickWordView.swift
//  DrawingApp
//
//  Created by Lothar Hestermann on 20.06.22.
//

import SwiftUI

struct PickWordView: View {
    @Environment var wordsToPick: [String]
    
    
    var body: some View {
        ForEach (wordsToPick) { word in
            Button(word) {
                onSubmit({
                })
            }
        }
    }
}

struct PickWordView_Previews: PreviewProvider {
    static var previews: some View {
        PickWordView()
    }
}
