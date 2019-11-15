//
//  DFHomeViewController.m
//  rongwei
//
//  Created by zhangfuyu on 2019/9/19.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFHomeViewController.h"
#import "DFEsignerlListViewController.h"
#import "DFHomeHeaderView.h"
#import "DFSectionView.h"
#import "DFHomeNaiBarView.h"
#import "DFHomeNavModel.h"
#import "DFGetNetData.h"

@interface DFHomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong)DFSectionView *firstSection;

@property (nonatomic , strong)DFSectionView *secondSection;

@property (nonatomic , strong)DFSectionView *threeSection;

@property (nonatomic , strong)DFSectionView *fourSection;

@property (nonatomic , strong)DFHomeNaiBarView *narbaView;

@property (nonatomic , strong)NSMutableArray *navArry;
@end

@implementation DFHomeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"首页";
    [DFUserModelTool shareInstance].isLogin = true;
    [self allocTableviewWith:UITableViewStylePlain];
    self.dataTableview.delegate = self;
    self.dataTableview.dataSource = self;
    [self.dataTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-kTabBarHeight);
    }];
    
    DFHomeHeaderView *headerview = [[DFHomeHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, HScaleHeight(526) + kStatusBarHeight)];
  
    self.dataTableview.tableHeaderView = headerview;
    
    self.narbaView.hidden = YES;
    
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:HomeWorks withParameter:nil withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
            NSLog(@"--->");
            for (NSDictionary *dic in (NSArray *)response[@"data"]) {
                DFHomeNavModel *model = [[DFHomeNavModel alloc]initWithDictionary:dic error:nil];
                [self.navArry addObject:model];
            }
            headerview.navArry = self.navArry;
        }
    }];
    
    
    NSMutableArray *arry = [DFGetNetData getadvertising];
    
//    [self.navigationController pushViewController:[DFEsignerlListViewController new] animated:YES];
//    [[DFUserModelTool shareInstance] showLoginViewController];
}
#pragma mark - UITableViewDelegate,UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Cellidear = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cellidear];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cellidear];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0 || section == 2) {
        return HScaleHeight(56);
    }
    
    return HScaleHeight(39);
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return self.firstSection;
    }
    else if (section == 1)
    {
        return self.secondSection;
    }
    else if (section == 2)
    {
        return self.threeSection;
    }
    return self.fourSection;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y >= HScaleHeight(348)) {
        self.narbaView.hidden = NO;
    }
    else
    {
        self.narbaView.hidden = YES;
        if (scrollView.contentOffset.y <= 0) {
            [self.dataTableview scrollToTopAnimated:NO];
        }
    }
}

- (DFSectionView *)firstSection
{
    if (!_firstSection) {
        _firstSection = [[DFSectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, HScaleHeight(56))];
        _firstSection.titleText = @"推荐案例";
        _firstSection.subText = @"40000+业主的装修案例，%100所见即所得";
    }
    return _firstSection;
}
- (DFSectionView *)secondSection
{
    if (!_secondSection) {
        _secondSection = [[DFSectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, HScaleHeight(39))];
        _secondSection.titleText = @"施工工地";
        _secondSection.isShowSubTitle = NO;
    }
    return _secondSection;
}
- (DFSectionView *)threeSection
{
    if (!_threeSection) {
        _threeSection = [[DFSectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, HScaleHeight(56))];
        _threeSection.titleText = @"推荐设计师";
        _threeSection.subText = @"40000+业主的装修案例，%100所见即所得";
    }
    return _threeSection;
}

- (DFSectionView *)fourSection
{
    if (!_fourSection) {
        _fourSection = [[DFSectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, HScaleHeight(39))];
        _fourSection.titleText = @"热门攻略";
        _fourSection.isShowSubTitle = NO;
    }
    return _fourSection;
}
- (DFHomeNaiBarView *)narbaView
{
    if (!_narbaView) {
        _narbaView = [[DFHomeNaiBarView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, kNavBarAndStatusBarHeight)];
        WEAKSELF;
        _narbaView.scroToMusrUp = ^{
            [weakSelf.dataTableview scrollToTopAnimated:NO];
        };
        [self.view addSubview:_narbaView];
        [self.view bringSubviewToFront:_narbaView];
    }
    return _narbaView;
}

- (NSMutableArray *)navArry
{
    if (!_navArry) {
        _navArry = [NSMutableArray arrayWithCapacity:0];
    }
    return _navArry;
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
