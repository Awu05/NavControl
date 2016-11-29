//
//  ProductViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@class ProductPageViewController;

@interface ProductViewController : UITableViewController

@property (nonatomic, retain) NSMutableArray *products;
@property (nonatomic, retain) NSMutableArray *apple;
@property (nonatomic, retain) NSMutableArray *samsung;
@property (nonatomic, retain) NSMutableArray *oneplus;
@property (nonatomic, retain) NSMutableArray *xiaomi;

@property (nonatomic, retain) IBOutlet  ProductPageViewController * productPageViewController;

@end
