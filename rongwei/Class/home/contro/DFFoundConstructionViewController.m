//
//  DFFoundConstructionViewController.m
//  rongwei
//
//  Created by apple on 2019/11/20.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFFoundConstructionViewController.h"
#import "DFTextField.h"
#import "DfConstructionHeadrView.h"
#import "DFConstructionModel.h"
#import "DFCompanyModel.h"
#import "DFCompanyTableViewCell.h"
#import "CQTopBarSegment.h"
#import "DFContructionDetailViewController.h"

@interface DFFoundConstructionViewController ()<UITableViewDelegate , UITableViewDataSource>

@property (nonatomic , strong) DFTextField *searchTextField;

@property (nonatomic ,  strong) NSMutableArray *constructionArry;

@property (nonatomic ,  strong) NSMutableArray *companyArry;//公司列表

@property (nonatomic , strong) DfConstructionHeadrView *header;

@property (nonatomic , strong) CQTopBarSegment *segment;

@property (nonatomic , strong) UIView *secondView;

@end

@implementation DFFoundConstructionViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"找施工";
    [self setupNavigationBar];
    
    self.header = [[DfConstructionHeadrView alloc]initWithFrame:CGRectMake(0, kNavBarAndStatusBarHeight, ScreenW, HScaleHeight(360))];
    
    [self allocTableviewWith:UITableViewStylePlain];
    self.dataTableview.delegate = self;
    self.dataTableview.dataSource = self;
    
    self.dataTableview.tableHeaderView = self.header;
    self.dataTableview.tableFooterView = [UIView new];
    self.dataTableview.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    [self.dataTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(kNavBarAndStatusBarHeight);
        make.bottom.mas_equalTo(-kBottomSafeHeight);
    }];
    
    //子线程请求推荐设计师
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
           
        [self getConstruction];
        
        [self getCompany];
    });
    
}
- (void)setupNavigationBar
{

    UIView *navigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, kNavBarAndStatusBarHeight)];
    navigationView.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
//    [self.navigationController.navigationBar addSubview:navigationView];
    [self.view addSubview:navigationView];

//    self.navigationView = navigationView;

    self.searchTextField = [[DFTextField alloc]initWithFrame:CGRectZero];
    self.searchTextField.backgroundColor = [UIColor colorWithHexString:@"F4F4F4"];
    self.searchTextField.layer.cornerRadius = 14;
    self.searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.searchTextField.userInteractionEnabled = YES;
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"找施工" attributes:
    @{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"999999"],
                 NSFontAttributeName:[UIFont systemFontOfSize:12]
         }];
    self.searchTextField.enabled = YES;
    self.searchTextField.attributedPlaceholder = attrString;
    self.searchTextField.font = [UIFont systemFontOfSize:12];
//    searchTextField.delegate = self;
    self.searchTextField.textColor = [UIColor blackColor];
    self.searchTextField.returnKeyType = UIReturnKeySearch;
//    searchTextField.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.24].CGColor;
//    searchTextField.layer.shadowOffset = CGSizeMake(0,2);
//    searchTextField.layer.shadowOpacity = 1;
//    searchTextField.layer.shadowRadius = 4;
    

    [navigationView addSubview:self.searchTextField];
                                                                      
    [self.searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(8 +kStatusBarHeight);
        make.left.mas_equalTo(HScaleWidth(62.5));
        make.height.mas_equalTo(28);
        make.right.mas_equalTo(-HScaleWidth(62.5));
    }];
                                                                      
    self.searchTextField.leftSpace = 29;

    UIView *lefrview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 14 + 15, 28)];
                                      
    UIImageView *searchIconImageView = [[UIImageView alloc] init];
    searchIconImageView.contentMode = UIViewContentModeCenter;
    searchIconImageView.image = [UIImage imageNamed:@"sousuo"];

    [lefrview addSubview:searchIconImageView];
    
    [searchIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(14);
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.centerY.mas_equalTo(lefrview.mas_centerY);
    }];
    
    [self.searchTextField addSubview:lefrview];


//    [searchTextField addTarget:self action:@selector(clickSearchAction) forControlEvents:UIControlEventEditingDidEndOnExit];




    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];

    [searchButton setImage:[UIImage imageNamed:@"home_notice"] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(clickSearchAction) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:searchButton];

    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.searchTextField.mas_right);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(kStatusBarHeight);
        make.right.mas_equalTo(0);
    }];
    
    

    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, 44, 44)];
    backBtn.showsTouchWhenHighlighted = NO;
    [backBtn setImage:[UIImage imageNamed:@"login_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickCancelAction) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:backBtn];



}

/// 获取施工公司列表
- (void)getCompany
{
    
    NSMutableDictionary *parmars = [@{
        @"lat":@"30.3751",
        @"lng":@"120.1236"
    }copy];
    
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:Company withParameter:parmars withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
            
            NSArray *dataarry = response[@"data"];
            
            for (NSInteger index = 0; index < dataarry.count; index ++) {
                DFCompanyModel *model = [[DFCompanyModel alloc]initWithDictionary:dataarry[index] error:nil];
                [self.companyArry addObject:model];
            }
            [self.dataTableview reloadData];
        }
    }];
}
//请求施工列表
- (void)getConstruction
{
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:Construction withParameter:nil withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
            
            NSArray *dataarry = response[@"data"];
            
            for (NSInteger index = 0; index < dataarry.count; index ++) {
                DFConstructionModel *model = [[DFConstructionModel alloc]initWithDictionary:dataarry[index] error:nil];
                [self.constructionArry addObject:model];
            }
            
            self.header.dataArry = self.constructionArry;
        }
    }];
}

#pragma mark - UITableViewDelegate , UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.companyArry.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"cellid";
    
    DFCompanyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (!cell) {
        cell = [[DFCompanyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.model = self.companyArry[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HScaleHeight(105);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HScaleHeight(57);
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.secondView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DFContructionDetailViewController *detailview = [[DFContructionDetailViewController alloc]init];
    detailview.model = self.companyArry[indexPath.row];
    [self.navigationController pushViewController:detailview animated:YES];
}


- (void)clickSearchAction
{
    
}
- (void)clickCancelAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSMutableArray *)constructionArry
{
    if (!_constructionArry) {
        _constructionArry = [NSMutableArray arrayWithCapacity:0];
    }
    return _constructionArry;
}

- (NSMutableArray *)companyArry
{
    if (!_companyArry) {
        _companyArry = [NSMutableArray arrayWithCapacity:0];
    }
    return _companyArry;
}
- (UIView *)secondView
{
    if (!_secondView) {
        _secondView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, HScaleHeight(57))];
        _secondView.backgroundColor = [UIColor colorWithHexString:@"F7F7F7"];
        [_secondView addSubview:self.segment];
    }
    return _secondView;
}

- (CQTopBarSegment *)segment
{
    if (!_segment) {
        _segment = [[CQTopBarSegment alloc]initWithFrame:CGRectMake(0, HScaleHeight(5), ScreenW, HScaleHeight(47)) sectionTitles:@[@"区域选择",@"综合",@"筛选"]];
        _segment.titleTextColor = [UIColor colorWithHexString:@"666666"];
        _segment.segmentImage = @"箭头";
        _segment.selectSegmentImage = @"箭头-1";
        _segment.selectedTitleTextColor = [UIColor colorWithHexString:@"DD1A21"];
        _segment.titleTextFont = HScaleFont(12);
        _segment.segmentlineColor = [UIColor clearColor];
    }
    return _segment;
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