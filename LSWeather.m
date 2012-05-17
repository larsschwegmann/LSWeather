//
//  LSWeather.m
//
//  Created by Lars Schwegmann on 17.05.12.
//  Copyright (c) 2012 Lars Schwegmann iOS Software. All rights reserved.
//

#import "LSWeather.h"

@interface LSWeather ()

-(void)startParsing;

@end

@implementation LSWeather

#pragma mark NSObject methods

-(id)initWithLocationName:(NSString *)name languageCode:(NSString *)code{
    if (self == [super init]) {
        locationName = name;
    }
    return self;
}

#pragma mark Block setters

-(void)setDidUpdateBlock:(LSWeatherDidUpdateWeather)block{
    _didUpdateBlock = block;
}

-(void)setDidFailBlock:(LSWeatherDidFail)block{
    _didFailBlock = block;
}

#pragma mark custom methods

-(void)updateWeather{
    [self startParsing];
}

-(void)startParsing{
    errorOccured = NO;
    theParser = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.google.com/ig/api?weather=%@&hl=%@", locationName, languageCode]]];
    theParser.delegate = self;
    [theParser parse];
}

#pragma mark NSXMLParserDelegate

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName 
 namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName 
   attributes:(NSDictionary *)attributeDict {
    if ([elementName isEqualToString:@"current_conditions"]) {
        isInCurrentWeatherConditions = YES;
    }else if ([elementName isEqualToString:@"forecast_conditions"]){
        isInCurrentWeatherConditions = NO;
    }else{
        if (isInCurrentWeatherConditions) {
            if ([elementName isEqualToString:@"condition"]) {
                condition = [attributeDict objectForKey:@"data"];
            }else if([elementName isEqualToString:@"temp_f"]){
                temp_f = [attributeDict objectForKey:@"data"];
            }else if([elementName isEqualToString:@"temp_c"]){
                temp_c = [attributeDict objectForKey:@"data"];
            }else if([elementName isEqualToString:@"humidity"]){
                humidity = [attributeDict objectForKey:@"data"];
            }else if([elementName isEqualToString:@"icon"]){
                iconPath = [attributeDict objectForKey:@"data"];
            }else if([elementName isEqualToString:@"wind_condition"]){
                wind_condition = [attributeDict objectForKey:@"data"];
            }else{
                errorOccured = YES;
            }
        }
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if (!currentElementValue) {
        currentElementValue = [[NSMutableString alloc] initWithString:string];
    }else{
        [currentElementValue appendString:string];
    }
    NSLog(@"LSWeather -> parserFoundCharacters: %@", string);
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    NSLog(@"LSWeather -> parserDidEndElement: %@", elementName);
}

-(void)parserDidEndDocument:(NSXMLParser *)parser{
    if (!errorOccured) {
        _didUpdateBlock(locationName, condition, temp_c, temp_f, humidity, iconPath, wind_condition);
    }else{
        _didFailBlock(@"There was an error while parsing the XML file.");
    }
}

@end
