//
//  DFEsignerlListViewController.m
//  rongwei
//
//  Created by apple on 2019/9/25.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFEsignerlListViewController.h"
#import "DFDesignerModel.h"
#import "DfDesignerTableViewCell.h"
#import "CQTopBarViewController.h"
#import "CQTopBarSegment.h"
#import "DFEsignerDetialViewController.h"
#import "DFChooseCityViewController.h"
#import "DFEsignerStyleViewController.h"
#import "DFEsignerSortingViewController.h"

@interface DFEsignerlListViewController ()<UITableViewDelegate,UITableViewDataSource,CQTopBarSegmentDelegate,DFChooseCityViewControllerDelegate,DFEsignerSortingViewControllerDelegate,DFEsignerStyleViewControllerDelegate>

@property (nonatomic , assign)NSInteger currentPage;

@property (nonatomic , assign)NSInteger pageSizre;

@property (nonatomic , strong)NSMutableArray *dataListArry;

@property (nonatomic, strong) CQTopBarSegment *segment;

@property (nonatomic , strong)NSMutableDictionary *parma;

@property (nonatomic , strong) DFChooseCityViewController *chooseCity;

@property (nonatomic , strong) DFEsignerStyleViewController *style;

@property (nonatomic , strong) DFEsignerSortingViewController *sortVc;



@end

@implementation DFEsignerlListViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
    
    self.title = @"设计师";
    
    self.parma = [[NSMutableDictionary alloc]init];
    
    self.dataTableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.dataTableview];
    
    
    self.dataTableview.delegate = self;
    self.dataTableview.dataSource = self;
    self.dataTableview.tableFooterView = [UIView new];
    self.dataTableview.showsVerticalScrollIndicator = NO;
    self.dataTableview.showsVerticalScrollIndicator = NO;
    [self tabelviewAddReload];
    [self tableviewAddMoreDown];
    
    [self.dataTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kNavBarAndStatusBarHeight);
        make.right.left.mas_equalTo(0);
        make.bottom.mas_equalTo(-kBottomSafeHeight);
    }];
    self.currentPage = 1;
    [self refreshData];
    
}
#pragma mark - <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataListArry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"DfDesignerTableViewCell";
    DfDesignerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[DfDesignerTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.model = [self.dataListArry objectAtIndex:indexPath.row];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HScaleHeight(105);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DFEsignerDetialViewController *detail = [[DFEsignerDetialViewController alloc]init];
    detail.model = self.dataListArry[indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HScaleHeight(53);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, HScaleHeight(53))];
    backview.backgroundColor = [UIColor colorWithHexString:@"F2F2F2"];
    [backview addSubview:self.segment];
            
    
    return backview;
}
//然后在UITableView的代理方法中加入以下代码
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)refreshData
{
    self.currentPage = 1 ;
    [self getdata];
}

- (void)getMoreData
{
    self.currentPage ++ ;
    [self getdata];
}

- (void)getdata
{
    

    self.parma[@"is_rec"] = @"0";
    self.parma[@"lastIndex"] = @(self.dataListArry.count);
    self.parma[@"itemsPerLoad"] = @"10";
    
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:DesignerListsApi withParameter:self.parma withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        
        [self.dataTableview.mj_header endRefreshing];
        [self.dataTableview.mj_footer endRefreshing];
        
        if (isSuccess) {
            NSLog(@"请求成功");
            NSArray *dataarry = response[@"data"];
            
            if (self.currentPage == 1) {
                [self.dataListArry removeAllObjects];
            }
            
            if (dataarry > 0) {
                for (NSDictionary *dic in dataarry) {
                    DFDesignerModel *model = [[DFDesignerModel alloc] initWithDictionary:dic error:nil];
                    [self.dataListArry addObject:model];
                }
                [self.dataTableview.mj_footer endRefreshing];
            }
            else
            {
                [self.dataTableview.mj_footer endRefreshingWithNoMoreData];
            }
            [self.dataTableview reloadData];
        }
            
    }];
}


- (NSMutableArray *)dataListArry
{
    if (!_dataListArry) {
        _dataListArry = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataListArry;
}

- (CQTopBarSegment *)segment
{
    if (!_segment) {
        _segment = [[CQTopBarSegment alloc]initWithFrame:CGRectMake(0, 0, ScreenW, HScaleHeight(47)) sectionTitles:@[@"区域选择",@"擅长风格",@"综合排序"]];
        _segment.titleTextColor = [UIColor colorWithHexString:@"666666"];
        _segment.segmentImage = @"箭头";
        _segment.selectSegmentImage = @"箭头-1";
        _segment.delegate = self;
        _segment.selectedTitleTextColor = [UIColor colorWithHexString:@"DD1A21"];
        _segment.titleTextFont = HScaleFont(12);
        _segment.segmentlineColor = [UIColor clearColor];
    }
    return _segment;
}
- (void)topBarSegmentWithBlock:(CQTopBarSegment *)segment indexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        CGFloat contentY = [self.dataTableview rectForSection:0].origin.y;
        self.dataTableview.contentOffset = CGPointMake(0, contentY);
        self.style.view.hidden = !self.style.view.hidden;

    }
    else if (indexPath.row == 2)
    {
        CGFloat contentY = [self.dataTableview rectForSection:0].origin.y;
        self.dataTableview.contentOffset = CGPointMake(0, contentY);
        self.sortVc.view.hidden = !self.sortVc.view.hidden;
    }
    else
    {
        CGFloat contentY = [self.dataTableview rectForSection:0].origin.y;
        self.dataTableview.contentOffset = CGPointMake(0, contentY);
        self.chooseCity.view.hidden = !self.chooseCity.view.hidden;
    }
}
- (DFChooseCityViewController *)chooseCity
{
    if (!_chooseCity) {
        _chooseCity = [[DFChooseCityViewController alloc]init];
        _chooseCity.delegate = self;
        _chooseCity.view.hidden = YES;
        [self addChildViewController:_chooseCity];
        [self.view addSubview:_chooseCity.view];
    }
    return _chooseCity;
}
- (void)selectChooseprovinceId:(NSString *)province_id city_id:(NSString *)cityID area_id:(NSString *)areaId
{
    
    [self.segment.collectionView reloadData];
    self.parma[@"province_id"] = province_id;
    self.parma[@"city_id"] = cityID;
    self.parma[@"area_id"] = areaId;
    
    [self.dataListArry removeAllObjects];
    [self getdata];

}

- (DFEsignerStyleViewController *)style
{
    if (!_style) {
        _style = [[DFEsignerStyleViewController alloc]init];
        _style.delegate = self;
        _style.view.hidden = YES;
        [self addChildViewController:_style];
        [self.view addSubview:_style.view];
    }
    return _style;
}
- (void)selectChooseEsignerStyleId:(NSString *)styleId withText:(NSString *)text
{
    [self.segment.collectionView reloadData];
    
    if (text.length == 0) {
        return;
    }

    text = [text stringByReplacingOccurrencesOfString:@"全部" withString:@"擅长风格"];

    
    [self.segment topBarReplaceObjectsAtIndexes:1 withObjects:text BarView:nil];
    self.parma[@"style_id"] = styleId;
    self.style.view.hidden = YES;
    [self.segment.collectionView reloadData];
    [self.dataListArry removeAllObjects];
    [self getdata];
}
- (DFEsignerSortingViewController *)sortVc
{
    if (!_sortVc) {
        _sortVc = [[DFEsignerSortingViewController alloc]init];
        _sortVc.delegate = self;
        _sortVc.view.hidden = YES;
        [self addChildViewController:_sortVc];
        [self.view addSubview:_sortVc.view];
    }
    return _sortVc;
}
- (void)selectChooseEsignerSortId:(NSString *)styleId withText:(NSString *)text
{
    [self.segment.collectionView reloadData];
    
    if (text.length == 0) {
        return;
    }

    [self.segment topBarReplaceObjectsAtIndexes:2 withObjects:text BarView:nil];
    self.parma[@"des_status"] = styleId;
    self.style.view.hidden = YES;
    [self.segment.collectionView reloadData];
    [self.dataListArry removeAllObjects];
    [self getdata];
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
