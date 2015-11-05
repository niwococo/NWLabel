# NWLabel
counting up label in ios, swift


Usage:

        1.you should create an NWLabel with a frame
        2.add properties just like UILabel
        3.set targetData,original data is 0
        4.call showFixedTimeAnim or timerFiredSmooth function,you must call the func in your MainUI thread,otherwise the numbers counting could not be stoppped


eg:

        titleNum1 = NWLabel(frame: CGRectMake(0,self.tabBar.frame.size.height - 5 - 20 - 20,line1.frame.size.width,20))
        titleNum1.text = "0"
        titleNum1.textColor = COLOR_FONT_GREEN
        titleNum1.userInteractionEnabled = false
        titleNum1.font = UIFont(name: BstFonts.SemiBold.rawValue, size: 16);
        titleNum1.textAlignment = NSTextAlignment.Center
        self.tabBar.addSubview(titleNum1)
        
        titleNum1.targetData = 9
        titleNum1.showFixedTimeDrawAnim(1, behindDecimalCount: 0)
