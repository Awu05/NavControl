//
//  Company.m
//  NavCtrl
//
//  Created by Andy Wu on 11/30/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "Company.h"

@implementation Company


//- (instancetype)init
//{
//    if (self) {
//        UIImage *def = [[UIImage alloc] init];
//        NSMutableArray *list = [NSMutableArray array];
//        return [self initWithName: @"default" andLogo: def andProdList: list];
//    }
//    return self;
//}

- (instancetype)initWithName: (NSString*) name
                    andLogo: (NSString*) logoName
                andProdList: (NSMutableArray *) prodList
                andStockName: (NSString*) ticker {
    self = [super init];
    if (self) {
        self.name = name;
        self.image = [UIImage imageNamed:logoName];
        self.productList = prodList;
        self.stockName = ticker;
        self.imageFileName = logoName;
    }
    return self;
}


@end
