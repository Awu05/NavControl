//
//  CompanyViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "CompanyViewController.h"
#import "ProductViewController.h"
#import "Company.h"
#import "Product.h"
#import "AddEditViewController.h"

@interface CompanyViewController ()

@end

@implementation CompanyViewController

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

    self.mySharedData = [DataAccessObject sharedManager];
    
    UIBarButtonItem *addButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction:)];
    self.navigationItem.rightBarButtonItem = addButtonItem;
    
    
    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    
    self.title = @"Mobile device makers";
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self getStockPrice];
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
//#warning Incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.mySharedData.companyList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    Company *company = [self.mySharedData.companyList objectAtIndex:[indexPath row]];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ (%@)", company.name, company.stockName];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"$ %.4f", company.stockPrice];
    
    cell.imageView.image = company.image;
    
    return cell;
}

- (void) addAction: (id)sender {
    
    AddEditViewController *addEdit = [[AddEditViewController alloc] init];
    addEdit.title = @"New Company";
    [self.navigationController pushViewController:addEdit animated:YES];
    
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Company *company = [self.mySharedData.companyList objectAtIndex:[indexPath row]];
    
    if(tableView.editing == YES) {
        AddEditViewController *addEdit = [[AddEditViewController alloc] init];
        addEdit.title = @"Edit Company";
        addEdit.editCompany = company;
        [self.navigationController pushViewController:addEdit animated:YES];
    }
    else {
        self.productViewController.currentCompany = company;
        self.productViewController.title = company.name;
        [self.navigationController
         pushViewController:self.productViewController
         animated:YES];
    }
    
    

}
 
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //remove the deleted object from your data source.
        //If your data source is an NSMutableArray, do this
        [self.mySharedData.companyList removeObjectAtIndex:[indexPath row]];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [tableView reloadData]; // tell table to refresh now
    }
    else {
        
    }
    
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSString *stringToMove = [self.mySharedData.companyList objectAtIndex:sourceIndexPath.row];
    [self.mySharedData.companyList removeObjectAtIndex:sourceIndexPath.row];
    [self.mySharedData.companyList insertObject:stringToMove atIndex:destinationIndexPath.row];
}

- (void) getStockPrice {
    self.tickers = [[NSMutableString alloc] init];
    
    for (Company *company in self.mySharedData.companyList) {
        //[self.tickers addObject:company.stockName];
        [self.tickers appendString: company.stockName];
        [self.tickers appendString: @"+"];
    }
    //NSLog(@"Tickers: %@\n", self.tickers);
    
    NSString *tickerURL = [NSString stringWithFormat:@"http://finance.yahoo.com/d/quotes.csv?s=%@&f=a", self.tickers];
    
    // 1
    NSString *dataUrl = tickerURL;
    NSURL *url = [NSURL URLWithString:dataUrl];
    
    // 2
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
                                          dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                              // 4: Handle response here
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  [self assignStockPrice:data];
                                                  
                                              });
                                              
                                          }];
    
    // 3
    [downloadTask resume];
    
    //NSLog(@"Stock Price %@\n", tickerURL);
    
}

- (void) assignStockPrice: (NSData*) data {
    self.stockPrice = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    //NSLog(@"Price: %@\n", self.stockPrice);
    
    NSArray *wordList = [self.stockPrice componentsSeparatedByString:@"\n"];
    //NSLog(@"WordList %@\n", wordList);
    
    int i = 0;
    for (Company *company in self.mySharedData.companyList) {
        double price = [wordList[i] doubleValue];
        company.stockPrice = price;
        i++;
    }
    
    [self.tableView reloadData];
    
}

@end
