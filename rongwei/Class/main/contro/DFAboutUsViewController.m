//
//  DFAboutUsViewController.m
//  rongwei
//
//  Created by zhangfuyu on 2020/1/9.
//  Copyright © 2020 zhangfuyu. All rights reserved.
//

#import "DFAboutUsViewController.h"
#import "DFUsTableViewCell.h"
#import "DFMainSeconView.h"

@interface DFAboutUsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UIView *headerView;

@property (nonatomic , strong) NSArray *titleArry;

@property (nonatomic , strong) UIView *footView;


@property (nonatomic , strong) DFMainSeconView *secondView;

@property (nonatomic , strong) DFMainSeconView *threeView;

@property (nonatomic , strong) DFMainSeconView *fourView;

@end

@implementation DFAboutUsViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    self.titleArry = [NSArray arrayWithObjects:
                      @"人类从印刷术开始历经多次技术革新，到今天互联网技术蓬勃发展，万物互联使得人们接触信息由原来的不对等到现在信息自由获取，极大的提高了社会工作效率和效能。技术进步引领企业变革，其最终实质是还权于民，这正是荣装网站创立初衷。荣装网是浙江联合创展科技股份有限公司投资的泛家装生态聚合平台，传统与互联网家装的整合，德系互联网家装标准践行者。荣装网致力于用互联网思维及技术，改变传统家装行业产业链，去掉层层中间环节修最短路径，实现消费者利益的最大化，重塑行业的新商业文明。\n\n   荣装网，作为传统家装的改革者和革命者，以新型互联网家装公司的理念，成长迅猛，获得了众多用户的青睐，现已成立杭州、丽水、温州、宁波等分公司，并将继续拓展全国市场，造福更多百姓，真正开启快乐装修之旅。",@"传统家装行业存在信息不对称、不透明、服务链条过长、恶意加价、个性化与标准化需求兼顾等诸多痛点。互联网家装就是在这样的环境下应运而生，具有价格透明化、工程透明化等诸多优势，它让装修变得透明、简单，使个性装修需求最大程度实现标准化，是传统家装行业未来发展的必然趋势。\n\n基于种种传统家装弊病，荣装网在创立初期就开始研究家装电商模式，致力于提供标准、简单、透明的互联网家装，知情、选择、评价、分享，真正实现还权于民。\n\n荣装网启用家装电商F2B2C模式，重构家装行业产业链，实现商品F2C（factory to customer 工厂到客户），打造标准、简单、透明的网上购买、线下体验的家装一站式服务。荣装网作为传统家装的改革者和革命者，用新型互联网家装公司的理念，打造极具性价比互联网家装产品\n\n（一）优质资源的整合\n互联网家装市场发展的核心要素是高度有效整合家装产业的优质资源并相互串联，但目前资源分布仍然较为分散，这直接导致用户在线上对于信息的筛选和甄别、设计、预算、购买等不能和最终的家装本地服务和装修结果达到相对统一和精准的状态，效率不高。\n\n（二）健全统一的产品功能\n\n互联网家装市场发展的核心要素是健全统一的线上产品功能。在资源高度整合、本地服务高效保质、供应链透明升级的前提下，线上的产品功能应与线下服务保持统一，不仅拥有线上的服务入口、施工进度及质量的线上透明监管，也应满足用户的众多个性化需求。只有线上产品功能健全统一，才能通过标准的流程和强大的产品，实现家装市场的真正变革。",@"这是一个标榜“个性”的时代，似乎没有自己的想法，就会被视作死板、保守，“个性化”在家居选购方面更是被体现的淋漓尽致。由于居住房屋架构的不一样，消费者需求的多样化，定制家居以其贴切化、个性化受到年轻一代甚至是年长者的极大青睐。得到这样的一个主流消费群体的青睐，让定制家居在未来家装市场的发展占据了重要的位置，而随着“互联网+”的渗透，“互联网+定制家装”更将会进入飞速发展的状态。\n\n荣装网为什么会成为定制家居互联网平台中一大亮点呢？从平台属性来看，其属于定制家居互联网020服务平台。它的成功之处在于：这是一个连接商家和业主的互联网家装平台，这是一个成功实现了定制家居上、中、下游全产业链贯通的互联网平台。\n\n荣装网囊括从预约、设计、报价、监理、到材料购买等全过程，其平台操作流程很简单。它倡导的是“零投入，高性价比”，消费者只需要在荣装网上发布一个定制预约信息，说明自己的房子在哪里、多大、预算多少、定制风格等等，荣装网定制平台就能快速按照地区性质、定制家居要求、价格层次、风格设定等条件推荐三家品质有保证、符合业主需求的优质定制家居厂商，并提供免费上门测量、免费设计和免费报价等服务。\n\n个性装修，让有保障的高品质专修不再高不可攀。",@"荣装网，作为传统家装的改革者和革命者，以新型互联网家装公司的理念，成长迅猛，获得了众多用户的青睐，现已成立杭州、丽水、 温州、宁波等分公司，并将继续拓展全国市场，造福更多百姓，真正开启快乐装修之旅。", nil];
    
    
    [self allocTableviewWith:UITableViewStylePlain];
    self.dataTableview.delegate = self;
    self.dataTableview.dataSource = self;
    self.dataTableview.tableFooterView = self.footView;
    self.dataTableview.tableHeaderView = self.headerView;
    
    [self.dataTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(kNavBarAndStatusBarHeight);
    }];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.titleArry.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"cell";
    
    DFUsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (!cell) {
        cell = [[DFUsTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid];
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.contentText = self.titleArry[indexPath.section];

    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return self.secondView;
    }
    else if (section == 2)
    {
        return self.threeView;
    }
    else if (section == 3)
    {
        return self.fourView;
    }
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [(NSString *)self.titleArry[indexPath.section] heightForFont:HScaleFont(12) width:ScreenW - HScaleWidth(40)] + HScaleHeight(40);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return HScaleHeight(0.1);
    }
    return HScaleHeight(57);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (UIView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, HScaleHeight(116))];
        _headerView.backgroundColor = [UIColor colorWithHexString:@"F7F7F7"];
        
        
        
        UIImageView *titleImage = [[UIImageView alloc]init];
        
        [_headerView addSubview:titleImage];
        [titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(151.5), HScaleHeight(51)));
            make.centerX.mas_equalTo(_headerView.mas_centerX);
            make.centerY.mas_equalTo(_headerView.mas_centerY);
        }];
    }
    return _headerView;
}

- (DFMainSeconView *)secondView
{
    if (!_secondView) {
        _secondView = [[DFMainSeconView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, HScaleHeight(57))];
        _secondView.titleText = @"荣装·互联网家装优势";
    }
    return _secondView;
}

- (DFMainSeconView *)threeView
{
    if (!_threeView) {
        _threeView = [[DFMainSeconView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, HScaleHeight(57))];
        _threeView.titleText = @"荣装·互联网私人定制";
    }
    return _threeView;
}

- (DFMainSeconView *)fourView
{
    if (!_fourView) {
        _fourView = [[DFMainSeconView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, HScaleHeight(57))];
        _fourView.titleText = @"用心缔造 悉心告知";
    }
    return _fourView;
}

- (UIView *)footView
{
    if (!_footView) {
        _footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, HScaleHeight(116))];
        _footView.backgroundColor = [UIColor colorWithHexString:@"F7F7F7"];
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.text = @"©2016-2020 浙江联合创展科技股份有限公司 版权所有";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = HScaleFont(12);
        titleLabel.textColor = [UIColor colorWithHexString:@"999999"];
        titleLabel.numberOfLines = 0;
        [_footView addSubview:titleLabel];
        
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);;
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
