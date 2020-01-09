//
//  DFContactUsViewController.m
//  rongwei
//
//  Created by zhangfuyu on 2020/1/9.
//  Copyright © 2020 zhangfuyu. All rights reserved.
//

#import "DFContactUsViewController.h"

@interface DFContactUsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) NSArray *titleArry;

@property (nonatomic , strong) NSArray *subTitleArry;

@property (nonatomic , strong) UIView *footView;

@end

@implementation DFContactUsViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"联系我们";
    
    self.titleArry = [NSArray arrayWithObjects:@"荣装官网",@"联合创展",@"服务热线", nil];
    
    self.subTitleArry = [NSArray arrayWithObjects:@"www.rongzw.com",@"www.zjlhcz.com",@"400-622-1988", nil];
    
    
    [self allocTableviewWith:UITableViewStylePlain];
    self.dataTableview.delegate = self;
    self.dataTableview.dataSource = self;
    self.dataTableview.tableFooterView = self.footView;
    
    [self.dataTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(kNavBarAndStatusBarHeight);
    }];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArry.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid];
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    cell.textLabel.font = HScaleFont(12);
    cell.textLabel.textColor = [UIColor colorWithHexString:@"333333"];
    cell.textLabel.text = self.titleArry[indexPath.row];
    cell.detailTextLabel.font = HScaleFont(12);
    cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"999999"];
    cell.detailTextLabel.text = self.subTitleArry[indexPath.row];
    return cell;
}

- (UIView *)footView
{
    if (!_footView) {
        _footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, HScaleHeight(320))];
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.text = @"       公司地址";
        titleLabel.font = HScaleFont(12);
        titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
        titleLabel.backgroundColor = [UIColor colorWithHexString:@"F7F7F7"];
        [_footView addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(HScaleHeight(40.5));
        }];
        
        
        UIView *downView = [[UIView alloc]init];
        downView.backgroundColor = [UIColor whiteColor];
        [_footView addSubview:downView];
        
        [downView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(titleLabel.mas_bottom);
            make.height.mas_equalTo(HScaleHeight(279));
        }];
        
        
        UILabel *subtitleLabel = [[UILabel alloc]init];
        subtitleLabel.text = @"       浙江省丽水市莲都区厦河路107号二楼";
        subtitleLabel.font = HScaleFont(12);
        subtitleLabel.textColor = [UIColor colorWithHexString:@"333333"];
        [downView addSubview:subtitleLabel];
        [subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(HScaleHeight(14));
        }];
        
        
        UIImageView *addressimage = [[UIImageView alloc]init];
        addressimage.image = [UIImage imageNamed:@"company_address"];
        [downView addSubview:addressimage];
        
        [addressimage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(HScaleHeight(222.5));
            make.top.mas_equalTo(subtitleLabel.mas_bottom).offset(HScaleHeight(11));
        }];
    }
    return _footView;
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
