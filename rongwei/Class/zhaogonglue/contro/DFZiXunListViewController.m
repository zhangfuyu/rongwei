//
//  DFZiXunListViewController.m
//  rongwei
//
//  Created by zhangfuyu on 2019/12/21.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFZiXunListViewController.h"
#import "DFCommentViewController.h"
#import "DFZiXunListHeaderView.h"

@interface DFZiXunListViewController ()

@property (nonatomic , strong) UIView *navitationview;

@property (nonatomic , strong) UILabel *titlelabel;

@property (nonatomic , strong) DFZiXunListHeaderView *headerview;

@end

@implementation DFZiXunListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navitationview.hidden = NO;
    self.titlelabel.text = self.model.bbs_title;
    
    [self getdata];

}
- (void)getdata
{
    NSString *urlstr = [NSString stringWithFormat:@"%@/%@",BbsGuide,self.modelID];
    
    
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:urlstr withParameter:nil withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
            
            
            self.model = [[DFGongLueModel alloc]initWithDictionary:response[@"data"] error:nil];

            self.headerview = [[DFZiXunListHeaderView alloc]initWithFrame:CGRectZero withModel:self.model];
            [self.view addSubview:self.headerview];
            
            [self creatBoomView];

            
        }
    }];
}
- (void)creatBoomView
{
    UIView *boomView = [[UIView alloc]init];
    boomView.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
    [self.view addSubview:boomView];
    
    [boomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(HScaleHeight(54) + kBottomSafeHeight);
    }];
    
    UIView *linview = [[UIView alloc]init];
    linview.backgroundColor = [UIColor colorWithHexString:@"F7F7F7"];
    [boomView addSubview:linview];
    
    [linview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(HScaleHeight(.5));
    }];
    
    UILabel *commentLaebl = [[UILabel alloc]init];
    commentLaebl.backgroundColor = [UIColor colorWithHexString:@"F5F6FA"];
    commentLaebl.textColor = [UIColor colorWithHexString:@"999999"];
    commentLaebl.font = HScaleFont(12);
    commentLaebl.layer.cornerRadius = HScaleHeight(14);
    commentLaebl.layer.masksToBounds = YES;
    commentLaebl.text = @"  我也想回答";
    commentLaebl.userInteractionEnabled = YES;
    [boomView addSubview:commentLaebl];
    
    [commentLaebl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HScaleWidth(10));
        make.top.mas_equalTo(HScaleWidth(13));
        make.size.mas_equalTo(CGSizeMake(HScaleWidth(299), HScaleHeight(28)));
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickEvent:)];
    [commentLaebl addGestureRecognizer: tap];
    
    
    UIImageView *star = [[UIImageView alloc]init];
    star.image = [UIImage imageNamed:@"no_Focus_on"];
    [boomView addSubview:star];
    
    [star mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(commentLaebl.mas_right).offset(HScaleWidth(21.5));
        make.top.mas_equalTo(HScaleHeight(10.5));
        make.size.mas_equalTo(CGSizeMake(HScaleWidth(24), HScaleHeight(20)));
    }];
    
    UILabel *secondlabel = [[UILabel alloc]init];
    secondlabel.text = @"关注";
    secondlabel.textColor = [UIColor colorWithHexString:@"333333"];
    secondlabel.font = HScaleFont(10);
    secondlabel.textAlignment = NSTextAlignmentCenter;
    [boomView addSubview:secondlabel];
    
    [secondlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(star.mas_bottom).offset(HScaleHeight(5));
        make.left.mas_equalTo(star.mas_left);
        make.right.mas_equalTo(star.mas_right);
    }];
    
    UIButton *guanzhuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [boomView addSubview:guanzhuBtn];
    [guanzhuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(commentLaebl.mas_right);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-kBottomSafeHeight);
    }];
    
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
- (void)clickEvent:(UITapGestureRecognizer *)tap
{
    DFCommentViewController *commentVC = [[DFCommentViewController alloc]init];
    commentVC.model = self.model;
    [self.navigationController pushViewController:commentVC animated:YES];
}
- (void)clickCancelAction
{
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
