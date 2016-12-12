//
//  ProductsViewController.h
//  NavCtrl
//
//  Created by Andy Wu on 12/7/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "Company.h"
#import "DataAccessObject.h"
#import "ProductPageViewController.h"


@interface ProductsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) IBOutlet UILabel *companyName;

@property (retain, nonatomic) IBOutlet UIImageView *companyIcon;

@property (retain, nonatomic) IBOutlet UITableView *tableView;

@property (retain, nonatomic) IBOutlet UIView *noProduct;

- (IBAction)addProduct:(id)sender;

@property (nonatomic, retain) Company *currentCompany;

@property (nonatomic, retain) DataAccessObject *mySharedData;

@property (nonatomic, retain) ProductPageViewController *productPageViewController;



@end
