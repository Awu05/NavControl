//
//  CompaniesViewController.h
//  NavCtrl
//
//  Created by Andy Wu on 12/6/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataAccessObject.h"
#import "Company.h"
#import "ProductsViewController.h"

@interface CompaniesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) DataAccessObject *mySharedData;

@property (retain, nonatomic) IBOutlet UIView *noCompanies;

- (IBAction)addCompany:(id)sender;


@property (retain, nonatomic) IBOutlet UIButton *redo;

@property (retain, nonatomic) IBOutlet UIButton *undo;

- (IBAction)redoBtn:(id)sender;

- (IBAction)undoBtn:(id)sender;

@property (retain, nonatomic) IBOutlet UITableView *tableView;

//@property (nonatomic, retain)  ProductsViewController * productsViewController;

@property (nonatomic, retain) NSString *stockPrice;

@property (nonatomic, retain) NSMutableString *tickers;

- (void) getStockPrice;

- (void) assignStockPrice: (NSData*) data;

@end
