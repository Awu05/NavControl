//
//  CompanyViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataAccessObject.h"

@class ProductViewController;

@interface CompanyViewController : UITableViewController

@property (nonatomic, retain) DataAccessObject *mySharedData;

@property (nonatomic, retain) IBOutlet  ProductViewController * productViewController;


@end
