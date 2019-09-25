//
//  DFForgotPasswordViewController.m
//  rongwei
//
//  Created by apple on 2019/9/24.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFForgotPasswordViewController.h"

#import "DFTextField.h"


@interface DFForgotPasswordViewController ()

@property (nonatomic , strong)DFTextField *phoneTextField;

@property (nonatomic , strong)DFTextField *posswordField;

@property (nonatomic , strong)UIImageView *leftiamgeForCode;

@property (nonatomic , strong)UIImageView *leftiamge;

@property (nonatomic , assign)BOOL isAgainNewPossword;

@property (nonatomic , strong)UIButton *clickBtn;

@property (nonatomic , strong)UIButton *getVerificationCodeBtn;

@property (nonatomic , strong)UIView *getVerificationCodeView;

@property (nonatomic, assign) NSInteger countDown;

@property (nonatomic, strong) NSTimer *timer;
@end

@implementation DFForgotPasswordViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"忘记密码";
    
    self.isAgainNewPossword = NO;

    [self.getVerificationCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(self.getVerificationCodeView.mas_top);
           make.left.mas_equalTo(self.getVerificationCodeView.mas_left);
           make.right.mas_equalTo(self.getVerificationCodeView.mas_right);
           make.bottom.mas_equalTo(self.getVerificationCodeView.mas_bottom);
    }];
    
    
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
       make.top.mas_equalTo(kNavBarAndStatusBarHeight + HScaleHeight(27));
       make.height.mas_equalTo(HScaleHeight(45));
    }];
   
   
    UIView *leftview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, HScaleWidth(45), HScaleHeight(45))];
    self.leftiamge = [[UIImageView alloc]init];
    self.leftiamge.image = [UIImage imageNamed:@"手机"];
    [leftview addSubview:self.leftiamge];
   
    [self.leftiamge mas_makeConstraints:^(MASConstraintMaker *make) {
       make.size.mas_equalTo(CGSizeMake(HScaleWidth(14), HScaleHeight(20)));
       make.centerX.mas_equalTo(leftview.mas_centerX);
       make.centerY.mas_equalTo(leftview.mas_centerY);
    }];
   
    [self.phoneTextField addSubview:leftview];
   
   
   
    self.posswordField = [[DFTextField alloc] init];
    self.posswordField.font = HScaleFont(15);
    self.posswordField.placeholder = @"密码";
    self.posswordField.backgroundColor = [UIColor colorWithHexString:@"F5F5F5"];
    self.posswordField.layer.cornerRadius = HScaleHeight(3);
    self.posswordField.layer.masksToBounds = true;
    self.posswordField.keyboardType = UIKeyboardTypePhonePad;
    self.posswordField.returnKeyType = UIReturnKeyDone;
    self.posswordField.leftSpace = HScaleHeight(45);
    [self.view addSubview:self.posswordField];
   
    [self.posswordField mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.mas_equalTo(HScaleWidth(25));
       make.right.mas_equalTo(-HScaleWidth(25));
       make.top.mas_equalTo(self.phoneTextField.mas_bottom).offset(HScaleHeight(15));
       make.height.mas_equalTo(HScaleHeight(45));
    }];
   
    UIView *leftview2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, HScaleWidth(45), HScaleHeight(45))];
    self.leftiamgeForCode = [[UIImageView alloc]init];
    self.leftiamgeForCode.image = [UIImage imageNamed:@"验证码"];
    [leftview2 addSubview:self.leftiamgeForCode];
   
    [self.leftiamgeForCode mas_makeConstraints:^(MASConstraintMaker *make) {
       make.size.mas_equalTo(CGSizeMake(HScaleWidth(14), HScaleHeight(20)));
       make.centerX.mas_equalTo(leftview2.mas_centerX);
       make.centerY.mas_equalTo(leftview2.mas_centerY);
    }];
   
    [self.posswordField addSubview:leftview2];
    
    
    self.posswordField.rightSpace = HScaleWidth(114);
    [self.posswordField addSubview:self.getVerificationCodeView];
    
    [self.getVerificationCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.posswordField.mas_right);
        make.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(HScaleWidth(114));
    }];
    
    
    self.clickBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.clickBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [self.clickBtn setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:UIControlStateNormal];
    self.clickBtn.titleLabel.font = HScaleFont(15);
    self.clickBtn.backgroundColor = [UIColor colorWithHexString:@"108EE9"];
    self.clickBtn.layer.cornerRadius = HScaleHeight(3);
    [self.clickBtn addTarget:self action:@selector(selecteUpDowm) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.clickBtn];
    
    [self.clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HScaleWidth(25));
        make.right.mas_equalTo(-HScaleWidth(25));
        make.top.mas_equalTo(self.posswordField.mas_bottom).offset(HScaleHeight(15));
        make.height.mas_equalTo(HScaleHeight(45));
    }];
   
}
- (void)selecteUpDowm
{
    self.leftiamge.image = [UIImage imageNamed:@"密码"];
    self.leftiamgeForCode.image = [UIImage imageNamed:@"密码"];
    self.phoneTextField.placeholder = @"新密码（8-16位数字或字)";
    self.posswordField.placeholder = @"再次输入";
    self.posswordField.rightSpace = 0;
    self.posswordField.rightView = nil;
    self.getVerificationCodeView.hidden = YES;
    [self.clickBtn setTitle:@"完成" forState:UIControlStateNormal];

}

/**
 点击获取验证码
 */
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
- (UIView *)getVerificationCodeView
{
    if (!_getVerificationCodeView) {
        _getVerificationCodeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, HScaleWidth(114), HScaleHeight(45))];
    }
    return _getVerificationCodeView;
}

- (UIButton *)getVerificationCodeBtn
{
    if (!_getVerificationCodeBtn) {
        _getVerificationCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_getVerificationCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getVerificationCodeBtn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        _getVerificationCodeBtn.titleLabel.font = HScaleFont(15);
        [self.getVerificationCodeView addSubview:_getVerificationCodeBtn];
        [_getVerificationCodeBtn addTarget:self action:@selector(selectVerificationCodeBtn) forControlEvents:UIControlEventTouchUpInside];
       
        
    }
    return _getVerificationCodeBtn;
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
