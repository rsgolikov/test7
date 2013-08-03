//
//  tesDefaultSettings.m
//  test7
//
//  Created by Баз Светик on 21.07.13.
//  Copyright (c) 2013 ru.testoc. All rights reserved.
//

#import "tesDefaultSettings.h"

@implementation tesDefaultSettings

+(UIColor *) defaultFont{
    return [UIColor blackColor];
}

+(UIColor *) defaultBackground{
    return [UIColor whiteColor];
}

+(int) defaultShuleSize{
    return 5;
}

+(void) setDefaultValueColor: (NSString *)key :(UIColor *) value{
    NSData *foregndcolorData = [NSKeyedArchiver archivedDataWithRootObject:value];
    [[NSUserDefaults standardUserDefaults] setObject:foregndcolorData forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(UIColor *) getDefaultValueColor: (NSString *)key{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    UIColor *color = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (color == nil) {
        if ([key isEqual:@"font"]) color=[self defaultFont]; else color = [self defaultBackground];
    }
    return color;
}

+(void) setDefaultValueInt:(NSString *)key :(int) value{
    [[NSUserDefaults standardUserDefaults] setInteger:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(int) getDeafultValueInt:(NSString *) key{
    int value = [[NSUserDefaults standardUserDefaults] integerForKey:key];
    if ((value==0) && ([key isEqual:@"shulteSize"])) {
        value = [self defaultShuleSize];
    }
    return value;
}


@end
