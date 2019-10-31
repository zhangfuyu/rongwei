//
//  DFRegisteredFirstViewController.m
//  rongwei
//
//  Created by apple on 2019/10/31.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFRegisteredFirstViewController.h"

#import "DFTextField.h"

@interface DFRegisteredFirstViewController ()

@property (nonatomic , strong)DFTextField *phoneTextField;

@property (nonatomic , strong)DFTextField *verificationField;

@property (nonatomic , strong)UIButton *getVerificationCodeBtn;

@property (nonatomic, assign) NSInteger countDown;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation DFRegisteredFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"注册（1/2）";
    
    
    self.phoneTextField = [[DFTextField alloc] init];
    self.phoneTextField.font = HScaleFont(15);
    self.phoneTextField.placeholder = @"手机号码";
    self.phoneTextField.backgroundColor = [UIColor colorWithHexString:@"F5F5F5"];
    self.phoneTextField.layer.cornerRadius = HScaleHeight(3);
    self.phoneTextField.layer.masksToBounds = true;
    self.phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    self.phoneTextField.returnKeyType = UIReturnKeyDone;
    self.phoneTextField.maxInputDigit = 11;
    self.phoneTextField.endEditingDigit = 11;
    self.phoneTextField.leftSpace = HScaleWidth(45);
    [self.view addSubview:self.phoneTextField];
    
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HScaleWidth(25));
        make.right.mas_equalTo(-HScaleWidth(25));
        make.top.mas_equalTo(HScaleHeight(27) + kNavBarAndStatusBarHeight);
        make.height.mas_equalTo(HScaleHeight(45));
    }];
    
    
    UIView *leftview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, HScaleWidth(45), HScaleHeight(45))];
    UIImageView *leftiamge = [[UIImageView alloc]init];
    leftiamge.image = [UIImage imageNamed:@"手机"];
    [leftview addSubview:leftiamge];
    
    [leftiamge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(HScaleWidth(14), HScaleHeight(20)));
        make.centerX.mas_equalTo(leftview.mas_centerX);
        make.centerY.mas_equalTo(leftview.mas_centerY);
    }];
    
    [self.phoneTextField addSubview:leftview];
    
    
    self.verificationField = [[DFTextField alloc] init];
    self.verificationField.font = HScaleFont(15);
    self.verificationField.placeholder = @"手机号码";
    self.verificationField.backgroundColor = [UIColor colorWithHexString:@"F5F5F5"];
    self.verificationField.layer.cornerRadius = HScaleHeight(3);
    self.verificationField.layer.masksToBounds = true;
    self.verificationField.returnKeyType = UIReturnKeyDone;
    self.verificationField.keyboardType = UIKeyboardTypePhonePad;

    self.verificationField.maxInputDigit = 11;
    self.verificationField.endEditingDigit = 11;
    self.verificationField.leftSpace = HScaleWidth(45);
    [self.view addSubview:self.verificationField];
    
    [self.verificationField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HScaleWidth(25));
        make.right.mas_equalTo(-HScaleWidth(25));
        make.top.mas_equalTo(self.phoneTextField.mas_bottom).offset(HScaleHeight(15));
        make.height.mas_equalTo(HScaleHeight(45));
    }];
    
    UIView *leftview2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, HScaleWidth(45), HScaleHeight(45))];
    UIImageView *leftiamge2 = [[UIImageView alloc]init];
    leftiamge2.image = [UIImage imageNamed:@"验证码"];
    [leftview2 addSubview:leftiamge2];
    
    [leftiamge2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(HScaleWidth(14), HScaleHeight(20)));
        make.centerX.mas_equalTo(leftview2.mas_centerX);
        make.centerY.mas_equalTo(leftview2.mas_centerY);
    }];
    
    [self.verificationField addSubview:leftview2];
    
    self.verificationField.rightSpace = HScaleWidth(113.5);
    
    
    
    UIView *rightview = [[UIView alloc]init];
    
    [rightview addSubview:self.getVerificationCodeBtn];
    [self.verificationField addSubview:rightview];
    
    [rightview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.mas_equalTo(0);
        make.width.mas_equalTo(HScaleWidth(113.5));
    }];
    
    [self.getVerificationCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(HScaleWidth(113.5), HScaleHeight(45)));
        make.centerX.mas_equalTo(rightview.mas_centerX);
        make.centerY.mas_equalTo(rightview.mas_centerY);
    }];
    
    self.verificationField.rightView = rightview;
    
    
    
    UIButton *updown = [UIButton buttonWithType:UIButtonTypeCustom];
    [updown setTitle:@"下一步" forState:UIControlStateNormal];
    [updown setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:UIControlStateNormal];
    updown.titleLabel.font = HScaleFont(15);
    updown.backgroundColor = [UIColor colorWithHexString:@"108EE9"];
    updown.layer.cornerRadius = 2.5;
    [self.view addSubview:updown];
    
    [updown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HScaleWidth(25));
        make.right.mas_equalTo(-HScaleWidth(25));
        make.top.mas_equalTo(self.verificationField.mas_bottom).offset(HScaleHeight(15));
        make.height.mas_equalTo(HScaleHeight(45));
        
    }];
    
}
- (UIButton *)getVerificationCodeBtn
{
    if (!_getVerificationCodeBtn) {
        _getVerificationCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_getVerificationCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getVerificationCodeBtn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        _getVerificationCodeBtn.titleLabel.font = HScaleFont(15);
        [_getVerificationCodeBtn addTarget:self action:@selector(selectVerificationCodeBtn) forControlEvents:UIControlEventTouchUpInside];
       
        
    }
    return _getVerificationCodeBtn;
}

- (void)selectVerificationCodeBtn
{
    if (self.phoneTextField.text.length == 0) {
           [SVProgressHUD showErrorWithStatus:@"请输入您的手机号"];
           return;
       }
       
       if (![self.phoneTextField.text isMobileNumber]) {
           [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
           return;
       }
       
       
       self.countDown = 60;
       
       self.getVerificationCodeBtn.enabled = false;
       
       self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerCountDown) userInfo:nil repeats:true];
       
       [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (void)timerCountDown
{
    if (self.countDown <= 0) {
        [self.timer invalidate];
        self.timer = nil;
        [self.getVerificationCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.getVerificationCodeBtn.enabled = true;
        [self.getVerificationCodeBtn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    } else {
        [self.getVerificationCodeBtn setTitle:[NSString stringWithFormat:@"重新发送(%ld)", self.countDown] forState:UIControlStateNormal];
        [self.getVerificationCodeBtn setTitleColor:UIColorHex(0xCCCCCC) forState:UIControlStateNormal];
    }
    
    self.countDown --;
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
