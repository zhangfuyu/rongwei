//
//  DFContructionDetailView.m
//  rongwei
//
//  Created by apple on 2019/11/22.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFContructionDetailView.h"

@interface DFContructionDetailView ()
@property (nonatomic , strong) UIImageView *imageview;

@property (nonatomic , strong) UILabel *titlelabel;

@property (nonatomic , strong) UILabel *sublabel;

@property (nonatomic , strong) UIImageView *lefrimageview;

@property (nonatomic , strong) UILabel *addresslabel;

@property (nonatomic , strong) UIButton *messgaeBtn;


@property (nonatomic , strong) UIButton *cllphoneBtn;
@property (nonatomic , strong) UIButton *likeThisBtn;


@end

@implementation DFContructionDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.imageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(10));
            make.top.mas_equalTo(HScaleHeight(17.5));
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(60), HScaleHeight(60)));
        }];
        
        [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.imageview.mas_right).offset(14);
            make.top.mas_equalTo(self.imageview.mas_top);
            make.right.mas_equalTo(-HScaleWidth(90));
        }];
        
        [self.sublabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titlelabel.mas_left);
            make.top.mas_equalTo(self.titlelabel.mas_bottom).offset(HScaleHeight(14.5));
            make.right.mas_equalTo(self.titlelabel.mas_right);
        }];
        
        UIView *linview = [[UIView alloc]init];
        linview.backgroundColor = [UIColor colorWithHexString:@"E6E5E6"];
        [self addSubview:linview];
        
        [linview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.imageview.mas_bottom).offset(HScaleHeight(15));
            make.height.mas_equalTo(HScaleHeight(.5));
        }];
        
        [self.lefrimageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(10));
            make.top.mas_equalTo(linview.mas_bottom).offset(HScaleHeight(12.5));
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(9), HScaleHeight(11)));
        }];
        
        [self.addresslabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.lefrimageview.mas_right).offset(HScaleWidth(.5));
            make.centerY.mas_equalTo(self.lefrimageview.mas_centerY);
            make.right.mas_equalTo(-HScaleWidth(50));
        }];
        
        [self.cllphoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-HScaleWidth(10));
            make.centerY.mas_equalTo(self.lefrimageview.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(20), HScaleHeight(35)));
        }];
        [self.messgaeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.cllphoneBtn.mas_left);
            make.centerY.mas_equalTo(self.lefrimageview.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(20), HScaleHeight(35)));
        }];
        
        UIView *boomview = [[UIView alloc]init];
        boomview.backgroundColor = [UIColor colorWithHexString:@"F7F7F7"];
        [self addSubview:boomview];
        [boomview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(HScaleHeight(5));
        }];
        
        [self.likeThisBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-HScaleWidth(10));
            make.top.mas_equalTo(HScaleHeight(42.5));
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(72), HScaleHeight(25)));
        }];
    }
    return self;
}

- (void)setModel:(DFCompanyModel *)model
{
    _model = model;
    [self.imageview sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"头像_男孩"]];
    self.titlelabel.text = model.name;
    self.sublabel.text = model.brief;
    self.addresslabel.text = model.address;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (UIImageView *)imageview
{
    if (!_imageview) {
        _imageview = [[UIImageView alloc]init];
//        _imageview.layer.cornerRadius = HScaleWidth(5);
        _imageview.layer.masksToBounds = YES;
        [self addSubview:_imageview];
    }
    return _imageview;
}

- (UILabel *)titlelabel
{
    if (!_titlelabel) {
        _titlelabel = [[UILabel alloc]init];
        _titlelabel.font = HScaleFont(15);
        _titlelabel.textColor = [UIColor colorWithHexString:@"333333"];
        [self addSubview:_titlelabel];
    }
    return _titlelabel;
}
- (UILabel *)sublabel
{
    if (!_sublabel) {
        _sublabel = [[UILabel alloc]init];
        _sublabel.font = HScaleFont(12);
        _sublabel.textColor = [UIColor colorWithHexString:@"C82126"];
        [self addSubview:_sublabel];
    }
    return _sublabel;
}
- (UIImageView *)lefrimageview
{
    if (!_lefrimageview) {
        _lefrimageview = [[UIImageView alloc]init];
        _lefrimageview.image = [UIImage imageNamed:@"位置_left"];
        [self addSubview:_lefrimageview];
    }
    return _lefrimageview;
}

- (UILabel *)addresslabel
{
    if (!_addresslabel) {
        _addresslabel = [[UILabel alloc]init];
        _addresslabel.font = HScaleFont(12);
        _addresslabel.textColor = [UIColor colorWithHexString:@"333333"];
        [self addSubview:_addresslabel];
    }
    return _addresslabel;
}

- (UIButton *)messgaeBtn
{
    if (!_messgaeBtn) {
        _messgaeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_messgaeBtn setImage:[UIImage imageNamed:@"dialogue"] forState:UIControlStateNormal];
        [self addSubview:_messgaeBtn];
    }
    return _messgaeBtn;
}

- (UIButton *)cllphoneBtn
{
    if (!_cllphoneBtn) {
        _cllphoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cllphoneBtn setImage:[UIImage imageNamed:@"dianhua"] forState:UIControlStateNormal];
        [self addSubview:_cllphoneBtn];
    }
    return _cllphoneBtn;
}
- (UIButton *)likeThisBtn
{
    if (!_likeThisBtn) {
        _likeThisBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _likeThisBtn.layer.borderWidth = 1;
        _likeThisBtn.layer.borderColor = [UIColor colorWithHexString:@"DD1A21"].CGColor;
        [_likeThisBtn setTitleColor:[UIColor colorWithHexString:@"DD1A21"] forState:UIControlStateNormal];
        
        _likeThisBtn.titleLabel.font = HScaleFont(12);
        [_likeThisBtn setTitleColor:[UIColor colorWithHexString:@"DD1A21"] forState:UIControlStateNormal];
        [_likeThisBtn setTitle:@"  关注" forState:UIControlStateNormal];
        [_likeThisBtn setImage:[UIImage imageNamed:@"star-n"] forState:UIControlStateNormal];
//        [_likeThisBtn setImage:[UIImage imageNamed:@"Focus_on"] forState:UIControlStateSelected];
//        [_likeThisBtn addTarget:self action:@selector(focusonThis) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_likeThisBtn];
        
    }
    return _likeThisBtn;
}
@end
