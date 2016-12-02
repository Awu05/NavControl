//
//  AddEditViewController.m
//  NavCtrl
//
//  Created by Andy Wu on 12/1/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "AddEditViewController.h"
#import "CompanyViewController.h"
#import "Company.h"
#import "ProductViewController.h"

@interface AddEditViewController ()


@property (retain, nonatomic) IBOutlet UITextField *companyName;
@property (retain, nonatomic) IBOutlet UITextField *productURL;

- (IBAction)deleteBtn:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *deleteBtnProperty;

@end

@implementation AddEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.viewcontrollers = self.navigationController.viewControllers;
    
    UIBarButtonItem *cancelButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAction:)];
    self.navigationItem.leftBarButtonItem = cancelButtonItem;
    
    UIBarButtonItem *saveButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveAction:)];
    self.navigationItem.rightBarButtonItem = saveButtonItem;
    
    self.mySharedData = [DataAccessObject sharedManager];
    
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 2;
    border.borderColor = [UIColor darkGrayColor].CGColor;
    border.frame = CGRectMake(0, self.companyName.frame.size.height - borderWidth, self.companyName.frame.size.width*2, self.companyName.frame.size.height);
    border.borderWidth = borderWidth;
    [self.companyName.layer addSublayer:border];
    self.companyName.layer.masksToBounds = YES;
    
    CALayer *border2 = [CALayer layer];
    border2.borderColor = [UIColor darkGrayColor].CGColor;
    border2.frame = CGRectMake(0, self.productURL.frame.size.height - borderWidth, self.productURL.frame.size.width*2, self.productURL.frame.size.height);
    border2.borderWidth = borderWidth;
    [self.productURL.layer addSublayer:border2];
    self.productURL.layer.masksToBounds = YES;
    
    self.productURL.placeholder = @"Company Stock Symbol";
    
    
    if([self.title isEqualToString: @"Edit Company"]) {
        self.deleteBtnProperty.hidden = false;
        self.companyName.text = self.editCompany.name;
        self.productURL.placeholder = @"Company Stock Symbol";
        self.productURL.text = self.editCompany.stockName;
        
    } else if([self.title isEqualToString: @"New Product"]){
        self.deleteBtnProperty.hidden = true;
        self.companyName.placeholder = @"Product Name";
        //self.productURL.hidden = false;
        
        CALayer *border = [CALayer layer];
        CGFloat borderWidth = 2;
        border.borderColor = [UIColor darkGrayColor].CGColor;
        border.frame = CGRectMake(0, self.productURL.frame.size.height - borderWidth, self.productURL.frame.size.width*2, self.productURL.frame.size.height);
        border.borderWidth = borderWidth;
        [self.productURL.layer addSublayer:border];
        self.productURL.layer.masksToBounds = YES;
        
    } else if([self.title isEqualToString: @"Edit Product"]){
        self.deleteBtnProperty.hidden = false;
        self.companyName.text = self.editProduct.productName;
        self.companyName.placeholder = @"Product Name";
        self.productURL.hidden = false;
        self.productURL.text = self.editProduct.productURL;
        
        CALayer *border = [CALayer layer];
        CGFloat borderWidth = 2;
        border.borderColor = [UIColor darkGrayColor].CGColor;
        border.frame = CGRectMake(0, self.productURL.frame.size.height - borderWidth, self.productURL.frame.size.width*2, self.productURL.frame.size.height);
        border.borderWidth = borderWidth;
        [self.productURL.layer addSublayer:border];
        self.productURL.layer.masksToBounds = YES;
    }
    
    self.keyboardOut = 0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)keyboardWillShow:(NSNotification*)aNotification {
    [UIView animateWithDuration:0.25 animations:^
     {
         self.keyboardOut++;
         
         if(self.keyboardOut == 1){
             CGSize keyboardSize = [[[aNotification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
             
             //Given size may not account for screen rotation
             int height = MIN(keyboardSize.height,keyboardSize.width);
             //int width = MAX(keyboardSize.height,keyboardSize.width);
             CGRect newFrame = [self.view frame];
             newFrame.origin.y -= height; // tweak here to adjust the moving position
             
             [self.view setFrame:newFrame];
         }
         
         
     }completion:^(BOOL finished)
     {
         
     }];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    [UIView animateWithDuration:0.25 animations:^
     {
         CGSize keyboardSize = [[[aNotification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
         
         int height = MIN(keyboardSize.height,keyboardSize.width);
         
         CGRect newFrame = [self.view frame];
         newFrame.origin.y += height; // tweak here to adjust the moving position
         [self.view setFrame:newFrame];
         
         self.keyboardOut = 0;
         
     }completion:^(BOOL finished)
     {
         
     }];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) cancelAction: (id)sender {
    //NSLog(@"Cancel Button Pressed!\n");
    
    [self.navigationController popViewControllerAnimated:true];
}

- (void) saveAction: (id)sender {
    //NSLog(@"Save Button Pressed!\n");
    
    if([self.title isEqualToString: @"Edit Company"]) {
        self.editCompany.name = self.companyName.text;

        [self.navigationController popViewControllerAnimated:true];
        
    } else if([self.title isEqualToString: @"New Company"]){
        NSMutableArray *list = [[NSMutableArray alloc] init];
        
        Company *newCompany = [[Company alloc] initWithName:self.companyName.text andLogo:@"stock_company_logo.jpg" andProdList:list andStockName:self.productURL.text];
        
        [self.mySharedData.companyList addObject:newCompany];
        
        
        
        [self.navigationController popViewControllerAnimated:true];
        
    } else if([self.title isEqualToString: @"New Product"]){
        Product *newProduct = [[Product alloc] initWithName:self.companyName.text andImage:@"stock_product.jpg" andProdURL:self.productURL.text];
        
        [self.editCompany.productList addObject:newProduct];

        [self.navigationController popViewControllerAnimated:true];
        
    } else if([self.title isEqualToString: @"Edit Product"]){
        self.editProduct.productName = self.companyName.text;
        self.editProduct.productURL = self.productURL.text;
        
        [self.navigationController popToViewController:self.viewcontrollers[1] animated:YES];
    }
    
    
    
}

- (void)dealloc {
    [_companyName release];
    [_productURL release];
    [_deleteBtnProperty release];
    [super dealloc];
}

- (IBAction)deleteBtn:(id)sender {
    
    if([self.title isEqualToString: @"Edit Company"]) {
        [self.mySharedData.companyList removeObject:self.editCompany];

        [self.navigationController popViewControllerAnimated:true];
    }
    else if([self.title isEqualToString: @"Edit Product"]){
        [self.editCompany.productList removeObject:self.editProduct];
        
        [self.navigationController popToViewController:self.viewcontrollers[1] animated:YES];
    }
}

@end
