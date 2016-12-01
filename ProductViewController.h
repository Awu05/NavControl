//
//  ProductViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "Company.h"
#import "DataAccessObject.h"
#import "ProductPageViewController.h"


@interface ProductViewController : UITableViewController

@property (nonatomic, retain) Company *currentCompany;
//@property (nonatomic, retain) DataAccessObject *mySharedData;

@property (nonatomic, retain) IBOutlet ProductPageViewController *productPageViewController;

@end
