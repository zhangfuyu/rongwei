//
//  DFRegisteredSecondViewController.m
//  rongwei
//
//  Created by apple on 2019/11/1.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFRegisteredSecondViewController.h"
#import "DFTextField.h"

@interface DFRegisteredSecondViewController ()

@property (nonatomic , strong)DFTextField *password;

@property (nonatomic , strong)DFTextField *againPassword;

@end

@implementation DFRegisteredSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"注册（2/2）";
    
    self.password = [[DFTextField alloc] init];
    self.password.font = HScaleFont(15);
    self.password.placeholder = @"密码（8-16位数字或字)";
    self.password.backgroundColor = [UIColor colorWithHexString:@"F5F5F5"];
    self.password.layer.cornerRadius = HScaleHeight(3);
    self.password.layer.masksToBounds = true;
    self.password.keyboardType = UIKeyboardTypePhonePad;
    self.password.returnKeyType = UIReturnKeyDone;
    self.password.maxInputDigit = 11;
    self.password.endEditingDigit = 11;
    self.password.leftSpace = HScaleWidth(45);
    [self.view addSubview:self.password];
    
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HScaleWidth(25));
        make.right.mas_equalTo(-HScaleWidth(25));
        make.top.mas_equalTo(HScaleHeight(27) + kNavBarAndStatusBarHeight);
        make.height.mas_equalTo(HScaleHeight(45));
    }];
    
    
    UIView *leftview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, HScaleWidth(45), HScaleHeight(45))];
    UIImageView *leftiamge = [[UIImageView alloc]init];
    leftiamge.image = [UIImage imageNamed:@"密码"];
    [leftview addSubview:leftiamge];
    
    [leftiamge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(HScaleWidth(14), HScaleHeight(20)));
        make.centerX.mas_equalTo(leftview.mas_centerX);
        make.centerY.mas_equalTo(leftview.mas_centerY);
    }];
    
    [self.password addSubview:leftview];
    
    
    self.againPassword = [[DFTextField alloc] init];
    self.againPassword.font = HScaleFont(15);
    self.againPassword.placeholder = @"再次输入";
    self.againPassword.backgroundColor = [UIColor colorWithHexString:@"F5F5F5"];
    self.againPassword.layer.cornerRadius = HScaleHeight(3);
    self.againPassword.layer.masksToBounds = true;
    self.againPassword.returnKeyType = UIReturnKeyDone;
    self.againPassword.keyboardType = UIKeyboardTypePhonePad;

    self.againPassword.maxInputDigit = 11;
    self.againPassword.endEditingDigit = 11;
    self.againPassword.leftSpace = HScaleWidth(45);
    [self.view addSubview:self.againPassword];
    
    [self.againPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HScaleWidth(25));
        make.right.mas_equalTo(-HScaleWidth(25));
        make.top.mas_equalTo(self.password.mas_bottom).offset(HScaleHeight(15));
        make.height.mas_equalTo(HScaleHeight(45));
    }];
    
    UIView *leftview2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, HScaleWidth(45), HScaleHeight(45))];
    UIImageView *leftiamge2 = [[UIImageView alloc]init];
    leftiamge2.image = [UIImage imageNamed:@"密码"];
    [leftview2 addSubview:leftiamge2];
    
    [leftiamge2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(HScaleWidth(14), HScaleHeight(20)));
        make.centerX.mas_equalTo(leftview2.mas_centerX);
        make.centerY.mas_equalTo(leftview2.mas_centerY);
    }];
    
    [self.againPassword addSubview:leftview2];
    
    UIButton *updown = [UIButton buttonWithType:UIButtonTypeCustom];
    [updown setTitle:@"下一步" forState:UIControlStateNormal];
    [updown setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:UIControlStateNormal];
    updown.titleLabel.font = HScaleFont(15);
    updown.backgroundColor = [UIColor colorWithHexString:@"108EE9"];
    updown.layer.cornerRadius = 2.5;
    [self.view addSubview:updown];
    [updown addTarget:self action:@selector(TheNextStep) forControlEvents:UIControlEventTouchUpInside];
    
    [updown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HScaleWidth(25));
        make.right.mas_equalTo(-HScaleWidth(25));
        make.top.mas_equalTo(self.againPassword.mas_bottom).offset(HScaleHeight(15));
        make.height.mas_equalTo(HScaleHeight(45));
        
    }];
    
}
- (void)TheNextStep
{
     if (self.password.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入您的密码"];
            return;
        }
        
    if (self.againPassword.text.length== 0) {
        [SVProgressHUD showErrorWithStatus:@"请再次输入您的密码"];
        return;
    }
    if (![self.password.text isEqualToString:self.againPassword.text]) {
        [SVProgressHUD showErrorWithStatus:@"密码不一致"];
        return;
    }
        
    NSMutableDictionary *parmar = [@{
        @"phone":self.phoneNumber,
        @"code":self.code,
        @"password":self.password.text
    }copy];
        
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:RegisterUser withParameter:parmar withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:NO withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
            
        
        if (![response[@"status"] isEqualToString:@"ok"]) {
                    
            [SVProgressHUD showErrorWithStatus:response[@"data"]];
            return;
        }
            
        [DFUserModelTool shareInstance].isLogin = YES;
        [self.navigationController popoverPresentationController];
          
        
    }];
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
