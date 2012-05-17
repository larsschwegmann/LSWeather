//
//  LSAppDelegate.h
//  LSWeatherExample
//
//  Created by Lars Schwegmann on 17.05.12.
//  Copyright (c) 2012 Lars Schwegmann iOS Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LSViewController;

@interface LSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) LSViewController *viewController;

@end
