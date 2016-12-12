//
//  DataAccessObject.m
//  NavCtrl
//
//  Created by Andy Wu on 11/30/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "DataAccessObject.h"
#import "Product.h"
#import "Company.h"

@implementation DataAccessObject {
   NSPersistentContainer *_persistentContainer;
}

+ (id)sharedManager {
    static DataAccessObject *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _companyList = [[NSMutableArray alloc] init];
        self.managedCompanyList = [NSMutableArray array];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        static NSString* const hasRunAppOnceKey = @"hasRunAppOnceKey";
        if ([defaults boolForKey:hasRunAppOnceKey] == NO)
        {
            // Some code you want to run on first use...
            [self firstRun];
            [defaults setBool:YES forKey:hasRunAppOnceKey];
        }
        else {
            //Load data from Core Data
            [self loadCompanies];
            
        }
        
        
        
    }
    return self;
}

#pragma mark - Core Data stack

//@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Model"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
            
            NSUndoManager *undoManager = [[NSUndoManager  alloc] init];
            [self.persistentContainer.viewContext setUndoManager:undoManager];
            [undoManager release];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSLog(@"Saving Information.\n");
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

- (void) loadCompanies {
    NSLog(@"Loading Data from Core Data\n");
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ManagedCompany"];
    NSArray *loadedCompanies = [context executeFetchRequest:request error:nil];
    
    
    self.companyList = [NSMutableArray array];
    
    for (ManagedCompany* mC in loadedCompanies) {
        NSMutableArray *prodList = [NSMutableArray array];
        
        for(ManagedProduct *mP in mC.products) {
            Product *addProduct = [[Product alloc] initWithName:mP.productName andImage:mP.productImage andProdURL:mP.productURL];
            [prodList addObject:addProduct];
            
            [addProduct release];
        }
        
        Company *addCompany = [[Company alloc] initWithName:mC.name andLogo:mC.image andProdList:prodList andStockName:mC.tickerSymbol];
        
        [self.companyList addObject:addCompany];
        [self.managedCompanyList addObject:mC];
        
        [addCompany release];
        //[prodList release];
    }
    //NSLog(@"%@\n", self.managedCompanyList);
}

- (void) deleteCompany:(Company *)company {
    int index = 0;
    for (ManagedCompany *mC in self.managedCompanyList) {
        if([mC.name isEqualToString:company.name]){
            index = (int)[self.managedCompanyList indexOfObject:mC];
            //NSLog(@"Removing %@ at index %d\n", mC.name, index);
        }
    }
    
    NSLog(@"Deleting Company\n");
    
    ManagedCompany *deleteCompany = [self.managedCompanyList objectAtIndex:index];
    
    [self.persistentContainer.viewContext deleteObject:deleteCompany];
    [self.managedCompanyList removeObjectAtIndex:index];

    [self saveContext];
}

- (void) deleteProduct:(Company *)company andProduct:(Product *)product {
    NSLog(@"Deleting Product\n");
    ManagedProduct *deleteProduct = [ManagedProduct alloc];
    for (ManagedCompany *mC in self.managedCompanyList) {
        if([mC.name isEqualToString:company.name]){
            
            NSArray *products = [mC.products allObjects];
            for (ManagedProduct *mP in products) {
                if([mP.productName isEqualToString:product.productName]){
                    deleteProduct = mP;
                    //NSLog(@"Removing %@: %@ \n", mC.name, mP.productName);
                }
            }
            
            
        }
    }

    [self.persistentContainer.viewContext deleteObject:deleteProduct];
    
    [self saveContext];
}

- (void) saveCompany:(Company *) company {
    NSLog(@"Saving Company\n");
    ManagedCompany *mC = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedCompany" inManagedObjectContext:self.persistentContainer.viewContext];
    
    mC.name = company.name;
    mC.tickerSymbol = company.stockName;
    mC.image = company.imageFileName;
    
    [self.managedCompanyList addObject:mC];
    
    [self saveContext];
}

- (void) saveProduct:(Company *)company andProduct:(Product *)product {
    NSLog(@"Saving Product\n");
    for (ManagedCompany *mC in self.managedCompanyList) {
        if([mC.name isEqualToString:company.name]){
            
            ManagedProduct *addProduct = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedProduct" inManagedObjectContext:self.persistentContainer.viewContext];
            
            addProduct.productName = product.productName;
            addProduct.productURL = product.productURL;
            addProduct.productImage = product.imageFileName;
            
            [mC addProductsObject:addProduct];
        }
    }
    
    //[self.persistentContainer.viewContext ];
    
    [self saveContext];
    
    
}

- (void) editCompany:(Company *) oldCompany andEditedCompany: (Company *) newCompany{
    for (ManagedCompany *mC in self.managedCompanyList) {
        if([mC.name isEqualToString:oldCompany.name]){
            
            mC.name = newCompany.name;
            mC.tickerSymbol = newCompany.stockName;
        }
    }
    
    [self saveContext];
}

- (void) editProduct:(Company *) company andOldProduct: (Product *) product andEditedProduct: (Product *) editedProduct {
    for (ManagedCompany *mC in self.managedCompanyList) {
        if([mC.name isEqualToString:company.name]){
            for (ManagedProduct *mP in mC.products) {
                if([mP.productName isEqualToString:product.productName]){
                    mP.productName = editedProduct.productName;
                    mP.productURL = editedProduct.productURL;
                }
            }
        }
    }
    
    [self saveContext];
}

- (void) firstRun {
    NSLog(@"First Run Called!\n");
    
    Product *iPad = [[Product alloc] initWithName:@"iPad" andImage:@"ipad.jpg" andProdURL:@"http://www.apple.com/"];
    
    Product *iPod_Touch = [[Product alloc] initWithName:@"iPod Touch" andImage:@"ipod_touch.jpg" andProdURL:@"http://www.apple.com/"];
    
    Product *iPhone = [[Product alloc] initWithName:@"iPhone" andImage:@"iphone7.jpg" andProdURL:@"http://www.apple.com/"];
    
    
    NSMutableArray *appleProducts = [NSMutableArray arrayWithObjects:iPad, iPod_Touch, iPhone, nil];
    
    Company *apple = [[Company alloc] initWithName:@"Apple Mobile Devices" andLogo:@"Apple_Logo.jpg" andProdList:appleProducts andStockName:@"AAPL"];
    
    [self.companyList addObject: apple];
    
    
    
    //--------------------------------------
    
    Product *galaxyS4 = [[Product alloc] initWithName:@"Galaxy S4" andImage:@"samsung_s4.jpg" andProdURL:@"http://www.samsung.com/us/"];
    
    Product *galaxyNote = [[Product alloc] initWithName:@"Galaxy Note" andImage:@"samsung_note.jpg" andProdURL:@"http://www.samsung.com/us/"];
    
    Product *galaxyTab = [[Product alloc] initWithName:@"Galaxy Tab" andImage:@"samsung_tab.jpg" andProdURL:@"http://www.samsung.com/us/"];
    
    
    NSMutableArray *samsungProducts = [NSMutableArray arrayWithObjects:galaxyS4, galaxyNote, galaxyTab, nil];
    
    Company *samsung = [[Company alloc] initWithName:@"Samsung Mobile Devices" andLogo:@"Samsung_Logo.jpg" andProdList:samsungProducts andStockName:@"SMSD.L"];
    
    [self.companyList addObject: samsung];
    
    
    
    //--------------------------------------
    
    Product *google_pixel = [[Product alloc] initWithName:@"Google Pixel" andImage:@"google_pixel.jpg" andProdURL:@"https://madeby.google.com/phone/"];
    
    Product *nexus6p = [[Product alloc] initWithName:@"Google Nexus 6P" andImage:@"google-nexus-6p.jpg" andProdURL:@"https://madeby.google.com/phone/"];
    
    Product *nexus5x = [[Product alloc] initWithName:@"Google Nexus 5X" andImage:@"nexus-5x.jpg" andProdURL:@"https://madeby.google.com/phone/"];
    
    
    NSMutableArray *googleProducts = [NSMutableArray arrayWithObjects:google_pixel, nexus6p, nexus5x, nil];
    
    Company *google = [[Company alloc] initWithName:@"Google Mobile Devices" andLogo:@"google_logo.jpg" andProdList:googleProducts andStockName:@"GOOG"];
    
    [self.companyList addObject: google];
    
    
    
    //--------------------------------------
    
    Product *droid_turbo2 = [[Product alloc] initWithName:@"Motorola Droid Turbo 2" andImage:@"motorola-droid-turbo-2.jpg" andProdURL:@"https://www.motorola.com/us/products/moto-smartphones"];
    
    Product *moto_x = [[Product alloc] initWithName:@"Motorola Moto X" andImage:@"motorola-moto-x-force1.jpg" andProdURL:@"https://www.motorola.com/us/products/moto-smartphones"];
    
    Product *moto_z = [[Product alloc] initWithName:@"Motorola Moto Z" andImage:@"motorola-moto-z.jpg" andProdURL:@"https://www.motorola.com/us/products/moto-smartphones"];
    
    
    NSMutableArray *motoProducts = [NSMutableArray arrayWithObjects:droid_turbo2, moto_x, moto_z, nil];
    
    Company *motorola = [[Company alloc] initWithName:@"Motorola Mobile Devices" andLogo:@"motorola_logo.jpg" andProdList:motoProducts andStockName:@"MSI"];
    
    [self.companyList addObject: motorola];
    
    
    
    //--------------------------------------
    //make a managed array
    
    
    for (Company *company in self.companyList) {
        //create managed company
        ManagedCompany *mC = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedCompany" inManagedObjectContext:self.persistentContainer.viewContext];
        
        mC.name = company.name;
        mC.tickerSymbol = company.stockName;
        mC.image = company.imageFileName;
        
        for (Product *product in company.productList) {
            ManagedProduct *mP = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedProduct" inManagedObjectContext:self.persistentContainer.viewContext];
            
            mP.productName = product.productName;
            mP.productURL = product.productURL;
            mP.productImage = product.imageFileName;
            //mP.company = mC;
            
            [mC addProductsObject:mP];
        }
        [self.managedCompanyList addObject:mC];
    }
    
    [self saveContext];
    
    [iPad release];
    [iPod_Touch release];
    [iPhone release];
    //[apple release];
    
    [galaxyS4 release];
    [galaxyNote release];
    [galaxyTab release];
    //[samsung release];
    
    [google_pixel release];
    [nexus5x release];
    [nexus6p release];
    //[google release];
    
    [droid_turbo2 release];
    [moto_x release];
    [moto_z release];
    //[motorola release];
}

- (void)dealloc {
    [_companyList release];
    [_managedCompanyList release];
    
    [super dealloc];
}

@end
