//
//  DFCommentViewController.m
//  rongwei
//
//  Created by zhangfuyu on 2019/12/21.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFCommentViewController.h"
#import "IQTextView.h"

@interface DFCommentViewController ()

@property (nonatomic , strong) UIView *navitationview;

@property (nonatomic , strong) UILabel *titlelabel;

@property (nonatomic , strong) IQTextView *TextView;

@end

@implementation DFCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navitationview.hidden = NO;
    self.titlelabel.text = self.model.bbs_title;
    
    [self.TextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.navitationview.mas_bottom).offset(HScaleHeight(20));
        make.height.mas_equalTo(HScaleHeight(100));
    }];
    
    UIView *linview = [[UIView alloc]init];
    linview.backgroundColor = [UIColor colorWithHexString:@"F7F7F7"];
    [self.view addSubview:linview];
    
    [linview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HScaleWidth(10));
        make.right.mas_equalTo(-HScaleWidth(10));
        make.bottom.mas_equalTo(-HScaleHeight(91.5) - kBottomSafeHeight);
        make.height.mas_equalTo(HScaleHeight(.5));
    }];
    
    
    UIButton *releaseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [releaseBtn setBackgroundColor:[UIColor colorWithHexString:@"DD1A21"]];
    [releaseBtn setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:UIControlStateNormal];
    releaseBtn.titleLabel.font = HScaleFont(15);
    [releaseBtn setTitle:@"发布" forState:UIControlStateNormal];
    releaseBtn.layer.cornerRadius = HScaleHeight(19.5);
    [self.view addSubview:releaseBtn];
    
    [releaseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(linview.mas_bottom).offset(HScaleHeight(37.5));
        make.left.mas_equalTo(HScaleWidth(15));
        make.right.mas_equalTo(-HScaleWidth(15));
        make.height.mas_equalTo(HScaleHeight(39));
    }];
    
    
    
    
}
- (IQTextView *)TextView
{
    if (!_TextView) {
        _TextView = [[IQTextView alloc]init];
        _TextView.placeholder = @"填写回答内容,至少2个字..... ";
        _TextView.placeholderTextColor = [UIColor colorWithHexString:@"333333"];
        _TextView.font = HScaleFont(12);
        [self.view addSubview:_TextView];
    }
    return _TextView;
}
- (UIView *)navitationview
{
    if (!_navitationview) {
        _navitationview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, kNavBarAndStatusBarHeight)];
        _navitationview.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
        [self.view addSubview:_navitationview];
        
        
        
        UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, 44, 44)];
        [backBtn setImage:[UIImage imageNamed:@"login_back"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(clickCancelAction) forControlEvents:UIControlEventTouchUpInside];
        [_navitationview addSubview:backBtn];
        
        self.titlelabel = [[UILabel alloc]init];
        self.titlelabel.font = HScaleFont(12);
        self.titlelabel.textColor = [UIColor colorWithHexString:@"333333"];
        [_navitationview addSubview:self.titlelabel];
        
        [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(backBtn.mas_right).offset(HScaleWidth(11));;
            make.top.mas_equalTo(kStatusBarHeight);
            make.bottom.mas_equalTo(0);
            make.right.mas_equalTo(_navitationview.mas_right).offset(-HScaleWidth(137));
        }];
        
        UIView *linview = [[UIView alloc]init];
        linview.backgroundColor = [UIColor colorWithHexString:@"E7E7E7"];
        [_navitationview addSubview:linview];
        
        [linview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(HScaleHeight(.5));
            
        }];
    }
    return _navitationview;
}
- (void)clickCancelAction{
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
