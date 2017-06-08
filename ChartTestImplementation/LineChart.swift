//
//  LineChart.swift
//  ChartTestImplementation
//
//  Created by Guilherme Paciulli on 06/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit

class LineChart: UIView {
    
    var pointData: LineChartData?

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if let pD = pointData {
            drawChart(pointData: pD)
        }
    }
    
    func scale(unitX: Int, unitY: Int) -> CGPoint {
        let y = CGFloat(unitY) * (bounds.height * 0.9) * 0.95 / CGFloat((pointData?.maxUnitY)!) 
        return CGPoint(x: (CGFloat(unitX) * ((bounds.width) - (bounds.height * 0.075))  * 0.95 / (CGFloat(pointData!.maxUnitX)) + (bounds.height * 0.075)),
                       y: ((bounds.height * 0.9) - y))
    }
 
    func drawChart(pointData: LineChartData) {
        if let context = UIGraphicsGetCurrentContext() {
            drawGoal(context: context, pointData: pointData)
            drawPerformance(context: context, pointData: pointData)
            drawAxes(context: context, pointData: pointData)
        }
    }
    
    func distance(_ a: CGPoint, _ b: CGPoint) -> CGFloat {
        let xDist = a.x - b.x
        let yDist = a.y - b.y
        return CGFloat(sqrt((xDist * xDist) + (yDist * yDist)))
    }
    
    func drawAxes(context: CGContext, pointData: LineChartData) {
        context.setStrokeColor(UIColor.gray.cgColor)
        context.setLineWidth(2.5)
        
        //X Axis
        context.move(to: CGPoint(x: 0, y: bounds.height - (bounds.height * 0.1)))
        context.addLine(to: CGPoint(x: bounds.width, y: bounds.height - (bounds.height * 0.1)))
        context.strokePath()
        
        let xStep = pointData.points.count >= 21  ? 3 : 1
        
        //X labels
        for i in stride(from: 0, to: (pointData.points).count, by: xStep) {
            let p = (pointData.points[i])
            var point = scale(unitX: p.days, unitY: p.cigarettes)
            point.y = bounds.height - (bounds.height * 0.1)
            point.x = point.x - (p.days / 10 > 0 ? 10.2 : 5)
            let rect = CGRect(origin: point, size: CGSize(width: (p.days / 10 > 0 ? 20.4 : 10), height: 30))
            let label = UILabel(frame: rect)
            label.text = String(describing: p.days)
            self.addSubview(label)
        }
        
        //Y Axis
        context.setLineWidth(2.5)
        context.move(to: CGPoint(x: (bounds.height * 0.075), y: bounds.height))
        context.addLine(to: CGPoint(x: (bounds.height * 0.075), y: 0))
        context.strokePath()
        
        let fontSize = distance(scale(unitX: 1, unitY: 1), scale(unitX: 1, unitY: (pointData.maxUnitY))) / CGFloat((pointData.maxUnitY) / 5)
        let font = UIFont(name: "Helvetica", size: fontSize)
        
        //Y labels
        for i in stride(from: 5, to: pointData.maxUnitY + 1, by: 5) {
            var point = scale(unitX: 0, unitY: i)
            point.x = point.x - 35
            point.y = point.y - (fontSize / 2)
            
            let rect = CGRect(origin: point, size: CGSize(width: 30, height: fontSize))
            let label = UILabel(frame: rect)
            label.font = font
            label.textAlignment = .right
            
            label.text = String(describing: i)
            self.addSubview(label)
        }
    }
    
    func drawGoal(context: CGContext, pointData: LineChartData) {
        context.setStrokeColor(UIColor.blue.cgColor)
        context.setLineWidth(3)
        let firstPoint = pointData.points[0]
        context.move(to: scale(unitX: 0, unitY: (firstPoint.cigarettes)))
        context.addLine(to: scale(unitX: (pointData.maxUnitX), unitY: 0))
        context.strokePath()
    }
    
    func drawPerformance(context: CGContext, pointData: LineChartData) {
        context.setStrokeColor(UIColor.green.cgColor)
        context.setLineWidth(3)
        context.setLineCap(.butt)
        let firstPoint = pointData.points[0]
        context.move(to: scale(unitX: 0, unitY: (firstPoint.cigarettes)))
        
        var lastValidPoint = scale(unitX: 0, unitY: (firstPoint.cigarettes))
        
        for i in 1...(pointData.points).count - 1 {
            let p = (pointData.points[i])
            let lastPoint = (pointData.points[i - 1])
            let point = scale(unitX: p.days, unitY: p.cigarettes)
            if p.cigarettes != -1 {
                if lastPoint.cigarettes != -1 {
                    context.addLine(to: point)
                    context.strokePath()
                } else {
                    context.setLineDash(phase: 1, lengths: [10, 5])
                    context.setLineWidth(1.5)
                    context.move(to: lastValidPoint)
                    context.addLine(to: point)
                    context.strokePath()
                    context.setLineDash(phase: 0, lengths: [])
                    context.setLineWidth(3)
                }
                lastValidPoint = point
            }
            context.move(to: point)
        }
        
        context.strokePath()
        
        for i in 1...(pointData.points).count - 1 {
            let p = (pointData.points[i])
            let point = scale(unitX: p.days, unitY: p.cigarettes)
            if p.cigarettes > 0 {
                context.setStrokeColor(UIColor.green.cgColor)
                if i == pointData.getLastValidPointIndex() {
                    context.addArc(center: point, radius: 4, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
                    context.strokePath()
                    context.setFillColor(UIColor.white.cgColor)
                    context.addArc(center: point, radius: 2, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
                } else {
                    context.addArc(center: point, radius: 2, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
                    context.strokePath()
                    context.setFillColor(UIColor.white.cgColor)
                    context.addArc(center: point, radius: 1, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
                }
                context.fillPath()
                context.strokePath()
            }
        }
    }
}
