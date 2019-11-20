//
//  DFEsignerDetialViewController.m
//  rongwei
//
//  Created by apple on 2019/9/26.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFEsignerDetialViewController.h"
#import "DFDesignerView.h"
#import "DFCasesView.h"

#import "DFDesignerWorkModel.h"
#import "DFWorkListTableViewCell.h"
#import "DFCommentModel.h"
#import "DFDesignerCommentCell.h"
#import "DFAppointViewController.h"

@interface DFEsignerDetialViewController ()<UITableViewDelegate,UITableViewDataSource,DFAppointViewControllerDelegate>

@property (nonatomic , strong)DFDesignerView *headerView;

@property (nonatomic , strong) NSMutableArray *dataArry;

@property (nonatomic , strong) NSMutableArray *work_list;//作品

@property (nonatomic , strong) NSMutableArray *comment_list;//作品

@property (nonatomic , strong) DFCasesView *secondHeaderView;

@property (nonatomic , strong) NSString *worlcount;

@property (nonatomic , assign) NSInteger selectStyle;// 1作品 2个人简介。3评价

@property (nonatomic , strong) UIButton *likeThisBtn;
@end

@implementation DFEsignerDetialViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.model.name;
    
    self.selectStyle = 1;
    
    [self allocTableviewWith:UITableViewStylePlain];
    self.dataTableview.delegate = self;
    self.dataTableview.dataSource = self;
    self.dataTableview.tableFooterView = [UIView new];
    self.dataTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.dataTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(kNavBarAndStatusBarHeight);
        make.bottom.mas_equalTo(-kBottomSafeHeight);
    }];
    
    self.dataTableview.tableHeaderView = self.headerView;

    self.headerView.model = self.model;

    self.likeThisBtn.selected = NO;
    
    
    [self getWorkData];
    
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:DesignerDetailApi withParameter:@{@"id":self.model.modelId} withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {

//            self.model = [[DFDesignerModel alloc]initWithDictionary:response[@"data"] error:nil];
//            self.headerView.model = self.model;
            NSDictionary *listdic = response[@"data"][@"work_list"];

            NSArray *listarry = listdic[@"list"];
            if (listarry.count > 0) {
                self.worlcount = [NSString stringWithFormat:@"%@",response[@"data"][@"work_list"][@"count"]];
                self.secondHeaderView.workcount = self.worlcount;
                for (NSDictionary *dic in listarry) {
                    DFDesignerWorkModel *workmodel = [[DFDesignerWorkModel alloc]initWithDictionary:dic error:nil];
                    [self.work_list addObject:workmodel];
                }
            }
//            [self getWorkData];
            [self.dataTableview reloadData];
        }
    }];
}

/// 作品
- (void)getWorkData
{
    NSMutableDictionary *parmar = [@{
        @"designer_id":self.model.modelId,

    }copy];
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:WorkDesignerDetailApi withParameter:parmar withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
           if (isSuccess) {
               
              NSArray *listarry = response[@"data"];
              if (listarry.count > 0) {
                  for (NSDictionary *dic in listarry) {
                      DFDesignerWorkModel *workmodel = [[DFDesignerWorkModel alloc]initWithDictionary:dic error:nil];
                      [self.work_list addObject:workmodel];
                  }
              }
              [self.dataTableview reloadData];
               
           }
       }];
}

/// 个人简介
- (void)getPersonalProfile
{
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:DesignerAboutDetailApi withParameter:@{@"id":self.model.modelId} withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
            
           
            
        }
    }];
}

/// 评论
- (void)getComment
{
    
    NSMutableDictionary *parmar = [@{
        @"designer_id":@"5",//self.model.modelId,

    }copy];
    
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:DesignerCommentDetailApi withParameter:parmar withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
           if (isSuccess) {
               
               NSArray *dataArry = response[@"data"];
               for (NSDictionary *dic in dataArry) {
                   DFCommentModel *model = [[DFCommentModel alloc]initWithDictionary:dic error:nil];
                   CGFloat contentHeight = [model.content heightForFont:HScaleFont(11) width:ScreenW - HScaleWidth(30)];
                   model.contentHeight = [NSString stringWithFormat:@"%.2f",contentHeight];

                   [self.comment_list addObject:model];
               }
               [self.dataTableview reloadData];
               
           }
       }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.selectStyle == 1) {
        return self.work_list.count;
    }
    else if (self.selectStyle == 3)
    {
        return self.comment_list.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.selectStyle == 1) {
        static NSString *cellid = @"DFWorkListTableViewCell";
        DFWorkListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[DFWorkListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        cell.model = self.work_list[indexPath.row];
        return cell;
    }
    else if (self.selectStyle == 3)
    {
        static NSString *cellid = @"DFDesignerCommentCell";
        DFDesignerCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[DFDesignerCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        cell.model = self.comment_list[indexPath.row];
        return cell;
    }
    
    static NSString *cellid = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectStyle == 1) {
            
        return HScaleHeight(242);

    }
    else if (self.selectStyle == 3)
    {
        DFCommentModel *model = self.comment_list[indexPath.row];
        CGFloat height = [model.contentHeight floatValue];
        return height + HScaleHeight(62.5);
    }
    return HScaleHeight(242);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HScaleHeight(40);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.secondHeaderView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)getDesignerWorks
{
    
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:WorkDesignerDetailApi withParameter:@{@"designer_id":self.model.modelId} withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {

//            self.model = [[DFDesignerModel alloc]initWithDictionary:response[@"data"] error:nil];
//            self.headerView.model = self.model;
//            NSDictionary *listdic = response[@"data"][@"work_list"];

            NSArray *listarry = response[@"data"];
            if (listarry.count > 0) {
//                self.worlcount = [NSString stringWithFormat:@"%@",response[@"data"][@"work_list"][@"count"]];
//                self.secondHeaderView.workcount = self.worlcount;
                for (NSDictionary *dic in listarry) {
                    DFDesignerWorkModel *workmodel = [[DFDesignerWorkModel alloc]initWithDictionary:dic error:nil];
                    [self.work_list addObject:workmodel];
                }
            }
//            [self getWorkData];
            [self.dataTableview reloadData];
        }
    }];
}

#pragma mark - 预约资料填写
- (void)FillInTheInformation
{
    NSLog(@"---->点击了填写资料");
}

/// y预约
- (void)appointresigner
{
    DFAppointViewController *appoint = [[DFAppointViewController alloc]init];
    appoint.delegate = self;
    [self.navigationController pushViewController:appoint animated:YES];
}
- (NSMutableArray *)work_list
{
    if (!_work_list) {
        _work_list = [NSMutableArray arrayWithCapacity:0];
    }
    return _work_list;
}
- (NSMutableArray *)dataArry
{
    if (!_dataArry) {
        _dataArry = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArry;
}
- (DFDesignerView *)headerView
{
    if (!_headerView) {
        _headerView = [[DFDesignerView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, HScaleHeight(192))];
        [_headerView.appointmentBtn addTarget:self action:@selector(appointresigner) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_headerView];
    }
    return _headerView;
}

- (DFCasesView *)secondHeaderView
{
    if (!_secondHeaderView) {
        _secondHeaderView = [[DFCasesView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, HScaleHeight(40))];
        _secondHeaderView.backgroundColor = [UIColor whiteColor];
        _secondHeaderView.titleArry = [NSMutableArray arrayWithArray:@[@"作品（0）",@"个人简介",@"评价"]];
        __weak typeof(self) weakself = self;
        _secondHeaderView.clickTypeBlock = ^(NSString * _Nonnull clickTitle) {
            if ([clickTitle isEqualToString:@"个人简介"]) {
                [weakself getPersonalProfile];
            }
            else if ([clickTitle isEqualToString:@"评价"])
            {
                weakself.selectStyle = 3;

                weakself.dataTableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
                weakself.dataTableview.separatorInset = UIEdgeInsetsMake(0, HScaleWidth(10.5), 0, HScaleWidth(10.5));
                if (self.comment_list.count == 0) {
                                    
                    [weakself getComment];

                }

            }
            else
            {
                weakself.selectStyle = 1;
                weakself.dataTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
                if (self.work_list.count == 0) {
                    [weakself getWorkData];
                }
                
            }
            [weakself.dataTableview reloadData];
                
        };
    }
    return _secondHeaderView;
}
- (UIButton *)likeThisBtn
{
    if (!_likeThisBtn) {
        _likeThisBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_likeThisBtn setTitleColor:UIColorHex(0x010101) forState:UIControlStateNormal];
        _likeThisBtn.frame = CGRectMake(0, 0, HScaleWidth(83), 44);
        _likeThisBtn.titleLabel.font = HScaleFont(12);
        [_likeThisBtn setTitleColor:[UIColor colorWithHexString:@"DD1A21"] forState:UIControlStateNormal];
        [_likeThisBtn setTitle:@"  关注" forState:UIControlStateNormal];
        [_likeThisBtn setImage:[UIImage imageNamed:@"no_Focus_on"] forState:UIControlStateNormal];
        [_likeThisBtn setImage:[UIImage imageNamed:@"Focus_on"] forState:UIControlStateSelected];
        [_likeThisBtn addTarget:self action:@selector(focusonThis) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightBtn1 = [[UIBarButtonItem alloc] initWithCustomView:_likeThisBtn];
        self.navigationItem.rightBarButtonItem = rightBtn1;
        
    }
    return _likeThisBtn;
}
- (NSMutableArray *)comment_list
{
    if (!_comment_list) {
        _comment_list = [NSMutableArray arrayWithCapacity:0];
    }
    return _comment_list;
}
- (void)focusonThis
{
    
    self.likeThisBtn.selected = !self.likeThisBtn.selected;
}
- (void)dealloc
{
    
}
@end
