//
//  LSViewController.m
//  LSWeatherExample
//
//  Created by Lars Schwegmann on 17.05.12.
//  Copyright (c) 2012 Lars Schwegmann iOS Software. All rights reserved.
//

#import "LSViewController.h"

@interface LSViewController ()

@end

@implementation LSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    LSWeather *weather = [[LSWeather alloc] initWithLocationName:@"Cupertino" languageCode:@"en"];
    [weather setDidUpdateBlock:^(NSString *locationName, NSString *condition, NSString *temp_c, NSString *temp_f, NSString *humidity, NSString *iconPath, NSString *windCondition) {
        NSLog(@"locationName -> %@", locationName);
        NSLog(@"condition -> %@", condition);
        NSLog(@"temp_c -> %@", temp_c);
        NSLog(@"temp_f -> %@", temp_f);
        NSLog(@"humidity -> %@", humidity);
        NSLog(@"iconPath -> %@", iconPath);
        NSLog(@"windCondition -> %@", windCondition);

    }];
    [weather setDidFailBlock:^(NSString *errorMsg) {
        NSLog(@"There was an error: %@", errorMsg);
    }];
    [weather updateWeather];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
