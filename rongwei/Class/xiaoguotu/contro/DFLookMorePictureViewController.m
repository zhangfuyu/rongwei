//
//  DFLookMorePictureViewController.m
//  rongwei
//
//  Created by zhangfuyu on 2019/12/17.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFLookMorePictureViewController.h"
#import "DFLookPictureCollectionViewCell.h"
#import "DFWorksDetailViewController.h"
#import "DFDesignerModel.h"
#import "DFEsignerDetialViewController.h"

@interface DFLookMorePictureViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic , strong) UICollectionView *collectionview;

@property (nonatomic , strong) UILabel *numberLabel;

@end

@implementation DFLookMorePictureViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.\
    
    if (self.model.modelid.length == 0) {
        
        NSString *requestURL = [NSString stringWithFormat:@"%@/%@",WorkDesignerDetailApi,self.workId];
         [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:requestURL withParameter:nil withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
                       
             if (isSuccess) {
                 self.model = [[DFDesignerWorkModel alloc]initWithDictionary:response[@"data"] error:nil];
             }
             
             [self creatui];
                         
                    
         }];
        
    }
    else
    {
        [self creatui];

    }
    
    

}
- (void)creatui
{
    [self.collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(0);
    }];
    
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, 44, 44)];
    backBtn.showsTouchWhenHighlighted = NO;
    [backBtn setImage:[UIImage imageNamed:@"login_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickCancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-HScaleWidth(14));
        make.bottom.mas_equalTo(-HScaleHeight(178) - kBottomSafeHeight);
        
    }];
    
    UILabel *titlelabel = [[UILabel alloc]init];
    titlelabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
    titlelabel.font = HScaleFont(15);
    titlelabel.text = [NSString stringWithFormat:@"%@|%@|%@m²|%.1f万",self.model.style[@"name"],self.model.shape[@"name"],self.model.mianji,[self.model.zaojia floatValue] / 10000];
    [self.view addSubview:titlelabel];
    
    [titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HScaleWidth(18));
        make.bottom.mas_equalTo(-HScaleHeight(176.5) - kBottomSafeHeight);
        make.right.mas_equalTo(self.numberLabel.mas_left).offset(-HScaleWidth(20));
    }];
    
    UILabel *name = [[UILabel alloc]init];
    name.textColor = [UIColor colorWithHexString:@"FFFFFF"];
    name.font = HScaleFont(15);
    name.text = self.model.designer_name;
    [self.view addSubview:name];
    
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titlelabel.mas_left);
        make.top.mas_equalTo(titlelabel.mas_bottom).offset(HScaleHeight(15));
        make.right.mas_equalTo(self.numberLabel.mas_left).offset(-HScaleWidth(20));

    }];
    
    
    UILabel *frome = [[UILabel alloc]init];
    frome.textColor = [UIColor colorWithHexString:@"FFFFFF"];
    frome.text = [NSString stringWithFormat:@"来自案例:%@",self.model.title];
    frome.font = HScaleFont(12);
    [self.view addSubview:frome];
    
    [frome mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(name.mas_bottom).offset(HScaleHeight(13.5));

        make.left.mas_equalTo(titlelabel.mas_left);

    }];
    
    
    UIButton *understand = [UIButton buttonWithType:UIButtonTypeCustom];
    [understand setTitle:@"了解更多" forState:UIControlStateNormal];
    [understand setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:UIControlStateNormal];
    understand.titleLabel.font = HScaleFont(15);
    [understand addTarget:self action:@selector(lookDetail) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:understand];
    
    [understand mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(-kBottomSafeHeight);
        make.size.mas_equalTo(CGSizeMake(HScaleWidth(90), HScaleHeight(38.5)));
    }];
    
    
    UIButton *foundHe = [UIButton buttonWithType:UIButtonTypeCustom];
    [foundHe setTitle:@"找TA设计" forState:UIControlStateNormal];
    [foundHe setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:UIControlStateNormal];
    foundHe.titleLabel.font = HScaleFont(15);
    foundHe.layer.borderWidth = .5;
    foundHe.layer.cornerRadius = .5;
    foundHe.layer.borderColor = [UIColor colorWithHexString:@"EEEEEE"].CGColor;
    [foundHe addTarget:self action:@selector(lookautherDetail) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:foundHe];
    
    [foundHe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-HScaleWidth(9.5));
        make.bottom.mas_equalTo(- kBottomSafeHeight - HScaleHeight(10.5));
        make.size.mas_equalTo(CGSizeMake(HScaleWidth(88), HScaleHeight(28)));
    }];
    
    
    UIButton *collection = [UIButton buttonWithType:UIButtonTypeCustom];
    [collection setTitle:@"收藏" forState:UIControlStateNormal];
    [collection setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:UIControlStateNormal];
    collection.titleLabel.font = HScaleFont(15);
    collection.layer.borderWidth = .5;
    collection.layer.cornerRadius = .5;
    collection.layer.borderColor = [UIColor colorWithHexString:@"EEEEEE"].CGColor;
    [self.view addSubview:collection];
    
    [collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(foundHe.mas_top);
        make.bottom.mas_equalTo(foundHe.mas_bottom);
        make.right.mas_equalTo(foundHe.mas_left).offset(-HScaleWidth(10));
        make.size.mas_equalTo(CGSizeMake(HScaleWidth(51), HScaleHeight(28)));
    }];
}
- (void)clickCancelAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)lookDetail
{
    DFWorksDetailViewController *worksdetail = [[DFWorksDetailViewController alloc]init];
    worksdetail.worksId = self.model.modelid;
    worksdetail.autherID = self.model.designer_id;
    [self.navigationController pushViewController:worksdetail animated:YES];
}
- (void)lookautherDetail
{
    DFDesignerModel *autherModel = [[DFDesignerModel alloc]init];
    autherModel.modelId = self.model.designer_id;
    autherModel.name = self.model.designer_name;
    
    DFEsignerDetialViewController *autherDetail = [[DFEsignerDetialViewController alloc]init];
    autherDetail.model = autherModel;
    [self.navigationController pushViewController:autherDetail animated:YES];
    
}
#pragma mark - 代理方法 Delegate Methods
// 设置分区

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

// 每个分区上得元素个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.model.work_images.count;
}

// 设置cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    DFLookPictureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DFLookPictureCollectionViewCell class]) forIndexPath:indexPath];
//    [cell refreshCellWithTitle:self.nameArray[indexPath.row]];
    cell.imageStr = self.model.work_images[indexPath.row];
    return cell;
}

// 设置cell大小 itemSize：可以给每一个cell指定不同的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    CGFloat height = 35.0f;
//    CGFloat width = [self gainStringWidthWithString:self.nameArray[indexPath.row] font:15.0f height:height];
    return CGSizeMake(ScreenW, ScreenH);
}


// 设置UIcollectionView整体的内边距（这样item不贴边显示）
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    // 上 左 下 右
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

// 设置minimumLineSpacing：cell上下之间最小的距离
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return HScaleHeight(0);
}

// 设置minimumInteritemSpacing：cell左右之间最小的距离
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return HScaleHeight(0);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat contentwidth = scrollView.contentOffset.x;
    NSInteger nowPage = contentwidth / ScreenW;
    self.numberLabel.text = [NSString stringWithFormat:@"%ld/%ld",nowPage + 1,self.model.work_images.count];
}
- (UICollectionView *)collectionview
{
    if (!_collectionview) {
        
        // 1.创建流水布局
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(HScaleWidth(10), HScaleHeight(0), ScreenW - HScaleWidth(20), HScaleHeight(140))collectionViewLayout:layout];
        [_collectionview registerClass:[DFLookPictureCollectionViewCell class] forCellWithReuseIdentifier:@"DFLookPictureCollectionViewCell"];
            /// 设置此属性为yes 不满一屏幕 也能滚动
        _collectionview.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
        _collectionview.alwaysBounceHorizontal = YES;
        _collectionview.showsHorizontalScrollIndicator = NO;
        _collectionview.delegate = self;
        _collectionview.dataSource = self;
        _collectionview.pagingEnabled  = YES;
        _collectionview.backgroundView.backgroundColor = [UIColor blackColor];
        _collectionview.backgroundColor = [UIColor blackColor];
        [self.view addSubview:_collectionview];
   
    }
    return _collectionview;
 
}

- (UILabel *)numberLabel
{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]init];
        _numberLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        _numberLabel.font = HScaleFont(15);
        _numberLabel.text = [NSString stringWithFormat:@"1/%ld",self.model.work_images.count];
        _numberLabel.textAlignment = NSTextAlignmentRight;
        [self.view addSubview:_numberLabel];
    }
    return _numberLabel;
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
