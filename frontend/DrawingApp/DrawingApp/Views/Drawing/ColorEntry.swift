//
//  ColorEntry.swift
//  DrawingApp
//
//  Created by Madelaine Hestermann on 06.06.22.
//

import SwiftUI

struct ColorEntry: View {
    let colorInfo: ColorInfo
    
    var body: some View {
        HStack {
            Circle()
                .fill(Color(colorInfo.color))
                .frame(width: 40, height: 40)
                .padding(.all)
            Text(colorInfo.displayName)
        }
    }
}

struct ColorEntry_Previews: PreviewProvider {
    static var previews: some View {
        ColorEntry(colorInfo: ColorInfo(id: 1, displayName: "Black", color: CGColor(red: 0, green: 0, blue: 0, alpha: 1)))
    }
}
