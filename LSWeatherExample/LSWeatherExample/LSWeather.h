//
//  LSWeather.h
//
//  Created by Lars Schwegmann on 17.05.12.
//  Copyright (c) 2012 Lars Schwegmann iOS Software. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^LSWeatherDidUpdateWeather)(NSString *locationName, NSString *condition, NSString *temp_c, NSString *temp_f, NSString *humidity, NSString *iconPath, NSString *windCondition);
typedef void (^LSWeatherDidFail)(NSString *errorMsg);

@interface LSWeather : NSObject <NSXMLParserDelegate>{
    //Properties
    NSString *languageCode;
    NSString *locationName;
    NSString *condition;
    NSString *temp_c;
    NSString *temp_f;
    NSString *humidity;
    NSString *iconPath;
    NSString *wind_condition;
        
    //XML Parser
    NSXMLParser *theParser;
    NSMutableString *currentElementValue;
    BOOL isInCurrentWeatherConditions;
    BOOL errorOccured;
    
    //Blocks
    LSWeatherDidUpdateWeather _didUpdateBlock;
    LSWeatherDidFail _didFailBlock;
}

-(id)initWithLocationName:(NSString *)name languageCode:(NSString *)code;
-(void)setDidUpdateBlock:(LSWeatherDidUpdateWeather)block;
-(void)setDidFailBlock:(LSWeatherDidFail)block;
-(void)updateWeather;

@end
