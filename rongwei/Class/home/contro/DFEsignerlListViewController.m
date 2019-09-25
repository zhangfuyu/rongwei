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


@interface DFEsignerlListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , assign)NSInteger currentPage;

@property (nonatomic , assign)NSInteger pageSizre;

@property (nonatomic , strong)NSMutableArray *dataListArry;

@property (nonatomic, strong) CQTopBarViewController *topBar;


@end

@implementation DFEsignerlListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
   
    
    
    
    self.title = @"设计师";
    [self allocTableviewWith:UITableViewStyleGrouped];
    self.dataTableview.delegate = self;
    self.dataTableview.dataSource = self;
    
    [self tabelviewAddReload];
    [self tableviewAddMoreDown];
    
    
    self.dataTableview.tableFooterView = [UIView new];
    [self.dataTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.mas_equalTo(0);
        make.bottom.mas_equalTo(-kBottomSafeHeight);
    }];
    self.currentPage = 1;
    [self getdata];
    
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
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HScaleHeight(53);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.topBar.view;
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
    
    NSMutableDictionary *parma = [@{@"city_id":@"1025",
                                    @"page":@(self.currentPage),
                                    @"page_size":@(20)
    }copy];
    
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:DesignerListsApi withParameter:parma withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:NO withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        
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
            }
            else
            {
                self.currentPage --;
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
- (CQTopBarViewController *)topBar
{
    if (!_topBar) {
        _topBar = [[CQTopBarViewController alloc] init];
        _topBar.automaticallyAdjustsScrollViewInsets = NO;
        _topBar.segmentFrame = CGRectMake(0, 0, ScreenW, HScaleHeight(53));
        _topBar.sectionTitles = @[@"区域选择",@"擅长风格",@"综合排序"];
        _topBar.titleTextColor = [UIColor colorWithHexString:@"666666"];
        _topBar.selectedTitleTextColor = [UIColor colorWithHexString:@"DD1A21"];
        self.topBar.pageViewClasses = @[[CQTopBarViewController class],[CQTopBarViewController class],[CQTopBarViewController class]];
        [self addChildViewController:_topBar];
        [self.view addSubview:self.topBar.view];
    }
    return _topBar;
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
