//
//  ViewController.swift
//  ChartTestImplementation
//
//  Created by Guilherme Paciulli on 06/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var chart: LineChart!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let test = LineChartData(maxUnitX: 80, maxUnitY: 28, points: [ChartPoint(days:  1, cigarettes: 80),
                                                                      ChartPoint(days:  2),
                                                                      ChartPoint(days:  3),
                                                                      ChartPoint(days:  4, cigarettes: 36),
                                                                      ChartPoint(days:  5),
                                                                      ChartPoint(days:  6),
                                                                      ChartPoint(days:  7),
                                                                      ChartPoint(days:  8),
                                                                      ChartPoint(days:  9),
                                                                      ChartPoint(days:  10, cigarettes: 26),
                                                                      ChartPoint(days:  11, cigarettes: 22),
                                                                      ChartPoint(days:  12, cigarettes: 25),
                                                                      ChartPoint(days:  13, cigarettes: 23),
                                                                      ChartPoint(days:  14, cigarettes: 21),
                                                                      ChartPoint(days:  15),
                                                                      ChartPoint(days:  16, cigarettes: 5),
                                                                      ChartPoint(days:  17),
                                                                      ChartPoint(days:  18),
                                                                      ChartPoint(days:  19),
                                                                      ChartPoint(days:  20),
                                                                      ChartPoint(days:  21),
                                                                      ChartPoint(days:  22),
                                                                      ChartPoint(days:  23),
                                                                      ChartPoint(days:  24),
                                                                      ChartPoint(days:  25),
                                                                      ChartPoint(days:  26),
                                                                      ChartPoint(days:  27),
                                                                      ChartPoint(days:  28, cigarettes: 5)])
        chart.pointData = test
    }



}

