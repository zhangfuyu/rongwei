//
//  DFContructionDetailViewController.m
//  rongwei
//
//  Created by apple on 2019/11/22.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFContructionDetailViewController.h"
#import "DFConstructionModel.h"
#import "DFHomeCasesView.h"
#import "DFBottomTableViewCell.h"
#import "DFNewMainTableView.h"
#import "DFConstructionSiteViewController.h"
#import "DFContructionDetailView.h"
#import "DFRvaluationViewController.h"
#import "DFInformationViewController.h"

@interface DFContructionDetailViewController ()<UITableViewDelegate , UITableViewDataSource , DFPageContentViewDelegate>
@property (nonatomic , strong) DFHomeCasesView *casesview;
@property (nonatomic, strong) DFBottomTableViewCell *contentCell;
@property (nonatomic, strong) DFNewMainTableView *homeTableview;
@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, assign) BOOL isSpecial;


@end

@implementation DFContructionDetailViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"找施工";
    
    self.canScroll = YES;

    
    UIButton *message = [UIButton buttonWithType:UIButtonTypeCustom];
    [message setTitleColor:UIColorHex(0x010101) forState:UIControlStateNormal];
    message.frame = CGRectMake(0, 0, HScaleWidth(83), 44);
    message.titleLabel.font = HScaleFont(12);
    [message setTitleColor:[UIColor colorWithHexString:@"DD1A21"] forState:UIControlStateNormal];
    [message setImage:[UIImage imageNamed:@"home_notice"] forState:UIControlStateNormal];
//    [message addTarget:self action:@selector(focusonThis) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtn1 = [[UIBarButtonItem alloc] initWithCustomView:message];
    self.navigationItem.rightBarButtonItem = rightBtn1;
    
    [self getConstruction];
    
    DFContructionDetailView *headerview = [[DFContructionDetailView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, HScaleHeight(137))];
    headerview.model = self.model;
    self.homeTableview.tableHeaderView = headerview;
    
    
    [self.homeTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(kNavBarAndStatusBarHeight);
        make.bottom.mas_equalTo(-kBottomSafeHeight);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollStatus) name:@"leaveTop" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollSpecial) name:@"Special" object:nil];


}
#pragma mark notify
- (void)changeScrollStatus//改变主视图的状态
{
    self.canScroll = YES;
    self.contentCell.cellCanScroll = NO;
}
- (void)changeScrollSpecial
{
    self.canScroll = YES;
    self.contentCell.cellCanScroll = NO;

    self.isSpecial = YES;
}
#pragma  mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _contentCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!_contentCell) {
        _contentCell = [[DFBottomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        NSArray *titles = @[[NSString stringWithFormat:@"施工工地（%@）",self.model.site_nums],@"用户评价",@"公司信息"];
        NSMutableArray *contentVCs = [NSMutableArray array];
        for (NSString *title in titles) {
            
            if ([title isEqualToString:@"用户评价"]) {
               
                DFRvaluationViewController *comment = [[DFRvaluationViewController alloc]init];
                comment.constructionid = self.model.modelid;
                [contentVCs addObject:comment];
                
            }
            else if ([title isEqualToString:@"公司信息"])
            {
                DFInformationViewController *information = [[DFInformationViewController alloc]init];
                information.model = self.model;
                [contentVCs addObject:information];

            }
            else
            {
                DFConstructionSiteViewController *construction = [[DFConstructionSiteViewController alloc]init];
                construction.constructionid = self.model.modelid;
                
                [contentVCs addObject:construction];
            }
            
        }
        _contentCell.viewControllers = contentVCs;
        _contentCell.pageContentView = [[DFPageContentView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - kNavBarAndStatusBarHeight - kBottomSafeHeight) childVCs:contentVCs parentVC:self delegate:self];
        _contentCell.pageContentView.backgroundColor = [UIColor whiteColor];

        _contentCell.pageContentView.contentViewCanScroll = NO;
        [_contentCell.contentView addSubview:_contentCell.pageContentView];
    }
    return _contentCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScreenH - kNavBarAndStatusBarHeight - kBottomSafeHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    return 50;
    return HScaleHeight(40);

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.casesview;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
#pragma  mark - GHPageContentViewDelegate
- (void)FSContenViewDidEndDecelerating:(DFPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
//    self.titleView.selectIndex = endIndex;
    self.casesview.selectBtnTag = endIndex;
    self.homeTableview.scrollEnabled =YES;//此处其实是监测scrollview滚动，pageView滚动结束主tableview可以滑动，或者通过手势监听或者kvo，这里只是提供一种实现方式
}

- (void)FSContentViewDidScroll:(DFPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex progress:(CGFloat)progress
{
    self.homeTableview.scrollEnabled = NO;//pageView开始滚动主tableview禁止滑动
}

#pragma mark UIScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
    if (scrollView.contentOffset.y < 0) {
        self.homeTableview.contentOffset = CGPointMake(0, 0);
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
        if (self.isSpecial) {
           
        }
        else
        {
            if (!self.canScroll) {//子视图没到顶部
                           
                scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
                       
            }
        }

    }
    self.homeTableview.showsVerticalScrollIndicator = _canScroll?YES:NO;
}
//请求施工详情
- (void)getConstruction
{
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:CompanyDetail withParameter:nil withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
            
            NSArray *dataarry = response[@"data"];
            
//            for (NSInteger index = 0; index < dataarry.count; index ++) {
//                DFConstructionModel *model = [[DFConstructionModel alloc]initWithDictionary:dataarry[index] error:nil];
//                [self.constructionArry addObject:model];
//            }
//
//            self.header.dataArry = self.constructionArry;
        }
    }];
}

- (DFNewMainTableView *)homeTableview
{
    if (!_homeTableview) {
        _homeTableview = [[DFNewMainTableView alloc]initWithFrame:CGRectMake(0, kNavBarAndStatusBarHeight, ScreenW, ScreenW - kBottomSafeHeight - kNavBarAndStatusBarHeight) style:UITableViewStylePlain];
//        _homeTableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getHomeDataAction)];
        _homeTableview.delegate = self;
        _homeTableview.dataSource = self;
        _homeTableview.showsVerticalScrollIndicator = NO;
        _homeTableview.showsHorizontalScrollIndicator = NO;
        _homeTableview.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_homeTableview];
    }
    return _homeTableview;
}
- (DFHomeCasesView *)casesview
{
    if (!_casesview) {
        _casesview = [[DFHomeCasesView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, HScaleHeight(40))];
        _casesview.backgroundColor = [UIColor whiteColor];
        _casesview.backgroundColor = [UIColor whiteColor];
        _casesview.titleArry = [NSMutableArray arrayWithArray:@[[NSString stringWithFormat:@"施工工地（%@）",self.model.site_nums],@"用户评价",@"公司信息"]];
        __weak typeof(self) weakself = self;
        _casesview.clickTypeBlock = ^(NSString * _Nonnull clickTitle) {
            
            weakself.isSpecial = NO;
            if ([clickTitle isEqualToString:@"用户评价"]) {
                weakself.isSpecial = NO;
                weakself.contentCell.pageContentView.contentViewCurrentIndex = 1;
            }
            else if ([clickTitle isEqualToString:@"公司信息"])
            {
                weakself.isSpecial = YES;
                weakself.contentCell.pageContentView.contentViewCurrentIndex = 2;
            }
            else
            {
                weakself.isSpecial = NO;
                weakself.contentCell.pageContentView.contentViewCurrentIndex = 0;
            }
        };
    }
    return _casesview;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:@"leaveTop"];
    [[NSNotificationCenter defaultCenter] removeObserver:@"Special"];
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
