//
//  ProductPageViewController.h
//  NavCtrl
//
//  Created by Andy Wu on 11/29/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface ProductPageViewController : UIViewController <WKNavigationDelegate>

@property (strong, nonatomic) WKWebView *webView;
@property (strong, nonatomic) NSString *productURL;

@end
