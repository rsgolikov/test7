//
//  TestViewController.m
//  test7
//
//  Created by Администратор on 6/16/13.
//  Copyright (c) 2013 ru.testoc. All rights reserved.
//

#import "TestViewController.h"
#import "TestViewController2.h"
#import "TestViewController3.h"
#import "TesTimer.h"
#import <QuartzCore/QuartzCore.h>
#import "History.h"
#import "TestAppDelegate.h"
#import "tesDefaultSettings.h"
#import "TesCustomButton.h"


@interface TestViewController ()

@end

@implementation TestViewController

ADBannerView *_bannerView;
CGRect currentSize;

@synthesize nb=_nb;
@synthesize shArrButton;
@synthesize shArrValue;
const int shColumn = 5;
const int shTopDiff =1;
@synthesize tesTimer1 = _tesTimer1;
@synthesize tesTimerValue;
@synthesize tesStartStop;
@synthesize MOC;

-(void) addResult{
    History *history = (History *)[NSEntityDescription insertNewObjectForEntityForName:@"History" inManagedObjectContext:[self MOC]];
   
    double delta =[NSDate timeIntervalSinceReferenceDate]-tesStartValue+tesDelayWhenDisappear ;
    [history setShulteValue:[NSString stringWithFormat:@"%1.2f", delta]];
    [history setShulteSize:[NSString stringWithFormat:@"%dx%d", shColumn, shColumn]];
    [history setCreationDate:[NSDate date]];
    NSError *error = nil;
    if (![[self MOC] save:&error]) {
        // Handle the error.
    }
     
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       // On iOS 6 ADBannerView introduces a new initializer, use it when available.
    if ([ADBannerView instancesRespondToSelector:@selector(initWithAdType:)]) {
            _bannerView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
        } else {
            _bannerView = [[ADBannerView alloc] init];
        }
        _bannerView.delegate = self;
    }

    return self;
}
- (void)layoutAnimated:(BOOL)animated{
    // As of iOS 6.0, the banner will automatically resize itself based on its width.
    // To support iOS 5.0 however, we continue to set the currentContentSizeIdentifier appropriately.
    CGRect contentFrame = self.view.bounds;
    if (contentFrame.size.width < contentFrame.size.height) {
        _bannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
    } else {
        _bannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierLandscape;
    }
    
    CGRect bannerFrame = _bannerView.frame;
    if (_bannerView.bannerLoaded) {
        contentFrame.size.height -= _bannerView.frame.size.height;
        bannerFrame.origin.y = contentFrame.size.height;
    } else {
        bannerFrame.origin.y = contentFrame.size.height;
    }
    
    [UIView animateWithDuration:animated ? 0.25 : 0.0 animations:^{
        self.view.frame = contentFrame;
        [self.view layoutIfNeeded];
        _bannerView.frame = bannerFrame;
    }];
}

-(IBAction)butHistory:(id)sender{
    TestViewController2 *t2 = [[TestViewController2 alloc] initWithStyle:UITableViewStylePlain];
    t2.MOC2 = [self MOC];
    t2 = [t2 init];
    [self.navigationController pushViewController:t2 animated:YES];
    
}
-(IBAction)butThree:(id)sender{
    TestViewController3 *t3 = [[TestViewController3 alloc] initWithStyle:UITableViewStyleGrouped];
    t3.title = @"Setup";
    [   self.navigationController pushViewController:t3 animated:YES];
}
-(IBAction)butHelp:(id)sender{
}

+(CGRect) getCGRectPosTextField: (int) pos{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    int shScreenSizeWith = screenBounds.size.width;
    int shLeftPos;
    int shTopPos;
    int shBtnWith;
    int shBtnHeigh;
    if (pos==shColumn*shColumn+1){
        shTopPos = shScreenSizeWith+shTopDiff-shColumn+1;
        shLeftPos= 0;
        shBtnWith = shScreenSizeWith-1;
        if (shColumn == 7) { //разобраться с размерами активной части экрана 
            shBtnHeigh = 50;
        } else {
            shBtnHeigh = 47;
            shTopPos +=1;
        }
    } else {
        shBtnWith =  (shScreenSizeWith-shColumn+1)/shColumn;
        shLeftPos = (shScreenSizeWith-shBtnWith*shColumn)/2 + shBtnWith* (pos % shColumn);
        shTopPos = (shScreenSizeWith-shBtnWith*shColumn)/2 + shBtnWith* (pos / shColumn);
        shBtnHeigh = shBtnWith;
    }
    return CGRectMake(shLeftPos, shTopPos, shBtnWith, shBtnHeigh);
}
+(UITextField *) getPosTextField: (int) pos{
    UITextField *txt =[[UITextField alloc] init];
    [txt setFont:[UIFont systemFontOfSize:32]];
    [txt setTextColor:[tesDefaultSettings getDefaultValueColor:@"font"]];
    [txt setBorderStyle:UITextBorderStyleLine];
    [txt setBackgroundColor:[tesDefaultSettings getDefaultValueColor:@"background"]];
    txt.enabled =false;
    txt.textAlignment =  NSTextAlignmentCenter;
    txt.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; 
    txt.frame = [TestViewController getCGRectPosTextField:pos];
    if (pos==shColumn*shColumn/2){
        txt.layer.borderWidth=4;
        txt.layer.borderColor=[[UIColor redColor] CGColor];
    }
    return txt;
}

-(void)stRandom{
    NSMutableArray *myArr2 = [[NSMutableArray alloc] init];
    int Arrcount =[shArrValue count];
    for (int i = 0 ; i < Arrcount; i++) {
        int rand = arc4random() % [shArrValue count];
        [myArr2 addObject:shArrValue[rand]];
        [shArrValue removeObjectAtIndex:rand];
    }
    for (int i = 0 ; i < [myArr2 count]; i++) {
        [shArrValue addObject:[NSNumber numberWithInteger:[myArr2[i] intValue]]];
    }
 }

-(void)setCellColor{
    UIColor *fontColor = [tesDefaultSettings getDefaultValueColor:@"font"];
    UIColor *backgroundColor = [tesDefaultSettings getDefaultValueColor:@"background"];
    for(int i=0;i<shColumn*shColumn;i++){
        UITextField *tf = [shArrButton objectAtIndex:i];
        [tf setTextColor:fontColor];
        [tf setBackgroundColor:backgroundColor];
    }
    [tesStartStop setBackgroundColor:backgroundColor];
    [tesStartStop setTitleColor:fontColor forState:UIControlStateNormal];
    [[tesStartStop titleLabel] setBackgroundColor:backgroundColor];
}

-(IBAction)tesDoTimer:(id)sender{
    if (_tesTimer1.tesTimerState == NO) {
        [self stRandom];
        for(int i=0;i<shColumn*shColumn;i++){
            [[shArrButton objectAtIndex:i] setText:[NSString stringWithFormat:@"%d",[[shArrValue objectAtIndex:i] intValue]]];
        }
        tesDelayWhenDisappear = 0;
        [tesStartStop setTitle:@"STOP" forState:UIControlStateNormal];
        tesStartValue = [NSDate timeIntervalSinceReferenceDate];
    } else {
        [tesStartStop setTitle:@"START" forState:UIControlStateNormal];
        [self addResult];
       
    }
    [_tesTimer1 doTimer:self];
}


- (void)tick {
    double delta =[NSDate timeIntervalSinceReferenceDate]-tesStartValue+tesDelayWhenDisappear ;
    self.navigationItem.title=[NSString stringWithFormat:@"%1.2f", delta];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (_tesTimer1.tesTimerState == YES) {
        tesDelayWhenDisappear += [NSDate timeIntervalSinceReferenceDate]-tesStartValue ;
    }
}
-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (_tesTimer1.tesTimerState == YES) {
        tesStartValue = [NSDate timeIntervalSinceReferenceDate] ;
    }
    [self setCellColor];
    //перекрасить?
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImage *imageHis = [UIImage imageNamed:@"11-clock.png"];
    UIBarButtonItem *history = [[UIBarButtonItem alloc] initWithImage:imageHis style:UIBarButtonItemStylePlain target:self action:@selector(butHistory:)];
    UIImage *imageSetup = [UIImage imageNamed:@"19-gear.png"];
    UIBarButtonItem *setup = [[UIBarButtonItem alloc] initWithImage:imageSetup style:UIBarButtonItemStylePlain target:self action:@selector(butThree:)];
    UIBarButtonItem *shRandButton = [[UIBarButtonItem alloc] initWithTitle:@"?" style:(UIBarButtonItemStylePlain) target:self action:@selector(butHelp:)];
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:shRandButton, nil];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:history, setup,  nil];
    currentSize = self.view.frame;
    shArrButton = [[NSMutableArray alloc] init];
    shArrValue = [[NSMutableArray alloc] init];
    
    for(int i=0;i<shColumn*shColumn;i++){
        [shArrButton addObject:[TestViewController getPosTextField:i]];
        [shArrValue addObject:[NSNumber numberWithInteger:i+1]];
        [self.view addSubview:[shArrButton objectAtIndex:i]];
        [[shArrButton objectAtIndex:i] setText:@"*"];
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(tesDoTimer:)
     forControlEvents:UIControlEventTouchDown];
    [button setTitle:@"START" forState:UIControlStateNormal];
    button.frame = [TestViewController getCGRectPosTextField:shColumn*shColumn+1];
    tesStartStop = button;
    [self.view addSubview:button];
    self.navigationItem.title=[NSString stringWithFormat:@"%1.2f", 0.0];
    if (!_tesTimer1) { _tesTimer1 = [[TesTimer alloc] init];}
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGRect bannerFrame = _bannerView.frame;
    bannerFrame.origin.y=screenBounds.size.height;
    _bannerView.frame = bannerFrame;
    [self.view addSubview:_bannerView];
    
 
    
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    [self layoutAnimated:YES];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    [self layoutAnimated:YES];
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    return YES;
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner
{

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end



