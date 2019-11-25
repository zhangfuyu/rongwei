//
//  DFSiteDetailViewController.m
//  rongwei
//
//  Created by zhangfuyu on 2019/11/25.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFSiteDetailViewController.h"
#import "DFSiteStageInfosModel.h"

@interface DFSiteDetailViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) NSMutableArray *infosArry;

@end

@implementation DFSiteDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"工地详情";
    [self getConstructiondetail];
    
    [self allocTableviewWith:UITableViewStylePlain];
    self.dataTableview.delegate = self;
    self.dataTableview.dataSource = self;
    
    [self.dataTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(kNavBarAndStatusBarHeight);
        make.bottom.mas_equalTo(-kBottomSafeHeight);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.infosArry.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    return cell;
}

- (void)getConstructiondetail
{
    
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:constructionSiteStageInfos withParameter:@{@"site_id":self.model.modelid} withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        
        if (isSuccess) {
            
            NSArray *dataarry = response[@"data"];
            if (dataarry.count > 0) {
                for (NSDictionary *dic in dataarry) {
                    DFSiteStageInfosModel *infosmodel = [[DFSiteStageInfosModel alloc]initWithDictionary:dic error:nil];
                    [self.infosArry addObject:infosmodel];
                }
            }
            
        }
    }];

}
- (NSMutableArray *)infosArry
{
    if (!_infosArry) {
        _infosArry = [NSMutableArray arrayWithCapacity:0];
    }
    return _infosArry;
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
