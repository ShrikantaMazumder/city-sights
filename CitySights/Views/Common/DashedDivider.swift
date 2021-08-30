//
//  DashedDivider.swift
//  CitySights
//
//  Created by Shrikanta Mazumder on 31/8/21.
//

import SwiftUI

struct DashedDivider: View {
    var body: some View {
        GeometryReader { geometry in
            Path {path in
                path.move(to: CGPoint.zero)
                path.addLine(to: CGPoint(x: geometry.size.width, y: 0))
            }
            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
            .foregroundColor(.gray)
        }
        .frame(height: 1)
    }
}

struct DashedDivider_Previews: PreviewProvider {
    static var previews: some View {
        DashedDivider()
    }
}
