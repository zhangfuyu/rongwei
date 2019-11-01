//
//  DFLoginViewController.m
//  rongwei
//
//  Created by zhangfuyu on 2019/9/22.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFLoginViewController.h"

#import "DFTextField.h"

#import "DFForgotPasswordViewController.h"

#import "WXApi.h"

#import "DFRegisteredFirstViewController.h"

@interface DFLoginViewController ()

@property (nonatomic , strong)UIImageView *headerImage;

@property (nonatomic , strong)UIButton *possWordBtn;

@property (nonatomic , strong)UIButton *VerificationCodeBtn;

@property (nonatomic , strong)DFTextField *phoneTextField;

@property (nonatomic , strong)DFTextField *posswordField;

@property (nonatomic , strong)UIImageView *leftiamgeForCode;

@property (nonatomic , strong)UIButton *getVerificationCodeBtn;

@property (nonatomic , strong)UIView *getVerificationCodeView;

@property (nonatomic, assign) NSInteger countDown;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation DFLoginViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    // 微信授权成功
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wechatAuthSuccess:) name:kNotificationWeChatAuthSuccess object:nil];
       
       // 微信授权失败
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wechatAuthFailed) name:kNotificationWeChatAuthFailed object:nil];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self.getVerificationCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.getVerificationCodeView.mas_top);
        make.left.mas_equalTo(self.getVerificationCodeView.mas_left);
        make.right.mas_equalTo(self.getVerificationCodeView.mas_right);
        make.bottom.mas_equalTo(self.getVerificationCodeView.mas_bottom);
    }];
    
    self.headerImage = [[UIImageView alloc]init];
    [self.view addSubview:self.headerImage];
    
    [self.headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(HScaleHeight(38));
        make.size.mas_equalTo(CGSizeMake(HScaleWidth(100), HScaleHeight(100)));
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    self.headerImage.image = [UIImage imageNamed:@"头像_男孩"];
    
    
    
    self.possWordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.possWordBtn setTitle:@"账号登录" forState:UIControlStateNormal];
    [self.possWordBtn setTitleColor:[UIColor colorWithHexString:@"DD1A21"] forState:UIControlStateSelected];
    [self.possWordBtn addTarget:self action:@selector(possWordLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.possWordBtn setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
    [self.view addSubview:self.possWordBtn];
    self.possWordBtn.selected = YES;
    
    [self.possWordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HScaleWidth(25));
        make.top.mas_equalTo(self.headerImage.mas_bottom).offset(HScaleHeight(33));
        make.right.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(HScaleHeight(60));
    }];
    
    
    
    self.VerificationCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.VerificationCodeBtn setTitle:@"验证码登录" forState:UIControlStateNormal];
    [self.VerificationCodeBtn addTarget:self action:@selector(verificationCodeLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.VerificationCodeBtn setTitleColor:[UIColor colorWithHexString:@"DD1A21"] forState:UIControlStateSelected];
    [self.VerificationCodeBtn setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
    [self.view addSubview:self.VerificationCodeBtn];
    
    [self.VerificationCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-HScaleWidth(25));
        make.top.mas_equalTo(self.headerImage.mas_bottom).offset(HScaleHeight(33));
        make.left.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(HScaleHeight(60));
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
        make.top.mas_equalTo(self.possWordBtn.mas_bottom);
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
    
    
    
    self.posswordField = [[DFTextField alloc] init];
    self.posswordField.font = HScaleFont(15);
    self.posswordField.placeholder = @"密码";
    self.posswordField.backgroundColor = [UIColor colorWithHexString:@"F5F5F5"];
    self.posswordField.layer.cornerRadius = HScaleHeight(3);
    self.posswordField.layer.masksToBounds = true;
    self.posswordField.secureTextEntry = YES;
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
    self.leftiamgeForCode.image = [UIImage imageNamed:@"密码"];
    [leftview2 addSubview:self.leftiamgeForCode];
    
    [self.leftiamgeForCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(HScaleWidth(14), HScaleHeight(20)));
        make.centerX.mas_equalTo(leftview2.mas_centerX);
        make.centerY.mas_equalTo(leftview2.mas_centerY);
    }];
    
    [self.posswordField addSubview:leftview2];
    
    

    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.backgroundColor = [UIColor colorWithHexString:@"DD1A21"];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.layer.cornerRadius = HScaleHeight(3);
    [loginBtn addTarget:self action:@selector(requestloginin) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = HScaleFont(15);
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.posswordField.mas_left);
        make.right.mas_equalTo(self.posswordField.mas_right);
        make.top.mas_equalTo(self.posswordField.mas_bottom).offset(HScaleHeight(15));
        make.height.mas_equalTo(HScaleHeight(45));
    }];
    
    
    UIButton *forgotPassword = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgotPassword setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
    [forgotPassword setTitle:@"忘记密码" forState:UIControlStateNormal];
    forgotPassword.titleLabel.font = HScaleFont(12);
    [forgotPassword addTarget:self action:@selector(pushForgotPasswordVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgotPassword];
    
    [forgotPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(loginBtn.mas_left);
        make.top.mas_equalTo(loginBtn.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(HScaleWidth(50), HScaleHeight(44)));
    }];
    
    UIButton *registered = [UIButton buttonWithType:UIButtonTypeCustom];
    [registered setTitleColor:[UIColor colorWithHexString:@"C82126"] forState:UIControlStateNormal];
    [registered setTitle:@"立即注册" forState:UIControlStateNormal];
    registered.titleLabel.font = HScaleFont(12);
    [self.view addSubview:registered];
    [registered addTarget:self action:@selector(registerednew) forControlEvents:UIControlEventTouchUpInside];
    
    [registered mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(loginBtn.mas_right);
        make.top.mas_equalTo(loginBtn.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(HScaleWidth(50), HScaleHeight(44)));
    }];
    
    
    
    UIButton *weixinLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    [weixinLogin setImage:[UIImage imageNamed:@"微信"] forState:UIControlStateNormal];
    [weixinLogin addTarget:self action:@selector(weixinLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:weixinLogin];
    
    [weixinLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HScaleWidth(120));
        make.top.mas_equalTo(loginBtn.mas_bottom).offset(160);
        make.size.mas_equalTo(CGSizeMake(HScaleWidth(30), HScaleHeight(30)));
    }];
    
    UIButton *qqLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    [qqLogin setImage:[UIImage imageNamed:@"QQ"] forState:UIControlStateNormal];
    [self.view addSubview:qqLogin];
    
    [qqLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-HScaleWidth(120));
        make.top.mas_equalTo(loginBtn.mas_bottom).offset(160);
        make.size.mas_equalTo(CGSizeMake(HScaleWidth(30), HScaleHeight(30)));
    }];
    
}

/**
 验证码登录
 */
- (void)verificationCodeLogin:(UIButton *)clickBtn
{
    clickBtn.selected = YES;
    self.possWordBtn.selected = NO;
    if (clickBtn.selected) {
        self.headerImage.image = [UIImage imageNamed:@"头像 女孩 (1)"];
        self.leftiamgeForCode.image = [UIImage imageNamed:@"验证码"];
        self.posswordField.secureTextEntry = NO;
        self.posswordField.rightSpace = HScaleWidth(114);
        [self.posswordField addSubview:self.getVerificationCodeView];
        self.posswordField.rightView = self.getVerificationCodeView;

        [self.getVerificationCodeView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.mas_equalTo(0);
            make.width.mas_equalTo(HScaleWidth(114));
        }];
        
    }
}

/**
 账号登录
 */
- (void)possWordLogin:(UIButton *)clickBtn
{
    clickBtn.selected = YES;
    self.VerificationCodeBtn.selected = NO;
    if (clickBtn.selected) {
        self.headerImage.image = [UIImage imageNamed:@"头像_男孩"];
        self.leftiamgeForCode.image = [UIImage imageNamed:@"密码"];
        self.posswordField.secureTextEntry = YES;
        [self.getVerificationCodeView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.mas_equalTo(0);
            make.width.mas_equalTo(HScaleWidth(0));
        }];
        self.posswordField.rightSpace = 0;
        self.posswordField.rightView = nil;
    }
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

/// 立即注册
- (void)registerednew
{
    [self.navigationController pushViewController:[DFRegisteredFirstViewController new] animated:YES];
}
/// 点击忘记密码  
- (void)pushForgotPasswordVC
{
    [self.navigationController pushViewController:[DFForgotPasswordViewController new] animated:YES];
}
/**
 点击登录
 */
- (void)requestloginin
{
    
    if (self.phoneTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入您的手机号"];
        return;
    }
    
    if (![self.phoneTextField.text isMobileNumber]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
        return;
    }
    
    if (self.posswordField.text.length == 0) {
         
        [SVProgressHUD showErrorWithStatus:@"请输入您的密码"];
               
        return;
        
    }
    
    NSMutableDictionary *parma = [@{
        @"username":self.phoneTextField.text,
        @"password":self.posswordField.text
    }copy];
    
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:LoginApi withParameter:parma withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:NO withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
            if (![response[@"status"] isEqualToString:@"ok"]) {
                        
                [SVProgressHUD showErrorWithStatus:response[@"data"]];
                return;
            }
            [DFUserModelTool shareInstance].uid = [NSString stringWithFormat:@"%@",response[@"data"][@"uid"]];
            [DFUserModelTool shareInstance].isLogin = YES;
            [self.navigationController popViewControllerAnimated:YES];
            [self dismissViewControllerAnimated:YES completion:nil];
            NSLog(@"------->成功");
        }
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

///微信登录
- (void)weixinLogin
{
    
    SendAuthReq *req = [[SendAuthReq alloc] init];
    req.scope = @"snsapi_userinfo";
    req.state = @"udoctor";
   
    [WXApi sendReq:req];
}

- (UIView *)getVerificationCodeView
{
    if (!_getVerificationCodeView) {
        _getVerificationCodeView = [[UIView alloc]init];//WithFrame:CGRectMake(0, 0, HScaleWidth(114), HScaleHeight(45))];
        
        [_getVerificationCodeView addSubview:_getVerificationCodeBtn];

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
        [_getVerificationCodeBtn addTarget:self action:@selector(selectVerificationCodeBtn) forControlEvents:UIControlEventTouchUpInside];
       
        
    }
    return _getVerificationCodeBtn;
}
/**
 微信授权失败
 */
- (void)wechatAuthFailed {
    
//    self.wechatLoginButton.selected = false;
//    self.phoneLoginButton.selected = true;
    
}

/**
 微信授权成功
 
 @param noti <#noti description#>
 */
- (void)wechatAuthSuccess:(NSNotification *)noti {
    
    NSString *code = noti.userInfo[@"code"];

    if (code.length > 0) {
        
        NSString *url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",kWXAppKey,AppSecret,code];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSURL *zoneUrl = [NSURL URLWithString:url];
            NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
            NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (data) {
                    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                    NSString *openId = dic[@"openid"];
                    
//                    [self getWechatUserInfoWithopenId:openId];
                }
            });
        });
        
        
       

    }
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
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

@end
