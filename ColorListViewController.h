//
//  ColorListViewController.h
//  test7
//
//  Created by Баз Светик on 21.07.13.
//  Copyright (c) 2013 ru.testoc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorListViewController : UITableViewController{
    NSMutableDictionary *colorListDict;
    NSMutableArray *colorNames;
}

+(UIColor *)colorFromHexString:(NSString *)hexString;
@property NSString *currentColor;

@end
