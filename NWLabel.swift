//
//  NWLabel.swift
//  niwococo
//
//  Created by NW on 15/11/4.
//  Copyright © 2015 niwococo All rights reserved.
//

import Foundation

class NWLabel:UILabel
{
    var targetData:Double = 0
    var currentData:Double = 0
    
    var preStr:String = ""
    var tailStr:String = ""
    var behindDecimalCount:Int = 0
    var fixedTime:NSTimeInterval = 0
    var minTimeUnit:NSTimeInterval = 0.01
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var pressTimer: NSTimer!
    
    func showSmoothDrawAnim(behindDecimalCount:Int,preString:String = "",tailString:String = "",minTimeUnit:NSTimeInterval = 0.01)
    {
        self.minTimeUnit = minTimeUnit
        self.behindDecimalCount = behindDecimalCount
        preStr = preString
        tailStr = tailString
        pressTimer = NSTimer.scheduledTimerWithTimeInterval(minTimeUnit, target: self, selector: "timerFiredSmooth:", userInfo: nil, repeats: true)
        // it is be scheduled on mainUI thread
    }
    
    func timerFiredSmooth(timer:NSTimer)
    {
        let velocity = behindDecimalCount > 0 ? 1.0/(Double(behindDecimalCount) * 10.0) : 1
        
        currentData+=velocity
        
        if (currentData >= targetData)
        {
            currentData = targetData
        }
        
        var midStr = NSString(format: "%.f", currentData) as String
        if (behindDecimalCount > 0)
        {
            midStr = NSString(format: "%.\(behindDecimalCount)f", currentData) as String
        }
        
        self.text = preStr + midStr + tailStr
        setNeedsDisplay()
        if(currentData >= targetData && pressTimer != nil && pressTimer.valid)
        {
            pressTimer.invalidate()
            pressTimer = nil
        }
    }
    
    func showFixedTimeDrawAnim(fixedTime:NSTimeInterval,behindDecimalCount:Int,preString:String = "",tailString:String = "",minTimeUnit:NSTimeInterval = 0.01)
    {
        self.fixedTime = fixedTime
        self.behindDecimalCount = behindDecimalCount
        preStr = preString
        tailStr = tailString
        pressTimer = NSTimer.scheduledTimerWithTimeInterval(minTimeUnit, target: self, selector: "fixedTimerFired:", userInfo: nil, repeats: true)
    }
    
    func fixedTimerFired(timer:NSTimer)
    {
        let velocity = targetData * (self.minTimeUnit / self.fixedTime)
        
        currentData+=velocity
        
        if (currentData >= targetData)
        {
            currentData = targetData
        }
        
        var midStr = NSString(format: "%.f", currentData) as String
        if (behindDecimalCount > 0)
        {
            midStr = NSString(format: "%.\(behindDecimalCount)f", currentData) as String
        }
        
        self.text = preStr + midStr + tailStr
        setNeedsDisplay()
        if(currentData >= targetData && pressTimer != nil && pressTimer.valid)
        {
            pressTimer.invalidate()
            pressTimer = nil
        }
    }
}