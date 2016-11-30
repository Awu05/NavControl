//
//  ProductPageViewController.m
//  NavCtrl
//
//  Created by Andy Wu on 11/29/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "ProductPageViewController.h"
#import "ProductViewController.h"

@interface ProductPageViewController ()

@end

@implementation ProductPageViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    if ([self.title isEqualToString:@"iPad"]) {
        self.productURL = @"http://www.Apple.com";
    } else if ([self.title isEqualToString:@"iPod Touch"]){
        self.productURL = @"http://www.Apple.com";
    } else if ([self.title isEqualToString:@"iPhone"]) {
        self.productURL = @"http://www.Apple.com";
    }
    else if ([self.title isEqualToString:@"Galaxy S4"]){
        self.productURL = @"http://www.samsung.com/us/";
    } else if ([self.title isEqualToString:@"Galaxy Note"]) {
        self.productURL = @"http://www.samsung.com/us/";
    } else if ([self.title isEqualToString:@"Galaxy Tab"]){
        self.productURL = @"http://www.samsung.com/us/";
    }
    else if ([self.title isEqualToString:@"OnePlus X"]) {
        self.productURL = @"https://oneplus.net/";
    } else if ([self.title isEqualToString:@"OnePlus 2"]){
        self.productURL = @"https://oneplus.net/";
    } else if ([self.title isEqualToString:@"OnePlus 3"]) {
        self.productURL = @"https://oneplus.net/";
    }
    else if ([self.title isEqualToString:@"Mi Note 2"]){
        self.productURL = @"http://www.mi.com/en/";
    } else if ([self.title isEqualToString:@"Mi 5"]) {
        self.productURL = @"http://www.mi.com/en/";
    } else if ([self.title isEqualToString:@"Mi Max"]){
        self.productURL = @"http://www.mi.com/en/";
    }
    
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:theConfiguration];
    
    NSURL *nsurl=[NSURL URLWithString:self.productURL];
    
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    
    [webView loadRequest:nsrequest];
    
    [self.view addSubview:webView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
