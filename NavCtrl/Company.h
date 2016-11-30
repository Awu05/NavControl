//
//  Company.h
//  NavCtrl
//
//  Created by Andy Wu on 11/30/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"


@interface Company : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) NSMutableArray *productList;

- (instancetype)initWithName: (NSString*) name
                     andLogo: (NSString*) logoName
                 andProdList: (NSMutableArray*) prodList;


@end
