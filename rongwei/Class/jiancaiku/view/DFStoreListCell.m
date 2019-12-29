//
//  DFStoreListCell.m
//  rongwei
//
//  Created by zhangfuyu on 2019/12/12.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFStoreListCell.h"
#import "DFStoreDetailViewController.h"

@interface DFStoreListCell ()

@property (nonatomic , strong)UIImageView *iconimageview;

@property (nonatomic , strong)UILabel *storeName;

@property (nonatomic , strong)UILabel *businessLabel;

@property (nonatomic , strong)UIView *lineview;

@property (nonatomic , strong)UIButton *intoTheShop;

@property (nonatomic , strong)UIImageView *goodsimageview_1;

@property (nonatomic , strong)UIImageView *goodsimageview_2;

@property (nonatomic , strong)UIImageView *goodsimageview_3;


@end

@implementation DFStoreListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.iconimageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(HScaleHeight(16));
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(49), HScaleHeight(49)));
        }];
        
        
        [self.storeName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconimageview.mas_right).offset(HScaleWidth(15.5));
            make.top.mas_equalTo(self.iconimageview.mas_top);
            make.right.mas_equalTo(-HScaleWidth(20));
        }];
        
        [self.businessLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.storeName.mas_left);
            make.bottom.mas_equalTo(self.iconimageview.mas_bottom).offset(-HScaleHeight(8.5));
            make.right.mas_equalTo(-HScaleWidth(96));
            
                            
        }];
        [self.lineview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.offset(0);
            make.height.mas_equalTo(HScaleHeight(.5));
        }];
        
        [self.intoTheShop mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-HScaleWidth(14));
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(72), HScaleHeight(25)));
            make.top.mas_equalTo(HScaleHeight(38));
        }];
        
//        [self.goodsimageview_1 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(HScaleWidth(5));
//            make.top.mas_equalTo(self.iconimageview.mas_bottom).offset(HScaleHeight(10.5));
//            make.size.mas_equalTo(CGSizeMake(HScaleWidth(115), HScaleHeight(56.5)));
//        }];
//        
//        [self.goodsimageview_2 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(self.goodsimageview_1.mas_right).offset(HScaleWidth(5));
//            make.top.mas_equalTo(self.iconimageview.mas_bottom).offset(HScaleHeight(10.5));
//            make.size.mas_equalTo(CGSizeMake(HScaleWidth(115), HScaleHeight(56.5)));
//        }];
//        
//        [self.goodsimageview_3 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(self.goodsimageview_2.mas_right).offset(HScaleWidth(5));
//            make.top.mas_equalTo(self.iconimageview.mas_bottom).offset(HScaleHeight(10.5));
//            make.size.mas_equalTo(CGSizeMake(HScaleWidth(115), HScaleHeight(56.5)));
//        }];
    }
    return self;
}
- (void)setModel:(DFStoreModel *)model
{
    _model = model;
    [self.iconimageview sd_setImageWithURL:[NSURL URLWithString:model.logo_image] placeholderImage:nil];
    self.storeName.text = model.shop_name;
    self.businessLabel.text = [NSString stringWithFormat:@"主营业务  %@",model.shop_category];
//    if (model.carousel_image.count == 0) {
//        self.goodsimageview_1.hidden = YES;
//        self.goodsimageview_2.hidden = YES;
//        self.goodsimageview_3.hidden = YES;
//    }
//    else
//    {
//        if (model.carousel_image.count == 1) {
//            [self.goodsimageview_1 sd_setImageWithURL:[NSURL URLWithString:model.carousel_image[0]] placeholderImage:nil];
//            self.goodsimageview_2.hidden = NO;
//
//            self.goodsimageview_2.hidden = YES;
//            self.goodsimageview_3.hidden = YES;
//
//        }
//        else if (model.carousel_image.count == 2)
//        {
//            [self.goodsimageview_1 sd_setImageWithURL:[NSURL URLWithString:model.carousel_image[0]] placeholderImage:nil];
//            [self.goodsimageview_2 sd_setImageWithURL:[NSURL URLWithString:model.carousel_image[1]] placeholderImage:nil];
//            self.goodsimageview_2.hidden = NO;
//            self.goodsimageview_1.hidden = NO;
//
//            self.goodsimageview_3.hidden = YES;
//        }
//        else if (model.carousel_image.count == 3)
//        {
//            [self.goodsimageview_1 sd_setImageWithURL:[NSURL URLWithString:model.carousel_image[0]] placeholderImage:nil];
//            [self.goodsimageview_2 sd_setImageWithURL:[NSURL URLWithString:model.carousel_image[1]] placeholderImage:nil];
//            [self.goodsimageview_3 sd_setImageWithURL:[NSURL URLWithString:model.carousel_image[2]] placeholderImage:nil];
//
//            self.goodsimageview_1.hidden = NO;
//            self.goodsimageview_2.hidden = NO;
//            self.goodsimageview_2.hidden = NO;
//
//        }
//    }
}

- (void)clickIntoTheShop
{
    DFStoreDetailViewController *store = [[DFStoreDetailViewController alloc]init];
    store.store_id = self.model.shop_id;
    [self.viewController.navigationController pushViewController:store animated:YES];
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIImageView *)iconimageview
{
    if (!_iconimageview) {
        _iconimageview = [[UIImageView alloc]init];
        [self.contentView addSubview:_iconimageview];
    }
    return _iconimageview;
}

- (UIImageView *)goodsimageview_1
{
    if (!_goodsimageview_1) {
        _goodsimageview_1 = [[UIImageView alloc]init];
        [self.contentView addSubview:_goodsimageview_1];
    }
    return _goodsimageview_1;
}
- (UIImageView *)goodsimageview_2
{
    if (!_goodsimageview_2) {
        _goodsimageview_2 = [[UIImageView alloc]init];
        [self.contentView addSubview:_goodsimageview_2];
    }
    return _goodsimageview_2;
}
- (UIImageView *)goodsimageview_3
{
    if (!_goodsimageview_3) {
        _goodsimageview_3 = [[UIImageView alloc]init];
        [self.contentView addSubview:_goodsimageview_3];
    }
    return _goodsimageview_3;
}
- (UILabel *)storeName
{
    if (!_storeName) {
        _storeName = [[UILabel alloc]init];
        _storeName.font = HScaleFont(15);
        _storeName.textColor = [UIColor colorWithHexString:@"333333"];
        [self.contentView addSubview:_storeName];
    }
    return _storeName;
}

- (UILabel *)businessLabel
{
    if (!_businessLabel) {
        _businessLabel = [[UILabel alloc]init];
        _businessLabel.font = HScaleFont(12);
        _businessLabel.textColor = [UIColor colorWithHexString:@"999999"];
        [self.contentView addSubview:_businessLabel];
    }
    return _businessLabel;
}
- (UIView *)lineview
{
    if (!_lineview) {
        _lineview = [[UIView alloc]init];
        _lineview.backgroundColor = [UIColor colorWithHexString:@"#E1E1E1"];
        [self.contentView addSubview:_lineview];
    }
    return _lineview;
}
- (UIButton *)intoTheShop
{
    if (!_intoTheShop) {
        _intoTheShop = [UIButton buttonWithType:UIButtonTypeCustom];
        [_intoTheShop setTitle:@"进店" forState:UIControlStateNormal];
        [_intoTheShop setTitleColor:[UIColor colorWithHexString:@"DD1A21"] forState:UIControlStateNormal];
        _intoTheShop.titleLabel.font = HScaleFont(12);
        _intoTheShop.layer.borderWidth = HScaleWidth(.5);
        _intoTheShop.layer.cornerRadius = HScaleWidth(1);
        _intoTheShop.layer.borderColor = [UIColor colorWithHexString:@"DD1A21"].CGColor;
        [_intoTheShop addTarget:self action:@selector(clickIntoTheShop) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_intoTheShop];
    }
    return _intoTheShop;
}

@end
