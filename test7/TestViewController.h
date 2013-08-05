//
//  TestViewController.h
//  test7
//
//  Created by Администратор on 6/16/13.
//  Copyright (c) 2013 ru.testoc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TesTimer.h"
#import <iAd/iAd.h>
#import "TesCustomButton.h"


@interface TestViewController : UIViewController <ADBannerViewDelegate>{
    double tesStartValue;
    UITextField *tesTimerValue;
    double tesDelayWhenDisappear;
    UIButton *tesStartStop;
    NSManagedObjectContext *MOC;
    int shColumn;
}
@property (weak, nonatomic) IBOutlet UINavigationBar *nb;
@property (strong, nonatomic) NSMutableArray *shArrButton;
@property (strong, nonatomic) NSMutableArray *shArrValue;
@property (nonatomic, strong) TesTimer *tesTimer1;
@property (nonatomic, strong) UITextField *tesTimerValue;
@property (nonatomic, strong) UIButton *tesStartStop;
@property (nonatomic, retain) NSManagedObjectContext *MOC;
-(int) getShColumn;
-(void) setShColumn:(int) value;

+(UITextField *) getPosTextField: (int) pos;

-(void)stRandom;
-(IBAction)shRandButton: (id)sender;
-(IBAction)butDown:(id)sender;
-(void) addResult;

@end
