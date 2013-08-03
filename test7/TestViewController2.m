//
//  TestViewController2.m
//  test7
//
//  Created by Администратор on 6/16/13.
//  Copyright (c) 2013 ru.testoc. All rights reserved.
//

#import "TestViewController2.h"
#import <CoreData/CoreData.h>
#import "History.h"

@interface TestViewController2 ()

@end

@implementation TestViewController2

@synthesize historyArray;
//@synthesize tableView = _tableView;

-(IBAction)ret:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title =@"History";
        UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonSystemItemAction target:self action:@selector(ret:)];
        self.navigationItem.rightBarButtonItem = self.editButtonItem;
        self.navigationItem.leftBarButtonItem = back;
        // Custom initialization
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [historyArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // A date formatter for the time stamp.
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    }
 
    static NSString *CellIdentifier = @"Cell";
    
    // Dequeue or create a new cell.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    History *his = (History *)[historyArray objectAtIndex:indexPath.row];
    
    
    NSString *string = [NSString stringWithFormat:@"time = %@, size = %@", [his shulteValue], [his shulteSize]];
    NSString *string2 = [NSString stringWithFormat:@"Date = %@ ", [dateFormatter stringFromDate:[his creationDate]]];
    cell.textLabel.text = string;
    cell.detailTextLabel.text = string2;
    cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:18];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Delete the managed object at the given index path.
        NSManagedObject *eventToDelete = [historyArray objectAtIndex:indexPath.row];
        [[self MOC2] deleteObject:eventToDelete];
        
        // Update the array and table view.
        [historyArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
        
        
        // Commit the change.
        NSError *error = nil;
        if (![[self MOC2] save:&error]) {
            // Handle the error.
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"History" inManagedObjectContext:[self MOC2]];
    [request setEntity:entity];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"creationDate" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[self.MOC2 executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) {
        // Handle the error.
    }
    [self setHistoryArray:mutableFetchResults];
    self.tableView.separatorColor = [UIColor blackColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [super viewDidUnload];
}
@end
