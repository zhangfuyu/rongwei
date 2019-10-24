//
//  DFXiaoGuoTuViewController.m
//  rongwei
//
//  Created by zhangfuyu on 2019/9/19.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFXiaoGuoTuViewController.h"
#import "DFRenderingNarbarView.h"
#import "CQTopBarSegment.h"
#import "DFWaterFallLayout.h"
#import "DFRenderingCollectionViewCell.h"

@interface DFXiaoGuoTuViewController ()<DFWaterFallLayoutDeleaget, UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic , strong)DFRenderingNarbarView *navview;
@property (nonatomic , strong)CQTopBarSegment *segment;

@property (nonatomic , strong)UICollectionView *scrollView;

@end

@implementation DFXiaoGuoTuViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"效果图";
    [self.navview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(kNavBarAndStatusBarHeight);
    }];
    
    [self.view addSubview:self.segment];
    
    // 创建布局
    DFWaterFallLayout * waterFallLayout = [[DFWaterFallLayout alloc]init];
    waterFallLayout.fallDelegate = self;
    //    waterFallLayout.headerReferenceSize = CGSizeMake(SCREENWIDTH, HScaleHeight(350));
    
    //    UICollectionViewFlowLayout *waterFallLayout = [[UICollectionViewFlowLayout alloc] init];
    
    //    waterFallLayout.headerReferenceSize = CGSizeMake(SCREENWIDTH, HScaleHeight(350));
    
    // 创建collectionView
    self.scrollView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kNavBarAndStatusBarHeight + HScaleHeight(47), ScreenW, ScreenH - kNavAndTabHeight - HScaleHeight(47)) collectionViewLayout:waterFallLayout];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.delegate = self;
    self.scrollView.dataSource = self;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
        
        
        
        [self.scrollView registerClass:[DFRenderingCollectionViewCell class] forCellWithReuseIdentifier:@"DFRenderingCollectionViewCell"];
        
        [self.view addSubview:self.scrollView];
    
}

#pragma mark  - <LMHWaterFallLayoutDeleaget>
- (CGFloat)waterFallLayout:(DFWaterFallLayout *)waterFallLayout heightForItemAtIndexPath:(NSUInteger)indexPath itemWidth:(CGFloat)itemWidth{
   
    
    return HScaleHeight(126);
}

- (CGFloat)rowMarginInWaterFallLayout:(DFWaterFallLayout *)waterFallLayout {
    
    return HScaleWidth(10);
    
}

- (CGFloat)columnMarginInWaterFallLayout:(DFWaterFallLayout *)waterFallLayout {
    
    return HScaleWidth(10);
    
}

- (NSUInteger)columnCountInWaterFallLayout:(DFWaterFallLayout *)waterFallLayout{
    
    return 2;
    
}
#pragma mark - UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 2;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DFRenderingCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DFRenderingCollectionViewCell" forIndexPath:indexPath];
    
   
    
    return cell;
    
}

- (DFRenderingNarbarView *)navview
{
    if (!_navview) {
        _navview = [[DFRenderingNarbarView alloc]init];
        [self.view addSubview:_navview];
    }
    return _navview;
}

- (CQTopBarSegment *)segment
{
    if (!_segment) {
        _segment = [[CQTopBarSegment alloc]initWithFrame:CGRectMake(0, kNavBarAndStatusBarHeight, ScreenW, HScaleHeight(47)) sectionTitles:@[@"风格",@"户型",@"预算"]];
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
