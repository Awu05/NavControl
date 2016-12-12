//
//  ProductPageViewController.m
//  NavCtrl
//
//  Created by Andy Wu on 11/29/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "ProductPageViewController.h"
#import "AddEditViewController.h"

@interface ProductPageViewController ()

@end

@implementation ProductPageViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    
    _webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:theConfiguration];
    
    [self.view addSubview:self.webView];
    
    [theConfiguration release];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    NSURL *nsurl=[NSURL URLWithString:self.product.productURL];
    
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    
    [self.webView loadRequest:nsrequest];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
    [super setEditing:editing animated:animated];
  
    AddEditViewController *addEdit = [[AddEditViewController alloc] init];
    addEdit.title = @"Edit Product";
    addEdit.editProduct = self.product;
    addEdit.editCompany = self.currentProductCompany;
    [self.navigationController pushViewController:addEdit animated:YES];
    [addEdit release];
    
    
 }

- (void) dealloc {
    [_product release];
    [_webView release];
    [_currentProductCompany release];
    
    [super dealloc];
}

@end
