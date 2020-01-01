//
//  DFEsignerSortingViewController.m
//  rongwei
//
//  Created by zhangfuyu on 2019/12/30.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFEsignerSortingViewController.h"
#import "DFSortingCell.h"

@interface DFEsignerSortingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong)NSMutableArray *styleArry;
@property (nonatomic , strong)NSIndexPath *selecIndex;

@property (nonatomic , assign)BOOL isSelect;

@end

@implementation DFEsignerSortingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0];
    
    self.styleArry = [NSMutableArray arrayWithArray:@[@"综合排序",@"预约最多",@"签单最多",@"评价最多"]];
    
    [self allocTableviewWith:UITableViewStylePlain];
    self.dataTableview.delegate = self;
    self.dataTableview.dataSource = self;
    [self.dataTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(kNavBarAndStatusBarHeight + HScaleHeight(47));
        make.height.mas_equalTo(HScaleHeight(179));
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.styleArry.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"DFSortingCell";
    DFSortingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[DFSortingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.showTitle = self.styleArry[indexPath.row];
    if (self.isSelect) {
        if (self.selecIndex.row == indexPath.row) {
            cell.showHua = YES;
        }
        else
        {
            cell.showHua = NO;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.isSelect = YES;
    self.selecIndex = indexPath;
    [tableView reloadData];
    self.view.hidden = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectChooseEsignerSortId:withText:)]) {
        [self.delegate selectChooseEsignerSortId:[NSString stringWithFormat:@"%ld",indexPath.row] withText:self.styleArry[indexPath.row]];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (touch.view == self.view) {
        self.view.hidden = YES;
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectChooseSortId:withText:)]) {
            [self.delegate selectChooseEsignerSortId:@"" withText:@""];
        }
    }
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
