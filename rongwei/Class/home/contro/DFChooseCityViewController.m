//
//  DFChooseCityViewController.m
//  rongwei
//
//  Created by zhangfuyu on 2019/12/29.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFChooseCityViewController.h"
#import <CoreLocation/CoreLocation.h>//引入Corelocation框架
#import "DFSaveDataTool.h"
#import "DFCityModel.h"
#import "DFXiaoGuoStyleCell.h"


@interface DFChooseCityViewController ()<CLLocationManagerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic , strong)UIButton *positioningBtn;
@property (nonatomic , strong) CLLocationManager *locationManager;//设置manager

@property (nonatomic , strong)NSMutableArray *cityArry;
@property (nonatomic , strong)UICollectionView *scrollView;

@property (nonatomic , strong)DFCityModel *positioningModel;

@property (nonatomic , strong)NSDictionary *choosCityDic;

@property (nonatomic , strong)NSIndexPath *selecIndex;

@property (nonatomic , assign)BOOL isSelect;

@property (nonatomic , strong)NSString *city;

@property (nonatomic , strong)NSString *province;


@end

@implementation DFChooseCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.cityArry = [NSMutableArray arrayWithCapacity:0];
    
    self.view.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];

    
    
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
    [self.view addSubview:backView];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(HScaleHeight(145));
    }];
    
    self.positioningBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.positioningBtn setTitleColor:UIColorHex(0x010101) forState:UIControlStateNormal];
    self.positioningBtn.titleLabel.font = HScaleFont(12);
    [self.positioningBtn setBackgroundColor:[UIColor colorWithHexString:@"F1F3F6"]];
    [self.positioningBtn setTitle:@"丽水" forState:UIControlStateNormal];

    [self.positioningBtn setTitleColor:[UIColor colorWithHexString:@"DD1A21"] forState:UIControlStateNormal];
    self.positioningBtn.layer.cornerRadius = HScaleWidth(2.5);
//    [self.positioningBtn setImage:[UIImage imageNamed:@"no_Focus_on"] forState:UIControlStateNormal];
    [backView addSubview:self.positioningBtn];
    
    [self.positioningBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(HScaleHeight(4.5));
        make.left.mas_equalTo(HScaleWidth(15));;
        make.size.mas_equalTo(CGSizeMake(HScaleWidth(81), HScaleHeight(25)));
    }];
    
    
    UIButton *changeCiry = [UIButton buttonWithType:UIButtonTypeCustom];
    [changeCiry setTitleColor:UIColorHex(0x010101) forState:UIControlStateNormal];
    [changeCiry setTitle:@"切换城市" forState:UIControlStateNormal];
    changeCiry.titleLabel.font = HScaleFont(12);
    [changeCiry setBackgroundColor:[UIColor colorWithHexString:@"DD1A21"]];
    [changeCiry setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:UIControlStateNormal];
    changeCiry.layer.cornerRadius = HScaleWidth(2.5);
    [backView addSubview:changeCiry];
    
    [changeCiry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-HScaleWidth(13.5));
        make.top.mas_equalTo(HScaleHeight(4.5));
        make.size.mas_equalTo(CGSizeMake(HScaleWidth(67.5), HScaleHeight(25)));
    }];
    
    UIButton *addtrssAgain = [UIButton buttonWithType:UIButtonTypeCustom];
    [addtrssAgain setTitle:@"重新定位" forState:UIControlStateNormal];
    [addtrssAgain setTitleColor:UIColorHex(0x010101) forState:UIControlStateNormal];
    addtrssAgain.titleLabel.font = HScaleFont(12);
    [addtrssAgain setBackgroundColor:[UIColor colorWithHexString:@"F1F3F6"]];
    [addtrssAgain setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
    addtrssAgain.layer.cornerRadius = HScaleWidth(2.5);
    [backView addSubview:addtrssAgain];
    
    [addtrssAgain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(changeCiry.mas_left).offset(-HScaleWidth(10));
        make.top.mas_equalTo(HScaleHeight(4.5));
        make.size.mas_equalTo(CGSizeMake(HScaleWidth(81), HScaleHeight(25)));
    }];
    
    
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    [backView addSubview:label];

    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"    下属区县市" attributes:@{NSFontAttributeName: HScaleFont(12),NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]}];

    label.attributedText = string;
    
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(self.positioningBtn.mas_bottom).offset(HScaleHeight(12));
    }];
    
    
    
    

//    [self getiCityArry];
    
     // 创建布局
    //1.创建流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;


     // 创建collectionView
     self.scrollView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
     self.scrollView.backgroundColor = [UIColor whiteColor];
     self.scrollView.delegate = self;
     self.scrollView.dataSource = self;
     self.scrollView.showsVerticalScrollIndicator = NO;
     self.scrollView.alwaysBounceVertical = YES;
//     self.scrollView.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];


    [self.scrollView registerClass:[DFXiaoGuoStyleCell class] forCellWithReuseIdentifier:@"DFXiaoGuoStyleCell"];

    [backView addSubview:self.scrollView];

    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(label.mas_bottom);
    }];


    
    [self locate];

    
}


- (void)getiCityArry
{
    
    
    [self.cityArry removeAllObjects];
    
    NSDictionary *citydic = [[DFSaveDataTool shareInstance] getCountryData];
    NSArray *allkey = citydic.allKeys;

    NSMutableArray *provinceArry = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger index = 0; index < allkey.count; index ++) {
        NSString *indexKey = allkey[index];
        NSDictionary *keyData = citydic[indexKey];
        DFCityModel *provinceModel = [[DFCityModel alloc]initWithDictionary:keyData error:nil];
        [provinceArry addObject:provinceModel];
    };
    
    
    for (DFCityModel *model in provinceArry) {
        if ([model.name isEqualToString:self.province]) {
            self.positioningModel = model;
            break;
        }
    }
    
    for (NSInteger index = 0; index < self.positioningModel.city.allKeys.count; index ++) {
        NSDictionary *cityDic = [self.positioningModel.city objectForKey:self.positioningModel.city.allKeys[index]];
        if ([(NSString *)cityDic[@"name"] containsString:self.city]) {
            self.choosCityDic = cityDic;
            NSDictionary *region = cityDic[@"region"];
            for (NSInteger index_j = 0; index_j < region.allKeys.count; index_j ++) {
                NSDictionary *regionDic = region[region.allKeys[index_j]];
                DFCityModel *provinceModel = [[DFCityModel alloc]initWithDictionary:regionDic error:nil];
                [self.cityArry addObject:provinceModel];
                
            }
            
            DFCityModel *allModel = [[DFCityModel alloc]init];
            allModel.name = @"全部";
            
            [self.cityArry insertObject:allModel atIndex:0];
            break;
        }
        
    }
    
    
    [self.scrollView reloadData];
}

- (void)locate {
    if ([CLLocationManager locationServicesEnabled]) {//监测权限设置
        self.locationManager = [[CLLocationManager alloc]init];
        self.locationManager.delegate = self;//设置代理
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;//设置精度
        self.locationManager.distanceFilter = 1000.0f;//距离过滤
        [self.locationManager requestAlwaysAuthorization];//位置权限申请
        [self.locationManager startUpdatingLocation];//开始定位
    }
}
#pragma mark location代理
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您还未开启定位服务，是否需要开启？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *queren = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *setingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication]openURL:setingsURL];
    }];
    [alert addAction:cancel];
    [alert addAction:queren];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [self.locationManager stopUpdatingLocation];//停止定位
//地理反编码
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
//当系统设置为其他语言时，可利用此方法获得中文地理名称
    NSMutableArray
    *userDefaultLanguages = [[NSUserDefaults standardUserDefaults]objectForKey:@"AppleLanguages"];
    // 强制 成 简体中文
    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:@"zh-hans", nil]forKey:@"AppleLanguages"];
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            self.city = placeMark.locality;
            self.province = placeMark.administrativeArea;
            if (!self.city) {
                NSLog(@"⟳定位获取失败,点击重试");
            } else {
                [self.positioningBtn setTitle:self.city forState:UIControlStateNormal];
                [self getiCityArry];
            }

        } else if (error == nil && placemarks.count == 0 ) {
        } else if (error) {
            NSLog(@"⟳定位获取失败,点击重试");

        }
        // 还原Device 的语言
        [[NSUserDefaults
          standardUserDefaults] setObject:userDefaultLanguages
         forKey:@"AppleLanguages"];
    }];
}
#pragma mark - 代理方法 Delegate Methods
// 设置分区

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

// 每个分区上得元素个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.cityArry.count;
}

// 设置cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    DFXiaoGuoStyleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DFXiaoGuoStyleCell" forIndexPath:indexPath];
    DFCityModel *model = self.cityArry[indexPath.row];
    cell.titeleTextk = model.name;

    if (self.isSelect) {
        if (self.selecIndex.row == indexPath.row) {
            cell.isSelect = YES;
        }
        else
        {
            cell.isSelect = NO;
        }
    }
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.isSelect = YES;
    self.selecIndex = indexPath;
    [collectionView reloadData];
    
    self.view.hidden = YES;
    DFCityModel *model = self.cityArry[indexPath.row];


    if (self.delegate && [self.delegate respondsToSelector:@selector(selectChooseprovinceId:city_id:area_id:)]) {
        
        [self.delegate selectChooseprovinceId:self.positioningModel.modelid city_id:self.choosCityDic[@"id"] area_id:model.modelid];
    }
}
// 设置cell大小 itemSize：可以给每一个cell指定不同的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    CGFloat height = 35.0f;
//    CGFloat width = [self gainStringWidthWithString:self.nameArray[indexPath.row] font:15.0f height:height];
    return CGSizeMake((ScreenW - HScaleWidth(60)) / 4, HScaleHeight(25));
}


// 设置UIcollectionView整体的内边距（这样item不贴边显示）
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {

    if (section % 4 > 0) {

        return UIEdgeInsetsMake(0, 0, 0, HScaleWidth(10));

    }
    else
    {
        return UIEdgeInsetsMake(0, 10, 0,HScaleWidth(10));

    }
    // 上 左 下 右
}

// 设置minimumLineSpacing：cell上下之间最小的距离
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return HScaleHeight(10);
}

// 设置minimumInteritemSpacing：cell左右之间最小的距离
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return HScaleHeight(10);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (touch.view == self.view) {
        self.view.hidden = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectChooseprovinceId:city_id:area_id:)]) {
        [self.delegate selectChooseprovinceId:@"" city_id:@"" area_id:@""];
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
