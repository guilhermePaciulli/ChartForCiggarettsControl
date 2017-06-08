//
//  Point.swift
//  ChartTestImplementation
//
//  Created by Guilherme Paciulli on 06/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import Foundation

class ChartPoint {
    
    var cigarettes: Int
    
    var days: Int
    
    init(days: Int, cigarettes: Int) {
        self.days = days
        self.cigarettes = cigarettes
    }
    
    init(days: Int) {
        self.days = days
        self.cigarettes = -1
    }
    
}
