//
//  AddEditViewController.h
//  NavCtrl
//
//  Created by Andy Wu on 12/1/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataAccessObject.h"
#import "Company.h"
#import "Product.h"
#import "ProductViewController.h"


@interface AddEditViewController : UIViewController

@property (nonatomic, retain) DataAccessObject *mySharedData;

@property (nonatomic, retain) Company *editCompany;

@property (nonatomic, retain) Product *editProduct;

@property (nonatomic, retain) NSArray *viewcontrollers;

@property int keyboardOut;

@end
