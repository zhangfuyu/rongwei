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
#import "DfDesignerTableViewCell.h"
#import "DFEsignerDetialViewController.h"
#import "DFConstructionModel.h"
#import "DFConstructionTtableCell.h"
#import "DFGongLueModel.h"
#import "DFHomeStrategyCell.h"
#import "DFStrategyDetailViewController.h"
#import "DFDesignerWorkModel.h"
#import "DFHomeWorkListCell.h"
#import "DFWorksDetailViewController.h"

@interface DFHomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong)DFSectionView *firstSection;

@property (nonatomic , strong)DFSectionView *secondSection;

@property (nonatomic , strong)DFSectionView *threeSection;

@property (nonatomic , strong)DFSectionView *fourSection;

@property (nonatomic , strong)DFHomeNaiBarView *narbaView;

@property (nonatomic , strong)NSMutableArray *navArry;

//设计师数组
@property (nonatomic , strong)NSMutableArray *designerListArry;
//施工工地列表
@property (nonatomic , strong)NSMutableArray *constructionArry;
//攻略列表
@property (nonatomic , strong)NSMutableArray *trategylistArry;
//攻略列表
@property (nonatomic , strong)NSMutableArray *work_listArry;
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
    
    //子线程请求省市区
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
           
        [[DFUserModelTool shareInstance]getcitydata];

    });
    
    self.title = @"首页";
//    [DFUserModelTool shareInstance].isLogin = true;
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
    
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:HomeAds withParameter:nil withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
            
            NSArray *hot = response[@"data"][@"app_hot"];//[@"APP-热门攻略广告位"];
            for (NSInteger index = 0; index < hot.count; index ++) {
                NSDictionary *dic = hot[index];
                DFHomeNavModel *model = [[DFHomeNavModel alloc]initWithDictionary:dic error:nil];
                [[DFUserModelTool shareInstance].hotArry addObject:model];
            }
            NSArray *banaer = response[@"data"][@"app_navi"];//[@"APP-首页轮播图"];
            for (NSInteger index = 0; index < banaer.count; index ++) {
                 NSDictionary *dic = hot[index];
                 DFHomeNavModel *model = [[DFHomeNavModel alloc]initWithDictionary:dic error:nil];
                 [[DFUserModelTool shareInstance].banaerArry addObject:model];
            }
            
            headerview.banaerArry = [DFUserModelTool shareInstance].banaerArry;
            
            NSArray *navdown = response[@"data"][@"app_banner"];//[@"APP-图标导航下方广告"];
            for (NSInteger index = 0; index < navdown.count; index ++) {
                 NSDictionary *dic = navdown[index];
                 DFHomeNavModel *model = [[DFHomeNavModel alloc]initWithDictionary:dic error:nil];
                 [[DFUserModelTool shareInstance].navDownArry addObject:model];
            }
            headerview.navdownArry = [DFUserModelTool shareInstance].navDownArry;
            
        }
    }];
    
    //子线程请求推荐设计师
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
           
        [self getWorkData];
        [self getdesignerList];
        [self getConstruction];
        [self getstrategylist];

    });
    
//    NSMutableArray *arry = [DFGetNetData getadvertising];
    
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
    if (section == 2) {
        return self.designerListArry.count;
    }
    else if (section == 1)
    {
        return 1;
    }
    else if (section == 3)
    {
        return self.trategylistArry.count;
    }
    return self.work_listArry.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 2) {
            static NSString *cellid = @"DfDesignerTableViewCell";
        DfDesignerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[DfDesignerTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        cell.model = [self.designerListArry objectAtIndex:indexPath.row];
        
        return cell;
    }
    else if (indexPath.section == 1)
    {
        
        static NSString *ConstructionTtableCell = @"DFConstructionTtableCell";
        DFConstructionTtableCell *cell = [tableView dequeueReusableCellWithIdentifier:ConstructionTtableCell];
        if (!cell) {
            cell = [[DFConstructionTtableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ConstructionTtableCell];
        }
            
        cell.dataArry = self.constructionArry;
        return cell;
    }
    else if (indexPath.section == 3)
    {
        
        
        static NSString *cellid = @"DFHomeStrategyCell";
        DFHomeStrategyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[DFHomeStrategyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        cell.model = [self.trategylistArry objectAtIndex:indexPath.row];
        
        return cell;
    }
    
    
    static NSString *Cellidear = @"DFHomeWorkListCell";
    DFHomeWorkListCell *cell = [tableView dequeueReusableCellWithIdentifier:Cellidear];
    if (!cell) {
        cell = [[DFHomeWorkListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cellidear];
    }
    cell.model = self.work_listArry[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        return HScaleHeight(105);
    }
    else if (indexPath.section == 1)
    {
       return HScaleHeight(140);
    }
    else if (indexPath.section == 3)
    {
        return HScaleHeight(105);
    }
    return HScaleHeight(222);
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
    if (indexPath.section == 2) {
        DFEsignerDetialViewController *detail = [[DFEsignerDetialViewController alloc]init];
        detail.model = self.designerListArry[indexPath.row];
        [self.navigationController pushViewController:detail animated:YES];
    }
    else if (indexPath.section == 3)
    {
        DFGongLueModel *model = self.trategylistArry[indexPath.row];
        DFStrategyDetailViewController *detail = [[DFStrategyDetailViewController alloc]init];
        detail.modelid = model.modelId;
        [self.navigationController pushViewController:detail animated:YES];
    }
    else if (indexPath.section == 0)
    {
        DFDesignerWorkModel *model = self.work_listArry[indexPath.row];
        DFWorksDetailViewController *worksdetail = [[DFWorksDetailViewController alloc]init];
        worksdetail.worksId = model.modelid;
//        worksdetail.model = self.model;
        worksdetail.autherID = model.designer_id;
        [self.navigationController pushViewController:worksdetail animated:YES];
    }
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

/// 推荐案例
- (void)getWorkData
{
    NSMutableDictionary *parmar = [@{
        @"is_rec":@"1",
        @"itemsPerLoad":@"2"

    }copy];
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:WorkDesignerDetailApi withParameter:parmar withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
           if (isSuccess) {
               
              NSArray *listarry = response[@"data"];
              if (listarry.count > 0) {
                  for (NSDictionary *dic in listarry) {
                      DFDesignerWorkModel *workmodel = [[DFDesignerWorkModel alloc]initWithDictionary:dic error:nil];
                      [self.work_listArry addObject:workmodel];
                  }
              }
              [self.dataTableview reloadData];
               
           }
       }];
}

- (void)getdesignerList
{
    
    NSMutableDictionary *parma = [@{@"is_rec":@"1",
                                    @"itemsPerLoad":@(3),
//                                    @"page_size":@(20)
    }copy];
    
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:DesignerListsApi withParameter:parma withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        
        if (isSuccess) {
            NSLog(@"请求成功");
            NSArray *dataarry = response[@"data"];
            [self.designerListArry removeAllObjects];
            
            if (dataarry > 0) {
                for (NSDictionary *dic in dataarry) {
                    DFDesignerModel *model = [[DFDesignerModel alloc] initWithDictionary:dic error:nil];
                    [self.designerListArry addObject:model];
                    if (self.designerListArry.count >= 2) {
                        break;
                    }
                }
            }

            dispatch_async(dispatch_get_main_queue(), ^{
                        
//                [self.dataTableview reloadSection:2 withRowAnimation:UITableViewRowAnimationNone];
                    [self.dataTableview reloadData];
                
            });
        }
            
    }];
}

//请求施工列表
- (void)getConstruction
{
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:Construction withParameter:@{@"is_rec":@"1"} withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
            
            NSArray *dataarry = response[@"data"];
            
            for (NSInteger index = 0; index < dataarry.count; index ++) {
                DFConstructionModel *model = [[DFConstructionModel alloc]initWithDictionary:dataarry[index] error:nil];
                [self.constructionArry addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                           
                   
//                [self.dataTableview reloadSection:1 withRowAnimation:UITableViewRowAnimationNone];
                [self.dataTableview reloadData];
               
            });
        }
    }];
}
//热门攻略列表
- (void)getstrategylist
{
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:BbsGuide withParameter:@{@"is_rec":@"1"} withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
            
            NSArray *dataArry = response[@"data"];
            if (dataArry.count > 0) {
                for (NSDictionary *dic in dataArry) {
                    DFGongLueModel *model = [[DFGongLueModel alloc]initWithDictionary:dic error:nil];
                    [self.trategylistArry addObject:model];
                }
                
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                        
//                [self.dataTableview reloadSection:3 withRowAnimation:UITableViewRowAnimationNone];
                [self.dataTableview reloadData];

            });
            
        }
    }];
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
- (NSMutableArray *)designerListArry
{
    if (!_designerListArry) {
        _designerListArry = [NSMutableArray arrayWithCapacity:0];
    }
    return _designerListArry;
}
- (NSMutableArray *)constructionArry
{
    if (!_constructionArry) {
        _constructionArry = [NSMutableArray arrayWithCapacity:0];
    }
    return _constructionArry;
}
- (NSMutableArray *)trategylistArry
{
    if (!_trategylistArry) {
        _trategylistArry = [NSMutableArray arrayWithCapacity:0];
    }
    return _trategylistArry;
}
- (NSMutableArray *)work_listArry
{
    if (!_work_listArry) {
        _work_listArry = [NSMutableArray arrayWithCapacity:0];
    }
    return _work_listArry;
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
