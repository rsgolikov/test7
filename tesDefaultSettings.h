//
//  tesDefaultSettings.h
//  test7
//
//  Created by Баз Светик on 21.07.13.
//  Copyright (c) 2013 ru.testoc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface tesDefaultSettings : NSObject

+(UIColor *) defaultFont;
+(UIColor *) defaultBackground;
+(int) defaultShuleSize;
+(void) setDefaultValueColor: (NSString *)key :(UIColor *) value;
+(UIColor *) getDefaultValueColor: (NSString *)key;
+(void) setDefaultValueInt:(NSString *)key :(int) value;
+(int) getDeafultValueInt:(NSString *) key;

@end
