//
//  CompaniesViewController.m
//  NavCtrl
//
//  Created by Andy Wu on 12/6/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "CompaniesViewController.h"
#import "ProductsViewController.h"
#import "Company.h"
#import "Product.h"
#import "AddEditViewController.h"
#import "DataAccessObject.h"

@interface CompaniesViewController ()

@end

@implementation CompaniesViewController

- (void)viewDidLoad
{
    
    _tickers = [[NSMutableString alloc] init];
    
    self.mySharedData = [DataAccessObject sharedManager];
    
    self.tableView.allowsSelectionDuringEditing = YES;
    
    UIBarButtonItem *addButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction:)];
    self.navigationItem.rightBarButtonItem = addButtonItem;
    
    // Uncomment the following line to preserve selection between presentations.
    //self.tableView.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.

    UIBarButtonItem *editButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editAction:)];
    
    self.navigationItem.leftBarButtonItem = editButtonItem;
    
    
    self.title = @"Mobile device makers";
    
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self getStockPrice];
    
    if([self.mySharedData.companyList count] == 0){
        self.tableView.hidden = true;
        self.noCompanies.hidden = false;
    }
    else {
        self.tableView.hidden = false;
        self.noCompanies.hidden = true;
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
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
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
    [addEdit release];
}

- (void) editAction: (id)sender {
    
    if ( [self.tableView isEditing] )
    {
        [self.tableView setEditing:NO animated:YES];
        self.navigationItem.leftBarButtonItem.title = @"Edit";
        self.undo.hidden = true;
        self.redo.hidden = true;
    } else
    {
        [self.tableView setEditing:YES animated:YES];
        self.navigationItem.leftBarButtonItem.title = @"Done";
        self.undo.hidden = false;
        self.redo.hidden = false;
    }
    
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Company *company = [self.mySharedData.companyList objectAtIndex:[indexPath row]];
    
    if(self.tableView.editing == YES) {
        AddEditViewController *addEdit = [[AddEditViewController alloc] init];
        addEdit.title = @"Edit Company";
        addEdit.editCompany = company;
        [self.navigationController pushViewController:addEdit animated:YES];
        [addEdit release];
    }
    else {
        
        ProductsViewController * productsviewController = [[ProductsViewController alloc] init];
        productsviewController.currentCompany = company;
        productsviewController.title = company.name;
        [self.navigationController pushViewController:productsviewController animated:YES];
        [productsviewController release];
    }
    
    
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //remove the deleted object from your data source.
        //If your data source is an NSMutableArray, do this
        
        DataAccessObject *DAO = [DataAccessObject sharedManager];
        Company *company = self.mySharedData.companyList[indexPath.row];
        [DAO deleteCompany:company];
        
        [self.mySharedData.companyList removeObjectAtIndex:[indexPath row]];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [tableView reloadData]; // tell table to refresh now
        
        if([self.mySharedData.companyList count] == 0){
            self.tableView.hidden = true;
            self.noCompanies.hidden = false;
        }
        else {
            self.tableView.hidden = false;
            self.noCompanies.hidden = true;
        }
        
    }
    
    
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    Company *company = [self.mySharedData.companyList objectAtIndex:sourceIndexPath.row];
    [company retain];
    [self.mySharedData.companyList removeObjectAtIndex:sourceIndexPath.row];
    [self.mySharedData.companyList insertObject:company atIndex:destinationIndexPath.row];
    [company release];
}

- (void) getStockPrice {
    //[self.tickers autorelease];
    [self.tickers setString: @""];
    for (Company *company in self.mySharedData.companyList) {
        //[self.tickers addObject:company.stockName];
        [self.tickers appendString: company.stockName];
        [self.tickers appendString: @"+"];
    }
    //NSLog(@"Tickers: %@\n", self.tickers);
    
    //From http://www.jarloo.com/yahoo_finance/
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
    _stockPrice = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
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
    [self.stockPrice release];
}

- (IBAction)redoBtn:(id)sender {
    NSLog(@"REDOING RECENT CHANGES!\n");
    //[self.mySharedData.persistentContainer.viewContext redo];
    [self.tableView reloadData];
}

- (IBAction)undoBtn:(id)sender {
    NSLog(@"UNDOING RECENT CHANGES!\n");
    
    [self.mySharedData.persistentContainer.viewContext undo];
    [self.mySharedData loadCompanies];
    
    if([self.mySharedData.companyList count] == 0){
        self.tableView.hidden = true;
        self.noCompanies.hidden = false;
    }
    else {
        self.tableView.hidden = false;
        self.noCompanies.hidden = true;
    }
    
    [self getStockPrice];
    [self.tableView reloadData];

    
    
}

- (IBAction)addCompany:(id)sender {
    AddEditViewController *addEdit = [[AddEditViewController alloc] init];
    addEdit.title = @"New Company";
    [self.navigationController pushViewController:addEdit animated:YES];
    [addEdit release];
}

- (void)dealloc {
    [_tableView release];
    [_redo release];
    [_undo release];
    [_noCompanies release];
    //[_productsViewController release];
    [_stockPrice release];
    [_mySharedData release];
    [_tickers release];
    
    [super dealloc];
}



@end
