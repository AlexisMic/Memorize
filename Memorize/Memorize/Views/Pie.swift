//
//  Pie.swift
//  Memorize
//
//  Created by Alexis Schotte on 8/15/22.
//

import SwiftUI

struct Pie: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise = false
    
    var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(startAngle.radians, endAngle.radians)
        }
        set {
            startAngle = Angle(radians: newValue.first)
            endAngle = Angle(radians: newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = CGFloat.minimum(rect.width, rect.height) / 2
        
        
        var p = Path()
        p.move(to: center)
        p.addLine(to: CGPoint(
            x: center.x + (radius * cos(startAngle.radians)),
            y: center.y + (radius * sin(startAngle.radians))
        ))
        p.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: !clockwise)
        
        
        return p
    }
    
    
}
