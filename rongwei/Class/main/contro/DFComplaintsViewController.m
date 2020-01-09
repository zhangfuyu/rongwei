//
//  DFComplaintsViewController.m
//  rongwei
//
//  Created by zhangfuyu on 2020/1/9.
//  Copyright © 2020 zhangfuyu. All rights reserved.
//

#import "DFComplaintsViewController.h"

@interface DFComplaintsViewController ()

@property (nonatomic , strong) IQTextView *textView;

@end

@implementation DFComplaintsViewController



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"投诉建议";
    
    
    UIButton *message = [UIButton buttonWithType:UIButtonTypeCustom];
//    message.frame = CGRectMake(0, 0, HScaleWidth(83), 44);
    message.titleLabel.font = HScaleFont(15);
    [message setTitle:@"提交" forState:UIControlStateNormal];
    [message setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:UIControlStateNormal];
    [message addTarget:self action:@selector(focusonThis) forControlEvents:UIControlEventTouchUpInside];
    [message setBackgroundColor:[UIColor colorWithHexString:@"DD1A21"]];
    message.layer.cornerRadius = HScaleWidth(19.5);
    [self.view addSubview:message];
    
    [message mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HScaleWidth(15));
        make.right.mas_equalTo(-HScaleWidth(15));
        make.bottom.mas_equalTo(-kBottomSafeHeight - HScaleHeight(10));
        make.height.mas_equalTo(HScaleHeight(39));
    }];

    
    
    
    self.textView = [[IQTextView alloc]init];
    self.textView.font = HScaleFont(12);
    self.textView.placeholder = @"您有任何的投诉与建议,可以在这里畅所欲言,我们一定耐心倾听, 积极改正....";
    [self.view addSubview:self.textView];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kNavBarAndStatusBarHeight + 10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(message.mas_top).offset(-HScaleHeight(20));
    }];
}

- (void)focusonThis
{
    [self.textView resignFirstResponder];
    
    if (self.textView.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入内容"];
        return;
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"我们已收到您的建议，会及时改正" preferredStyle:UIAlertControllerStyleAlert];
    
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//        NSLog(@"否按钮被点击了");
//    }];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
//    UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        NSLog(@"关闭按钮被点击了");
//    }];
    
//    [alertController addAction:cancelAction];
    [alertController addAction:sureAction];
//    [alertController addAction:destructiveAction];
    
    [self presentViewController:alertController animated:YES completion:nil];}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
