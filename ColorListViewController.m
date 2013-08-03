//
//  ColorListViewController.m
//  test7
//
//  Created by Баз Светик on 21.07.13.
//  Copyright (c) 2013 ru.testoc. All rights reserved.
//

#import "ColorListViewController.h"
#import "tesDefaultSettings.h"


@interface ColorListViewController ()

@end

@implementation ColorListViewController

//@synthesize currentColor;

+(UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ColorList" ofType:@"plist"];
    colorListDict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    colorNames = [colorListDict allKeys];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    // Uncomment the following line to preserve selection between presentations.
    //self.clearsSelectionOnViewWillAppear = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section==0) return 1; else return [colorListDict count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (indexPath.section == 0 ){
        cell.textLabel.text = @"	Black";
        cell.contentView.backgroundColor  = [UIColor blackColor];
        cell.textLabel.backgroundColor  = [UIColor blackColor];
        cell.textLabel.textColor = [UIColor whiteColor];
    } else {
        cell.textLabel.text = [colorNames objectAtIndex:indexPath.row];
        cell.contentView.backgroundColor  = [ColorListViewController colorFromHexString:[colorListDict objectForKey:[colorNames objectAtIndex:indexPath.row]]];
        cell.textLabel.backgroundColor  = [ColorListViewController colorFromHexString:[colorListDict objectForKey:[colorNames objectAtIndex:indexPath.row]]];
    }
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    int cn = self.navigationController.viewControllers.count;
    //[self.view setNeedsDisplay];
//    [[self.navigationController.viewControllers objectAtIndex:cn - 2] setNeedsDisplay];
     if (indexPath.section==1){
        [tesDefaultSettings setDefaultValueColor:[self currentColor] :[ColorListViewController colorFromHexString:[colorListDict objectForKey:[colorNames objectAtIndex:indexPath.row]]]];
        [self.navigationController popViewControllerAnimated:YES];
     } else {
         [tesDefaultSettings setDefaultValueColor:[self currentColor] :[UIColor blackColor]];
         [self.navigationController popViewControllerAnimated:YES];
     }
}

@end
