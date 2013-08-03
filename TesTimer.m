//
//  TesTimer.m
//  test7
//
//  Created by Баз Светик on 29.06.13.
//  Copyright (c) 2013 ru.testoc. All rights reserved.
//

#import "TesTimer.h"

@implementation TesTimer

@synthesize tesTimer1;
@synthesize tesTimerState;

const float tesInterval=0.01f;

- (void)dealloc {
    if ([tesTimer1 isValid]) {
        [tesTimer1 invalidate];
    }
    self.tesTimer1 = nil;
}

- (IBAction)doTimer:(id)sender{
    if ([tesTimer1 isValid]) {
        [tesTimer1 invalidate];
        tesTimerState = NO;
    } else {
        tesTimerState = YES;
        self.tesTimer1 = [NSTimer scheduledTimerWithTimeInterval:tesInterval
                                                              target:sender
                                                            selector:@selector(tick)
                                                            userInfo:nil
                                                             repeats:YES];
    }
}
- (IBAction)stopTimer:(id)sender{
    if ([tesTimer1 isValid]) {
        [tesTimer1 invalidate];
        tesTimerState = NO;
    }
}
- (IBAction)startTimer:(id)sender{
        tesTimerState = YES;
        self.tesTimer1 = [NSTimer scheduledTimerWithTimeInterval:tesInterval
                                                          target:sender
                                                        selector:@selector(tick)
                                                        userInfo:nil
                                                         repeats:YES];
}


-(id)init {
    self = [super init];
    tesTimerState = NO;
    return self;
    
}

- (void)tick {
    NSLog(@"Time tick");
}

@end
