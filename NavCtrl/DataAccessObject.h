//
//  DataAccessObject.h
//  NavCtrl
//
//  Created by Andy Wu on 11/30/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataAccessObject : NSObject


@property (nonatomic, retain) NSMutableArray *companyList;

+ (id)sharedManager;

@end
