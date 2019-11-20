//
//  DFAppointViewController.m
//  rongwei
//
//  Created by apple on 2019/11/19.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFAppointViewController.h"

@interface DFAppointViewController ()

@end

@implementation DFAppointViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"温馨提示";
    
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.font = HScaleFont(12);
    [self.view addSubview:label];
    
    NSString *content= @"预约流程如下:\n1.填写房子基本信息\n2.支付500元定金\n3.待设计师确认\n4.预约成功\n\n\n\n注:根据平台相关规定,预约设计师,需先支付定金,支付一次定金最多免费预约4次,如果预约了4个设计师都不满意,定金不退,若预约成功,在后期需支付的设计款中会扣除相应的定金金额.\n\n预约成功之后\n\n1.设计师会电话联系您上门量房的时间\n2.确定完成线下量房和收到布置图,同意协议,支付50%\n预付款(最终支付金额为扣除已交定金之后的剩余金额)\n3.确认收到全部施工图,支付剩余的50%尾款,完成订单\n4.进入施工准备\n";
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:content attributes:@{NSFontAttributeName: HScaleFont(12),NSForegroundColorAttributeName: [UIColor colorWithHexString:@"333333"]}];
    
    
    NSRange range = [content rangeOfString:@"注:"];

    [attributedString addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"DD1A21"]} range:range];
    
    label.attributedText = attributedString;
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kNavBarAndStatusBarHeight + HScaleHeight(21.5));
        make.left.mas_equalTo(HScaleHeight(12));
        make.right.mas_equalTo(-HScaleHeight(12));
    }];
    
    
    
    UIButton *cancle = [UIButton buttonWithType:UIButtonTypeCustom];
    cancle.titleLabel.font = HScaleFont(15);
    [cancle setTitleColor:[UIColor colorWithHexString:@"DD1A21"] forState:UIControlStateNormal];
    [cancle setTitle:@"取消" forState:UIControlStateNormal];
    [cancle addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    cancle.layer.borderWidth = 1;
    cancle.layer.borderColor = [UIColor colorWithHexString:@"DD1A21"].CGColor;
    [self.view addSubview:cancle];
    
    [cancle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HScaleWidth(71));
        make.top.mas_equalTo(label.mas_bottom).offset(HScaleHeight(34));
        make.size.mas_equalTo(CGSizeMake(HScaleWidth(104), HScaleHeight(36)));
    }];

    UIButton *sure = [UIButton buttonWithType:UIButtonTypeCustom];
    sure.titleLabel.font = HScaleFont(15);
    [sure setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:UIControlStateNormal];
    [sure setTitle:@"去填写" forState:UIControlStateNormal];
    [sure addTarget:self action:@selector(gowork) forControlEvents:UIControlEventTouchUpInside];
    sure.backgroundColor = [UIColor colorWithHexString:@"DD1A21"];
    [self.view addSubview:sure];
    
    [sure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-HScaleWidth(71));
        make.top.mas_equalTo(label.mas_bottom).offset(HScaleHeight(34));
        make.size.mas_equalTo(CGSizeMake(HScaleWidth(104), HScaleHeight(36)));
    }];
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)gowork
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(FillInTheInformation)]) {
        [self.delegate FillInTheInformation];
    }
    [self.navigationController popViewControllerAnimated:YES];

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
