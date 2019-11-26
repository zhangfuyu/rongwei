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

@interface DFStrategyDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) DFGongLueModel *model;

@property (nonatomic, strong) DFBottomTableViewCell *contentCell;


@property (nonatomic , strong) DFStrategyDetailHeaderView *headerview;

@property (nonatomic , strong) NSMutableArray *recommendedarry;

@property (nonatomic, strong) DFNewMainTableView *homeTableview;

@property (nonatomic , strong) DFSecondHeaderView *sceondView;

@property (nonatomic , assign) BOOL canScroll;

@property (nonatomic , assign) float headetheight;


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
    
    self.headetheight = HScaleHeight(250);

    self.canScroll = YES;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollStatus) name:@"leaveTop" object:nil];



    
    [self getdata];
    
    [self getrecommended];


}
- (void)creattable
{
    
    [self.view addSubview:self.headerview];
    self.homeTableview = [[DFNewMainTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.homeTableview.tableHeaderView = self.headerview;

    self.homeTableview.delegate = self;
    self.homeTableview.dataSource = self;
    [self.view addSubview:self.homeTableview];
    WEAKSELF;
    self.headerview.globalBlockInMemory = ^(float headerHeight) {
        weakSelf.headerview.frame = CGRectMake(0, 0, ScreenW, headerHeight);
        weakSelf.headetheight = headerHeight;
        [weakSelf.homeTableview reloadData];
    };
    
    [self.homeTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-kBottomSafeHeight);
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

        DFConstructionSiteViewController *construction = [[DFConstructionSiteViewController alloc]init];
        construction.constructionid = @"1";
        
        [contentVCs addObject:construction];
        
        _contentCell.viewControllers = contentVCs;
        _contentCell.pageContentView = [[DFPageContentView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - HScaleHeight(47) - kBottomSafeHeight) childVCs:contentVCs parentVC:self delegate:self];
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
            

            [self creattable];
            
            [self.homeTableview reloadData];
            
        }
    }];
}
- (void)getrecommended
{
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:BbsGuide withParameter:@{@"is_rec":@"1"} withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
            
            NSArray *dataArry = response[@"data"];
            if (dataArry.count > 0) {
                for (NSDictionary *dic in dataArry) {
                    DFGongLueModel *submodel = [[DFGongLueModel alloc]initWithDictionary:dic error:nil];
                    [self.recommendedarry addObject:submodel];
                }
                
            }
            [self.homeTableview reloadData];
        }
    }];
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
