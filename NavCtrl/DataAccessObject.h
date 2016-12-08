//
//  DataAccessObject.h
//  NavCtrl
//
//  Created by Andy Wu on 11/30/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ManagedCompany+CoreDataClass.h"
#import "ManagedProduct+CoreDataClass.h"
#import "ManagedCompany+CoreDataProperties.h"
#import "ManagedProduct+CoreDataProperties.h"
#import "Company.h"


@interface DataAccessObject : NSObject

@property (nonatomic, retain) NSMutableArray *companyList;

@property (strong) NSMutableArray<ManagedCompany*> *managedCompanyList;

//@property (strong) NSManagedObjectContext *managedObjectContext;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;

- (void) loadCompanies;

- (void) firstRun;

- (void) deleteCompany: (Company *) company;

- (void) deleteProduct:(Company *) company andProduct: (Product *) product;

- (void) saveCompany:(Company *) company;

- (void) saveProduct:(Company *) company andProduct: (Product *) product;

- (void) editCompany:(Company *) oldCompany andEditedCompany: (Company *) newCompany;

- (void) editProduct:(Company *) company andOldProduct: (Product *) product andEditedProduct: (Product *) editedProduct ;

+ (id)sharedManager;

@end
