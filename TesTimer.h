//
//  TesTimer.h
//  test7
//
//  Created by Баз Светик on 29.06.13.
//  Copyright (c) 2013 ru.testoc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TesTimer : NSObject{
    NSTimer *tesTimer1;
    BOOL tesTimerState;
}
@property (nonatomic, strong) NSTimer *tesTimer1;
@property (nonatomic) BOOL tesTimerState;

-(IBAction)doTimer:(id)sender;
-(IBAction)startTimer:(id)sender;
-(IBAction)stopTimer:(id)sender;


@end
