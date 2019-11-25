//
//  DFRvaluationViewController.m
//  rongwei
//
//  Created by apple on 2019/11/25.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFRvaluationViewController.h"
#import "DFCommentModel.h"
#import "DFDesignerCommentCell.h"

@interface DFRvaluationViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic , strong) NSMutableArray *comment_list;

@end

@implementation DFRvaluationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.comment_list = [NSMutableArray arrayWithCapacity:0];
    self.scrollView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.scrollView.delegate = self;
    self.scrollView.dataSource = self;
    [self.view addSubview:self.scrollView];
    
    self.scrollView.tableFooterView = [UIView new];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.mas_equalTo(0);
    }];
    [self getConstructionComment];
}
- (void)getConstructionComment
{
    
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:constructionComments withParameter:@{@"company_id":self.constructionid} withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        
        if (isSuccess) {
            
            NSArray *dataArry = response[@"data"];
            for (NSDictionary *dic in dataArry) {
                DFCommentModel *model = [[DFCommentModel alloc]initWithDictionary:dic error:nil];
                CGFloat contentHeight = [model.content heightForFont:HScaleFont(11) width:ScreenW - HScaleWidth(30)];
                model.contentHeight = [NSString stringWithFormat:@"%.2f",contentHeight];

                [self.comment_list addObject:model];
            }
            [self.scrollView reloadData];
            
        }
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

    DFCommentModel *model = self.comment_list[indexPath.row];
    CGFloat height = [model.contentHeight floatValue];
    return height + HScaleHeight(62.5);
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return HScaleHeight(40);
//}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    return self.secondHeaderView;
//}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!self.vcCanScroll) {
        scrollView.contentOffset = CGPointZero;
    }
    if (scrollView.contentOffset.y <= 0) {
        //        if (!self.fingerIsTouch) {//这里的作用是在手指离开屏幕后也不让显示主视图，具体可以自己看看效果
        //            return;
        //        }
        self.vcCanScroll = NO;
        scrollView.contentOffset = CGPointZero;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"leaveTop" object:nil];//到顶通知父视图改变状态
    }
//    self.scrollView.showsVerticalScrollIndicator = _vcCanScroll?YES:NO;
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
