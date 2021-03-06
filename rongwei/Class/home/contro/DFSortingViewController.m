//
//  DFSortingViewController.m
//  rongwei
//
//  Created by zhangfuyu on 2019/12/29.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFSortingViewController.h"
#import "DFSortingCell.h"

@interface DFSortingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)NSMutableArray *styleArry;
@property (nonatomic , strong)NSIndexPath *selecIndex;

@property (nonatomic , assign)BOOL isSelect;

@end

@implementation DFSortingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
    
    self.styleArry = [NSMutableArray arrayWithArray:@[@"综合排序",@"点评最多",@"距离优先"]];
    
    [self allocTableviewWith:UITableViewStylePlain];
    self.dataTableview.delegate = self;
    self.dataTableview.dataSource = self;
    [self.dataTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(HScaleHeight(135));
    }];
    
    // Do any additional setup after loading the view.
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
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectChooseSortId:withText:)]) {
        [self.delegate selectChooseSortId:[NSString stringWithFormat:@"%ld",indexPath.row + 2] withText:self.styleArry[indexPath.row]];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (touch.view == self.view) {
        self.view.hidden = YES;
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectChooseSortId:withText:)]) {
            [self.delegate selectChooseSortId:@"" withText:@""];
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
