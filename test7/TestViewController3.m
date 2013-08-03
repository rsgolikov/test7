//
//  TestViewController3.m
//  test7
//
//  Created by Администратор on 6/16/13.
//  Copyright (c) 2013 ru.testoc. All rights reserved.
//

#import "TestViewController3.h"
#import "ColorPickerCell.h"
#import "ColorListViewController.h"
#import "tesDefaultSettings.h"

@interface TestViewController3 ()

@end

@implementation TestViewController3


-(IBAction)ret:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title =@"Setup";
        UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonSystemItemAction target:self action:@selector(ret:)];
  //      self.navigationItem.rightBarButtonItem = self.editButtonItem;
        self.navigationItem.leftBarButtonItem = back;
        // Custom initialization
    }
    return self;
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int iRet = 0;
    switch (section) {
        case 0:
            iRet= 1;
            break;
        case 1:
            iRet= 2;
            break;
        case 2:
            iRet= 1;
            break;
            
        default:
            break;
    }
    return iRet;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[self tableView] reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0){
        [tesDefaultSettings setDefaultValueColor:@"font" :[UIColor blackColor]];
        [tesDefaultSettings setDefaultValueColor:@"background" :[UIColor whiteColor]];
        [tableView reloadData];
    }
    if (indexPath.section ==1 ){
        ColorListViewController *vc = [[ColorListViewController alloc] init];
        if (indexPath.row == 0) vc.currentColor = @"font"; else vc.currentColor = @"background";
        [self.navigationController pushViewController:vc animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (aCell==nil){
			aCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
			aCell.textLabel.textAlignment = UITextAlignmentCenter;
            aCell.textLabel.text = @"Default values";
        }
        return aCell;
        
    }
    if (indexPath.section == 1){
        static NSString *ColorPickerIdentifier = @"ColorPickerCell";
        ColorPickerCell *cpCell = (ColorPickerCell *)[tableView dequeueReusableCellWithIdentifier:ColorPickerIdentifier];
        if (cpCell == nil){
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ColorPickerCell" owner:self options:nil];
                cpCell = [nib objectAtIndex:0];
            cpCell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
            if (indexPath.row==1){
                cpCell.titleCell.text = @"Background color";
                cpCell.textCell.backgroundColor =[tesDefaultSettings getDefaultValueColor:@"background"];
            } else {
                cpCell.titleCell.text = @"Font color";
                cpCell.textCell.backgroundColor =[tesDefaultSettings getDefaultValueColor:@"font"];
            }
        }
        return cpCell;
    }
    if (indexPath.section == 2){
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		aCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		aCell.detailTextLabel.numberOfLines = 0;
        aCell.textLabel.text = @"Size";
        CGRect sliderFrame;
        sliderFrame.origin.x = 220;//aCell.frame.size.width/2;;
        sliderFrame.origin.y = aCell.frame.size.height/5;
        sliderFrame.size.width=80;//aCell.frame.size.width/12*5;
        sliderFrame.size.height=aCell.frame.size.height/3*2;
            
        UISegmentedControl *sc = [[UISegmentedControl alloc] initWithItems:[[NSArray alloc] initWithObjects:@"5x5", @"7x7", nil]] ;
        sc.frame = sliderFrame;
        if ([tesDefaultSettings getDeafultValueInt:@"shulteSize"]==5){
            sc.selectedSegmentIndex = 0;
        } else {
            sc.selectedSegmentIndex = 1;
        }
        [sc addTarget:self
                                 action:@selector(scSelectSize:)
                       forControlEvents:UIControlEventValueChanged];
            
        aCell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.shulteSize = sc;
        [aCell addSubview:sc];
            
        return aCell;
    }
}

-(IBAction)scSelectSize:(id)sender{
    switch ([[self shulteSize] selectedSegmentIndex]) {
        case 0:
            [tesDefaultSettings setDefaultValueInt:@"shulteSize":5];
            
            break;
        case 1:
            [tesDefaultSettings setDefaultValueInt:@"shulteSize" :7];
            break;
            
        default:
            break;
    }
   
}

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
 //   [self tableView].allowsSelection = true;
    

}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidUnload {
    [self setTableView:nil];
    [self setTv:nil];
    [super viewDidUnload];
    
}

@end
