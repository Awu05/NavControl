//
//  ProductViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "ProductViewController.h"
#import "ProductPageViewController.h"

@interface ProductViewController ()

@end

@implementation ProductViewController

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

    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.apple = [NSMutableArray arrayWithObjects: @"iPad", @"iPod Touch",@"iPhone", nil];
    
    self.samsung = [NSMutableArray arrayWithObjects: @"Galaxy S4", @"Galaxy Note", @"Galaxy Tab", nil];
    
    self.oneplus = [NSMutableArray arrayWithObjects: @"OnePlus X", @"OnePlus 2",@"OnePlus 3", nil];
    
    self.xiaomi = [NSMutableArray arrayWithObjects: @"Mi Note 2", @"Mi 5", @"Mi Max", nil];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    if ([self.title isEqualToString:@"Apple mobile devices"]) {
        self.products = self.apple;
    } else if ([self.title isEqualToString:@"Samsung mobile devices"]){
        self.products = self.samsung;
    } else if ([self.title isEqualToString:@"OnePlus Mobile Devices"]) {
        self.products = self.oneplus;
    } else if ([self.title isEqualToString:@"XiaoMi Mobile Devices"]){
        self.products = self.xiaomi;
    }
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.products count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    cell.textLabel.text = [self.products objectAtIndex:[indexPath row]];
    
    if ([cell.textLabel.text isEqualToString:@"iPad"]){
        [[cell imageView] setImage: [UIImage imageNamed:@"ipad.jpg"]];
    } else if ([cell.textLabel.text isEqualToString:@"iPod Touch"]){
        [[cell imageView] setImage: [UIImage imageNamed:@"ipod_touch.jpg"]];
    } else if ([cell.textLabel.text isEqualToString:@"iPhone"]){
        [[cell imageView] setImage: [UIImage imageNamed:@"iphone7.jpg"]];
    }
    else if ([cell.textLabel.text isEqualToString:@"Galaxy S4"]){
        [[cell imageView] setImage: [UIImage imageNamed:@"samsung_s4.jpg"]];
    } else if ([cell.textLabel.text isEqualToString:@"Galaxy Note"]){
        [[cell imageView] setImage: [UIImage imageNamed:@"samsung_note.jpg"]];
    } else if ([cell.textLabel.text isEqualToString:@"Galaxy Tab"]){
        [[cell imageView] setImage: [UIImage imageNamed:@"samsung_tab.jpg"]];
    }
    else if ([cell.textLabel.text isEqualToString:@"OnePlus X"]){
        [[cell imageView] setImage: [UIImage imageNamed:@"oneplus-x.jpg"]];
    } else if ([cell.textLabel.text isEqualToString:@"OnePlus 2"]){
        [[cell imageView] setImage: [UIImage imageNamed:@"oneplus-2.jpg"]];
    } else if ([cell.textLabel.text isEqualToString:@"OnePlus 3"]){
        [[cell imageView] setImage: [UIImage imageNamed:@"oneplus-3t.jpg"]];
    }
    else if ([cell.textLabel.text isEqualToString:@"Mi Note 2"]){
        [[cell imageView] setImage: [UIImage imageNamed:@"mi_note2.jpg"]];
    } else if ([cell.textLabel.text isEqualToString:@"Mi 5"]){
        [[cell imageView] setImage: [UIImage imageNamed:@"mi5.jpg"]];
    } else if ([cell.textLabel.text isEqualToString:@"Mi Max"]){
        [[cell imageView] setImage: [UIImage imageNamed:@"mi_max.jpg"]];
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

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    
    self.productPageViewController = [[ProductPageViewController alloc] init];

    if([self.title isEqualToString:@"Apple mobile devices"]){
        switch (indexPath.row) {
            case 0:
                self.productPageViewController.title = @"iPad";
                break;
            case 1:
                self.productPageViewController.title = @"iPod Touch";
                break;
            case 2:
                self.productPageViewController.title = @"iPhone";
                break;
            default:
                break;
        }
    } else if([self.title isEqualToString:@"Samsung mobile devices"]){
        switch (indexPath.row) {
            case 0:
                self.productPageViewController.title = @"Galaxy S4";
                break;
            case 1:
                self.productPageViewController.title = @"Galaxy Note";
                break;
            case 2:
                self.productPageViewController.title = @"Galaxy Tab";
                break;
            default:
                break;
        }
    } else if([self.title isEqualToString:@"OnePlus Mobile Devices"]){
        switch (indexPath.row) {
            case 0:
                self.productPageViewController.title = @"OnePlus X";
                break;
            case 1:
                self.productPageViewController.title = @"OnePlus 2";
                break;
            case 2:
                self.productPageViewController.title = @"OnePlus 3";
                break;
            default:
                break;
        }
    } else if([self.title isEqualToString:@"XiaoMi Mobile Devices"]){
        switch (indexPath.row) {
            case 0:
                self.productPageViewController.title = @"Mi Note 2";
                break;
            case 1:
                self.productPageViewController.title = @"Mi 5";
                break;
            case 2:
                self.productPageViewController.title = @"Mi Max";
                break;
            default:
                break;
        }
    }
    
    
    [self.navigationController
     pushViewController:self.productPageViewController
     animated:YES];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.

}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //remove the deleted object from your data source.
        //If your data source is an NSMutableArray, do this
        [self.products removeObjectAtIndex:[indexPath row]];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [tableView reloadData]; // tell table to refresh now
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSString *stringToMove = [self.products objectAtIndex:sourceIndexPath.row];
    [self.products removeObjectAtIndex:sourceIndexPath.row];
    [self.products insertObject:stringToMove atIndex:destinationIndexPath.row];
}

@end
