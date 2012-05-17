LSWeather
=========

A simple class to get the current weather conditions for a given location.

Installation
------------

Just drag LSWeather.h and LSWeather.m into your Project, and you're done.
To use it import it:
````Objective-C
#import "LSWeather.h"
`````

and then call it:
````Objective-C
LSWeather *weather = [[LSWeather alloc] initWithLocationName:@"Oberhausen" languageCode:@"en"];
[weather setDidFailBlock:^(NSString *errorMsg){
    //Some code here
}];
[weather setDidUpdateBlock:^(NSString *locationName, NSString *condition, NSString *temp_c, NSString *temp_f, NSString *humidity, NSString *iconPath, NSString *windCondition) {
    //Some code here
}];
[weather updateWeather];
````

License
-------
This Project is released under the Creative Commons 3.0 unported license.