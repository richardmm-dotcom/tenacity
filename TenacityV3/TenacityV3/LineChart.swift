//
//  LineChart.swift
//  iosCharts
//
//  Created by Jackson Greaves on 8/26/19.
//  Copyright © 2019 Jackson Greaves. All rights reserved.
//

import Foundation
import Charts

class LineChart {
    private var lineChartView: LineChartView!
    
    private var goalColor: UIColor
    
    public var gamesInfo : [Int: (gameName: String, gameData: [Double], gameColor: UIColor, gameGoal: Double ) ]
    
    init( lineChartView: LineChartView!, goalColor: UIColor, gamesInfo: [Int: (gameName: String, gameData: [Double], gameColor: UIColor, gameGoal: Double) ] ) {
        
        self.lineChartView = lineChartView
        
        self.goalColor = goalColor
        
        self.gamesInfo = gamesInfo
    }
    
    public func drawGoalGraph( gameNum: Int ){
        var dataSets : [LineChartDataSet] = [LineChartDataSet]()
        
        var gamePoints : [ChartDataEntry] = [ChartDataEntry]()
        
        for (index, exp) in self.gamesInfo[gameNum]!.gameData.enumerated() {
            gamePoints.append(ChartDataEntry(x: Double(index), y: exp))
        }
        
        
        let gameSet : LineChartDataSet = LineChartDataSet(entries: gamePoints, label: self.gamesInfo[gameNum]!.gameName)
        
        gameSet.axisDependency = .left
        gameSet.setColor( self.gamesInfo[gameNum]!.gameColor )
        gameSet.setCircleColor( self.gamesInfo[gameNum]!.gameColor )
        gameSet.lineWidth = 2.75
        gameSet.circleRadius = 4.50
        gameSet.circleHoleRadius = 2.50
        gameSet.fillAlpha = 255 / 255
        gameSet.fillColor = self.gamesInfo[gameNum]!.gameColor
        gameSet.highlightColor = UIColor.clear
        gameSet.drawCircleHoleEnabled = true
        gameSet.drawCirclesEnabled = true
        gameSet.circleHoleColor = UIColor(red: 0.16, green: 0.18, blue: 0.19, alpha: 1.0)
        
        dataSets.append(gameSet)
        
        var invisibleLinePoints : [ChartDataEntry] = []
        
        for i in 0...6 {
            invisibleLinePoints.append(ChartDataEntry(x: Double(i), y: 0.00))
        }
        
        let invisibleSet : LineChartDataSet = LineChartDataSet(entries: invisibleLinePoints, label: "")
        
        
        invisibleSet.axisDependency = .left
        invisibleSet.setColor( UIColor.clear )
        invisibleSet.lineWidth = 0.0
        //        goalSet.lineDashLengths = [8, 6]
        invisibleSet.fillAlpha = 0 / 255
        invisibleSet.drawCircleHoleEnabled = false
        invisibleSet.drawCirclesEnabled = false
        //        goalSet.label
        
        dataSets.append(invisibleSet)
        
        var goalLinePoints : [ChartDataEntry] = []
        
        goalLinePoints.append(ChartDataEntry(x: 0, y: self.gamesInfo[gameNum]!.gameGoal))
        goalLinePoints.append(ChartDataEntry(x: 6, y: self.gamesInfo[gameNum]!.gameGoal))
        
        let goalSet : LineChartDataSet = LineChartDataSet(entries: goalLinePoints, label: String("Goal"))
        
        
        goalSet.axisDependency = .left
        goalSet.setColor( self.goalColor )
        goalSet.lineWidth = 1.75
        goalSet.lineDashLengths = [8.5, 10]
        goalSet.fillAlpha = 255 / 255
        goalSet.drawCircleHoleEnabled = false
        goalSet.drawCirclesEnabled = false
        
        dataSets.append(goalSet)
        
        let data : LineChartData = LineChartData( dataSets: dataSets)
        
        data.setValueTextColor(UIColor.clear)
        self.lineChartView.data = data
    }
    
    public func drawWeekGraph( ){
        var dataSets : [LineChartDataSet] = [LineChartDataSet]()
        
        for gameNum in 0...gamesInfo.count - 1{
            var gamePoints : [ChartDataEntry] = [ChartDataEntry]()
            for (index, exp) in self.gamesInfo[gameNum]!.gameData.enumerated() {
                gamePoints.append(ChartDataEntry(x: Double(index), y: exp))
            }
            
            let gameSet : LineChartDataSet = LineChartDataSet(entries: gamePoints, label: String(format: "%@", self.gamesInfo[gameNum]!.gameName))
            
            gameSet.axisDependency = .left
            gameSet.setColor( self.gamesInfo[gameNum]!.gameColor )
            gameSet.setCircleColor( self.gamesInfo[gameNum]!.gameColor )
            gameSet.lineWidth = 2.75
            gameSet.circleRadius = 4.50
            gameSet.circleHoleRadius = 2.50
            gameSet.fillAlpha = 255 / 255
            gameSet.fillColor = self.gamesInfo[gameNum]!.gameColor
            gameSet.circleHoleColor = UIColor(red: 0.16, green: 0.18, blue: 0.19, alpha: 1.0)
            gameSet.highlightColor = UIColor.clear
            gameSet.drawCircleHoleEnabled = true
            gameSet.drawCirclesEnabled = true
            
            dataSets.append(gameSet)
        }
        
        var invisibleLinePoints : [ChartDataEntry] = []
        
        for i in 0...6 {
            invisibleLinePoints.append(ChartDataEntry(x: Double(i), y: 0.00))
        }
        
        let invisibleSet : LineChartDataSet = LineChartDataSet(entries: invisibleLinePoints, label: "")
        
        
        invisibleSet.axisDependency = .left
        invisibleSet.setColor( UIColor.clear )
        invisibleSet.lineWidth = 0.0
        //        goalSet.lineDashLengths = [8, 6]
        invisibleSet.fillAlpha = 0 / 255
        invisibleSet.drawCircleHoleEnabled = false
        invisibleSet.drawCirclesEnabled = false
        //        goalSet.label
        
        dataSets.append(invisibleSet)
        
        let data : LineChartData = LineChartData( dataSets: dataSets )
        data.setValueTextColor(UIColor.clear)
        self.lineChartView.data = data
    }
}
