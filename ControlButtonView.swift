//
//  ControlButtonView.swift
//  BasicCamera
//
//  Created by Terrance Griffith on 1/24/26.
//

import SwiftUI

struct ControlButtonView: View {
    
    let label: String
    let action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            Text(label)
                .tint(.white)
                .font(.title3)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    ControlButtonView(label: "Cancel", action: {})
}
