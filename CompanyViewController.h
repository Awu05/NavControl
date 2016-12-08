//
//  CompanyViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataAccessObject.h"
#import "Company.h"

@class ProductViewController;

@interface CompanyViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) DataAccessObject *mySharedData;

@property (nonatomic, retain) IBOutlet  ProductViewController * productViewController;

@property (nonatomic, retain) NSString *stockPrice;

@property (nonatomic, retain) NSMutableString *tickers;

- (void) getStockPrice;

- (void) assignStockPrice: (NSData*) data;

@end
