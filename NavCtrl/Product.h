//
//  Product.h
//  NavCtrl
//
//  Created by Andy Wu on 11/30/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property (nonatomic, retain) NSString *productName;
@property (nonatomic, retain) UIImage *productImage;
@property (nonatomic, retain) NSString *productURL;



- (instancetype)initWithName: (NSString*) name
                    andImage: (NSString*) imageName
                  andProdURL: (NSString*) prodURL;



@end
