//
//  DFStrategyDetailViewController.m
//  rongwei
//
//  Created by apple on 2019/11/26.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFStrategyDetailViewController.h"
#import "DFGongLueModel.h"
#import "DFStrategyDetailHeaderView.h"
#import "DFItsCollectionViewCell.h"
#import "DFNewMainTableView.h"
#import "DFSecondHeaderView.h"
#import "DFBottomTableViewCell.h"
#import "DFConstructionSiteViewController.h"
#import "DFRecommendedViewController.h"
#import "DFCommentBommenView.h"

@interface DFStrategyDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) DFGongLueModel *model;

@property (nonatomic, strong) DFBottomTableViewCell *contentCell;


@property (nonatomic , strong) DFStrategyDetailHeaderView *headerview;

@property (nonatomic , strong) NSMutableArray *recommendedarry;

@property (nonatomic, strong) DFNewMainTableView *homeTableview;

@property (nonatomic , strong) DFSecondHeaderView *sceondView;

@property (nonatomic , assign) BOOL canScroll;

@property (nonatomic , assign) float headetheight;

@property (nonatomic , strong) UIView *navitationview;

@property (nonatomic , strong) UILabel *titlelabel;

@property (nonatomic , strong) DFCommentBommenView *boomview;


@end

@implementation DFStrategyDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navitationview.hidden = YES;
    
    self.headetheight = HScaleHeight(250);

    self.canScroll = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollStatus) name:@"leaveTop" object:nil];


    [self.boomview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(- kBottomSafeHeight);
        make.height.mas_equalTo(HScaleHeight(54));
    }];

    
    [self getdata];
    
//    [self getrecommended];


}
- (void)creattable
{
    
    [self.view addSubview:self.headerview];
    self.homeTableview = [[DFNewMainTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.homeTableview.tableHeaderView = self.headerview;
    self.homeTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.homeTableview.delegate = self;
    self.homeTableview.dataSource = self;
    [self.view addSubview:self.homeTableview];
    WEAKSELF;
    self.headerview.globalBlockInMemory = ^(float headerHeight) {
        weakSelf.headerview.frame = CGRectMake(0, 0, ScreenW, headerHeight);
        weakSelf.headetheight = headerHeight;
        weakSelf.canScroll = YES;
        [weakSelf.homeTableview reloadData];
    };
    
    [self.homeTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-kBottomSafeHeight - HScaleHeight(54));
    }];
    
    
    if (@available(iOS 11.0, *)) {
        self.homeTableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        // est和代理 可选1个
        self.homeTableview.estimatedSectionFooterHeight = 0;
        self.homeTableview.estimatedSectionHeaderHeight = 0;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

#pragma mark notify
- (void)changeScrollStatus//改变主视图的状态
{
    self.canScroll = YES;
    self.contentCell.cellCanScroll = NO;
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScreenH - HScaleHeight(47) - kBottomSafeHeight - HScaleHeight(54);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _contentCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!_contentCell) {
        _contentCell = [[DFBottomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        NSMutableArray *contentVCs = [NSMutableArray array];

        DFRecommendedViewController *construction = [[DFRecommendedViewController alloc]init];
//        construction.constructionid = @"1";
        
        [contentVCs addObject:construction];
        
        _contentCell.viewControllers = contentVCs;
        _contentCell.pageContentView = [[DFPageContentView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - HScaleHeight(47) - kBottomSafeHeight - HScaleHeight(54)) childVCs:contentVCs parentVC:self delegate:nil];
        _contentCell.pageContentView.backgroundColor = [UIColor whiteColor];

        _contentCell.pageContentView.contentViewCanScroll = NO;
        [_contentCell.contentView addSubview:_contentCell.pageContentView];
    }
    return _contentCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HScaleHeight(47);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.sceondView;
}

#pragma mark UIScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
    if (scrollView.contentOffset.y > kNavBarAndStatusBarHeight) {
        self.navitationview.hidden = NO;
        [self.view bringSubviewToFront:self.navitationview];
    }
    else
    {
        self.navitationview.hidden = YES;

    }
    
    
    CGFloat bottomCellOffset = [self.homeTableview rectForSection:0].origin.y;

    if (scrollView.contentOffset.y >= bottomCellOffset) {
        scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        if (self.canScroll) {
            self.canScroll = NO;
            self.contentCell.cellCanScroll = YES;
        }
    }
    else{
       
        if (!self.canScroll) {//子视图没到顶部
                       
            scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
                   
        }

    }
    self.homeTableview.showsVerticalScrollIndicator = _canScroll?YES:NO;
}

- (void)getdata
{
    NSString *urlstr = [NSString stringWithFormat:@"%@/%@",BbsGuide,self.modelid];
    
    
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:urlstr withParameter:nil withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
            
            
            self.model = [[DFGongLueModel alloc]initWithDictionary:response[@"data"] error:nil];

            self.headerview.model = self.model;
            
            self.boomview.model = self.model;
            
            self.titlelabel.text = self.model.bbs_title;

            [self creattable];
            
            [self.homeTableview reloadData];
            
        }
    }];
}
- (UIView *)navitationview
{
    if (!_navitationview) {
        _navitationview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, kNavBarAndStatusBarHeight)];
        _navitationview.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
        [self.view addSubview:_navitationview];
        
        
        
        UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, 44, 44)];
        backBtn.showsTouchWhenHighlighted = NO;
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
    }
    return _navitationview;
}
- (void)clickCancelAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (DFStrategyDetailHeaderView *)headerview
{
    if (!_headerview) {
        _headerview = [[DFStrategyDetailHeaderView alloc]init];
    
    }
    return _headerview;
}

- (NSMutableArray *)recommendedarry
{
    if (!_recommendedarry) {
        _recommendedarry = [NSMutableArray arrayWithCapacity:0];
    }
    return _recommendedarry;
}

- (DFSecondHeaderView *)sceondView
{
    if (!_sceondView) {
        _sceondView = [[DFSecondHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, HScaleHeight(47)) withtitle:@"猜你喜欢"];
        _sceondView.backgroundColor = [UIColor whiteColor];
    }
    return _sceondView;
}
- (DFCommentBommenView *)boomview
{
    if (!_boomview) {
        _boomview = [[DFCommentBommenView alloc]init];
        [self.view addSubview:_boomview];
    }
    return _boomview;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"leaveTop" object:nil];
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
