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

@implementation DataAccessObject

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
        self.companyList = [[NSMutableArray alloc] init];
        
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
    }
    return self;
}

@end
