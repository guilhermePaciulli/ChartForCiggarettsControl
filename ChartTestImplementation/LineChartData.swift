//
//  LineChartData.swift
//  ChartTestImplementation
//
//  Created by Guilherme Paciulli on 06/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import Foundation

class LineChartData {
    
    var maxUnitX: Int
    
    var maxUnitY: Int
    
    var points: [ChartPoint]
    
    var lastValidPoint: ChartPoint
    
    init(maxUnitX: Int, maxUnitY: Int, points: [ChartPoint]) {
        self.points = points
        self.maxUnitY = maxUnitX
        self.maxUnitX = maxUnitY
        lastValidPoint = points.filter({ $0.cigarettes != -1 }).last!
    }
    
    func getLastValidPointIndex() -> Int {
        return points.index(where: { $0.days == lastValidPoint.days && $0.cigarettes == lastValidPoint.cigarettes })!
    }
    
}
