//
//  DFGongLueCommentsViewController.m
//  rongwei
//
//  Created by zhangfuyu on 2019/11/28.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFGongLueCommentsViewController.h"
#import "DFGongLueCommentModel.h"

@interface DFGongLueCommentsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) NSMutableArray *comment_list;

@end

@implementation DFGongLueCommentsViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = [NSString stringWithFormat:@"全部评论(%@)",self.comment_num];
    [self getcomment];
    
    [self allocTableviewWith:UITableViewStylePlain];
    self.dataTableview.delegate = self;
    self.dataTableview.dataSource = self;
    
    [self.dataTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(kNavBarAndStatusBarHeight);
        make.bottom.mas_equalTo(-kBottomSafeHeight - HScaleHeight((54)));
    }];
    
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.comment_list.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    static NSString *cellid = @"DFDesignerCommentCell";
    DFDesignerCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[DFDesignerCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.model = self.comment_list[indexPath.row];
    return cell;
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    DFGongLueCommentModel *model = self.comment_list[indexPath.row];
    CGFloat height = [model.contentHeight floatValue];
    return height + HScaleHeight(62.5);
}
- (void)getcomment
{
    
    
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:BbsGuideComment withParameter:@{@"is_rec":@"0",@"bbs_id":self.bbs_id} withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
            
            if (isSuccess) {
                
                NSArray *dataArry = response[@"data"];
                for (NSDictionary *dic in dataArry) {
                    DFGongLueCommentModel *model = [[DFGongLueCommentModel alloc]initWithDictionary:dic error:nil];
                    CGFloat contentHeight = [model.com_content heightForFont:HScaleFont(11) width:ScreenW - HScaleWidth(30)];
                    model.contentHeight = [NSString stringWithFormat:@"%.2f",contentHeight];

                    [self.comment_list addObject:model];
                }
//                [self.scrollView reloadData];
                
            }
         
            
        }
    }];
}

- (NSMutableArray *)comment_list
{
    if (!_comment_list) {
        _comment_list = [NSMutableArray arrayWithCapacity:0];
    }
    return _comment_list;
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
