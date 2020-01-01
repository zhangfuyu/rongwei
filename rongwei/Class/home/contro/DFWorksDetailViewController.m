//
//  DFWorksDetailViewController.m
//  rongwei
//
//  Created by zhangfuyu on 2019/12/3.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFWorksDetailViewController.h"
#import "DFDesignerWorkModel.h"
#import "DFWorksDetailView.h"
#import "DFNewMainTableView.h"
#import "DFBottomTableViewCell.h"
#import "DFSitWorksListViewController.h"
#import "DFSitDetailHeaderView.h"
#import "DFCommentBommenView.h"

@interface DFWorksDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) DFDesignerWorkModel *workModel;
@property (nonatomic, strong) DFNewMainTableView *homeTableview;
@property (nonatomic , strong) DFSitDetailHeaderView *secondrview;
@property (nonatomic, strong) DFBottomTableViewCell *contentCell;
@property (nonatomic , strong) DFWorksDetailView*headerview;
@property (nonatomic , assign) BOOL canScroll;
@property (nonatomic , strong) DFCommentBommenView *boomview;
@property (nonatomic , assign) CGFloat contentHeight;


@end

@implementation DFWorksDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.canScroll = YES;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollStatus) name:@"leaveTop" object:nil];
    
    
    
    if (self.model == nil) {
            NSString *urlstr = [NSString stringWithFormat:@"%@/%@",DesignerDetailApi,self.autherID];
            
            [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:urlstr withParameter:nil withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
                if (isSuccess) {

                    self.model = [[DFDesignerModel alloc]initWithDictionary:response[@"data"] error:nil];
                    [self getWorkDetail];

                }
            }];
    }
    else
    {
        [self getWorkDetail];
    }

    

    
    [self.boomview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(- kBottomSafeHeight);
        make.height.mas_equalTo(HScaleHeight(54));
    }];
}

- (void)getWorkDetail
{
     NSString *urlstr = [NSString stringWithFormat:@"%@/%@",DesignerAboutworksApi,self.worksId];
     
    
     [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:urlstr withParameter:nil withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
         if (isSuccess) {
             
             self.workModel = [[DFDesignerWorkModel alloc] initWithDictionary:response[@"data"] error:nil];
             [self getrecommended];
             
         }
     }];
}

- (void)getrecommended
{
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:WorkDesignerDetailApi withParameter:@{@"designer_id":self.model.modelId} withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
            
            NSArray *listarry = response[@"data"];
            if (listarry.count > 0) {
                
                NSInteger remainder = listarry.count % 2;
                NSInteger zhengshu = listarry.count / 2;
                if (remainder > 0) {
                    self.contentHeight = (zhengshu + 1) * HScaleHeight(125.5) + (zhengshu + 2) *HScaleHeight(10);
                }
                else
                {
                    self.contentHeight = zhengshu * HScaleHeight(125.5) + (zhengshu + 2) * HScaleHeight(10);

                }

            }
            [self creattable];
        }
    }];
}

#pragma mark notify
- (void)changeScrollStatus//改变主视图的状态
{
    self.canScroll = YES;
    self.contentCell.cellCanScroll = NO;
}
- (void)creattable
{
    
//    [self.view addSubview:self.headerview];
    self.homeTableview = [[DFNewMainTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.homeTableview.tableHeaderView = self.headerview;
    self.homeTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.homeTableview.delegate = self;
    self.homeTableview.dataSource = self;
    [self.view addSubview:self.homeTableview];
    WEAKSELF;
    self.headerview.globalBlockInMemory = ^(float headerHeight) {
        weakSelf.headerview.frame = CGRectMake(0, 0, ScreenW, headerHeight);
//        weakSelf.headetheight = headerHeight;
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
//    return ScreenH - HScaleHeight(47) - kBottomSafeHeight - HScaleHeight(54);
    return self.contentHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _contentCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!_contentCell) {
        _contentCell = [[DFBottomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        NSMutableArray *contentVCs = [NSMutableArray array];

        DFSitWorksListViewController *construction = [[DFSitWorksListViewController alloc]init];
//        construction.constructionid = @"1";
        construction.sitmodel = self.model;
        construction.worksId = self.worksId;
        construction.authorID = self.autherID;
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
    return HScaleHeight(98);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.secondrview;
}

#pragma mark UIScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
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

- (DFWorksDetailView *)headerview
{
    if (!_headerview) {
        _headerview = [[DFWorksDetailView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, HScaleHeight(346.5)) withModel:self.workModel];
    }
    return _headerview;
}
- (DFSitDetailHeaderView *)secondrview
{
    if (!_secondrview) {
        _secondrview = [[DFSitDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, HScaleHeight(98)) withmodel:self.model];
    }
    return _secondrview;
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
