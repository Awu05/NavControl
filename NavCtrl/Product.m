//
//  Product.m
//  NavCtrl
//
//  Created by Andy Wu on 11/30/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "Product.h"

@implementation Product


//- (instancetype)init
//{
//    if (self) {
//        //UIImage *def = [[UIImage alloc] init];
//        return [self initWithName: @"default" andImage: @"default" andProdURL: @"www.google.com"];
//    }
//    return self;
//}

- (instancetype)initWithName: (NSString*) name
                    andImage: (NSString*) imageName
                  andProdURL: (NSString*) prodURL{
    
    self = [super init];
    if (self) {
        self.productName = name;
        self.productImage = [UIImage imageNamed:imageName];
        self.productURL = prodURL;
        self.imageFileName = imageName;
    }
    return self;
}

- (void) dealloc {
    [_imageFileName release];
    [_productURL release];
    [_productName release];
    [_productImage release];
    
    [super dealloc];
}

@end
