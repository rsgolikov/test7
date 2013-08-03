//
//  TesCustomButton.h
//  test7
//
//  Created by Баз Светик on 01.08.13.
//  Copyright (c) 2013 ru.testoc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TesCustomButton : UIButton

@property (nonatomic, strong, readonly) UIColor *normalColor;
@property (nonatomic, strong, readonly) UIColor *highlightedColor;

- (void)setNormalColor:(UIColor *)normalColor;
- (void)setHighlightedColor:(UIColor *)highlightedColor;


@end
