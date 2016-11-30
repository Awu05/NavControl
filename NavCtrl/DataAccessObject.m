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
        
        Company *apple = [[Company alloc] initWithName:@"Apple Mobile Devices" andLogo:@"Apple_Logo.jpg" andProdList:appleProducts];
        
        [self.companyList addObject: apple];
        
        //--------------------------------------
        
        Product *galaxyS4 = [[Product alloc] initWithName:@"Galaxy S4" andImage:@"samsung_s4.jpg" andProdURL:@"http://www.samsung.com/us/"];
        
        Product *galaxyNote = [[Product alloc] initWithName:@"Galaxy Note" andImage:@"samsung_note.jpg" andProdURL:@"http://www.samsung.com/us/"];
        
        Product *galaxyTab = [[Product alloc] initWithName:@"Galaxy Tab" andImage:@"samsung_tab.jpg" andProdURL:@"http://www.samsung.com/us/"];
        
        
        NSMutableArray *samsungProducts = [NSMutableArray arrayWithObjects:galaxyS4, galaxyNote, galaxyTab, nil];
        
        Company *samsung = [[Company alloc] initWithName:@"Samsung Mobile Devices" andLogo:@"Samsung_Logo.jpg" andProdList:samsungProducts];
        
        [self.companyList addObject: samsung];
        
        //--------------------------------------
        
        Product *oneplus2 = [[Product alloc] initWithName:@"OnePlus 2" andImage:@"oneplus-2.jpg" andProdURL:@"https://oneplus.net/"];
        
        Product *oneplus3 = [[Product alloc] initWithName:@"OnePlus 3" andImage:@"oneplus-3t.jpg" andProdURL:@"https://oneplus.net/"];
        
        Product *oneplusx = [[Product alloc] initWithName:@"OnePlus X" andImage:@"oneplus-x.jpg" andProdURL:@"https://oneplus.net/"];
        
        
        NSMutableArray *onePlusProducts = [NSMutableArray arrayWithObjects:oneplusx, oneplus2, oneplus3, nil];
        
        Company *onePlus = [[Company alloc] initWithName:@"OnePlus Mobile Devices" andLogo:@"OnePlus_logo.jpg" andProdList:onePlusProducts];
        
        [self.companyList addObject: onePlus];
        
        //--------------------------------------
        
        Product *mi_note = [[Product alloc] initWithName:@"Mi Note 2" andImage:@"mi_note2.jpg" andProdURL:@"http://www.mi.com/en/"];
        
        Product *mi5 = [[Product alloc] initWithName:@"Mi 5" andImage:@"mi5.jpg" andProdURL:@"http://www.mi.com/en/"];
        
        Product *mi_max = [[Product alloc] initWithName:@"Mi Max" andImage:@"mi_max.jpg" andProdURL:@"http://www.mi.com/en/"];
        
        
        NSMutableArray *xiaomiProducts = [NSMutableArray arrayWithObjects:mi_note, mi5, mi_max, nil];
        
        Company *xiaoMi = [[Company alloc] initWithName:@"XiaoMi Mobile Devices" andLogo:@"Xiaomi_logo.jpg" andProdList:xiaomiProducts];
        
        [self.companyList addObject: xiaoMi];
        
        //--------------------------------------
    }
    return self;
}

@end
