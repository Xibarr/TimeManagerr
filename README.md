# TimeManagerr
Know the time of the day in your app. Morning, Lunch, Afternoon, Dinner, etc.


1 - The TimeManagerr is used determine the period of the day on a device (Morning, Lunch, Afternoon, etc).

2 - You can also use the Manager to return the value .Dark at night and .Bright during day time. It can be used to adapt your app'' s theme.

3 - Use currentTime() to return the current Time as a Tuple ex: for 19:29:05  (19, 29, 5)



###How to install###

Simply add the file to your project


###How to use it###

    let periodOfTheDay = TimeManagerr.sharedInstance.currentPeriod  // return .Night
    let darkness = TimeManagerr.sharedInstance.currentDarkness // return .Dark



###Return type###

The Manager will return two enums. One for the currentPeriod and one for the currentDarkness


    enum timePeriod {
        case Morning
        case Lunch
        case Afternoon
        case Dinner
        case Evening
        case Night
        case Unknown
    }
 
    
    enum darkOrBright { 
        case Dark
        case Bright
    }










