//
//  DFConstructionHeaderView.m
//  rongwei
//
//  Created by zhangfuyu on 2019/12/18.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFConstructionHeaderView.h"
@interface DFConstructionHeaderView ()

@property (nonatomic , strong) UIImageView *loginImage;

@property (nonatomic , strong) UILabel *addressName;

@property (nonatomic , strong) UILabel *howBig;

@property (nonatomic , strong) UILabel *howMuch;

@property (nonatomic , strong) UILabel *howNumber;

@property (nonatomic , strong) UILabel *storeName;

@property (nonatomic , strong) UILabel *peopleName;

@end

@implementation DFConstructionHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self.loginImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.height.mas_equalTo(HScaleHeight(184.5));
        }];
        
        [self.addressName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(70.5);
        }];
        
        
        [self.storeName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(20));
            make.right.mas_equalTo(-HScaleWidth(20));
            make.top.mas_equalTo(self.loginImage.mas_bottom).offset(HScaleHeight(16.5));
        }];
        
        [self.peopleName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.storeName.mas_left);
            make.top.mas_equalTo(self.storeName.mas_bottom).offset(HScaleHeight(10));
            make.right.mas_equalTo(self.storeName.right);
        }];
        
        UIView *linview = [[UIView alloc]init];
        linview.backgroundColor = [UIColor colorWithHexString:@"F7F7F7"];
        [self addSubview:linview];
        
        [linview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(HScaleHeight(5));
        }];
        
    }
    return self;
}

- (void)setModel:(DFConstructionModel *)model
{
    _model = model;
    [self.loginImage sd_setImageWithURL:[NSURL URLWithString:model.thumb_img] placeholderImage:nil];
    self.addressName.text = model.title;
    self.howNumber.text = model.shape_name;
    CGFloat wanRmb = [model.zaojia floatValue] / 10000;
    
    self.howMuch.text = [NSString stringWithFormat:@"%.1f万",wanRmb];
    self.howBig.text = [NSString stringWithFormat:@"%@m²",model.mianji];
    
    CGFloat moneyWitd = [self.howMuch.text widthForFont:HScaleFont(12)];
    [self.howMuch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.addressName.mas_bottom).offset(HScaleHeight(14));
        make.width.mas_equalTo(moneyWitd +HScaleWidth(22));
        make.height.mas_equalTo(HScaleHeight(20.5));
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    
    
    CGFloat hownumberWitd = [self.howNumber.text widthForFont:HScaleFont(12)];
    [self.howNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.addressName.mas_bottom).offset(HScaleHeight(14));
        make.width.mas_equalTo(hownumberWitd +HScaleWidth(22));
        make.height.mas_equalTo(HScaleHeight(20.5));
        make.right.mas_equalTo(self.howMuch.mas_left).offset(-HScaleWidth(9.5));
    }];
    
    CGFloat howBigWitd = [self.howNumber.text widthForFont:HScaleFont(12)];
    [self.howBig mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.addressName.mas_bottom).offset(HScaleHeight(14));
        make.width.mas_equalTo(howBigWitd +HScaleWidth(22));
        make.height.mas_equalTo(HScaleHeight(20.5));
        make.left.mas_equalTo(self.howMuch.mas_right).offset(HScaleWidth(9.5));
    }];
    
    
    
    NSString *nameBig = [NSString stringWithFormat:@"施工公司:%@",model.company_name];
    
    NSMutableAttributedString *arrti = [[NSMutableAttributedString alloc]initWithString:nameBig];
    [arrti addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"333333"] range:NSMakeRange(0,5)];
    [arrti addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"DD1A21"] range:NSMakeRange(5,model.company_name.length)];
    
    self.storeName.attributedText = arrti;
    
    self.peopleName.text = [NSString stringWithFormat:@"施工负责人:%@",model.manager];
    
    
}

- (UIImageView *)loginImage
{
    if (!_loginImage) {
        _loginImage = [[UIImageView alloc]init];
        [self addSubview:_loginImage];
    }
    return _loginImage;
}

- (UILabel *)addressName
{
    if (!_addressName) {
        _addressName = [[UILabel alloc]init];
        _addressName.font = HScaleBoldFont(15);
        _addressName.textAlignment = NSTextAlignmentCenter;
        _addressName.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        [self addSubview:_addressName];
    }
    return _addressName;
}

- (UILabel *)howNumber
{
    if (!_howNumber) {
        _howNumber = [[UILabel alloc]init];
        _howNumber.font = HScaleFont(12);
        _howNumber.textAlignment = NSTextAlignmentCenter;
        _howNumber.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        _howNumber.backgroundColor = [[UIColor colorWithHexString:@"000000"] colorWithAlphaComponent:.3];
        [self addSubview:_howNumber];
    }
    return _howNumber;
}

- (UILabel *)howBig
{
    if (!_howBig) {
        _howBig = [[UILabel alloc]init];
        _howBig.font = HScaleFont(12);
        _howBig.textAlignment = NSTextAlignmentCenter;
        _howBig.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        _howBig.backgroundColor = [[UIColor colorWithHexString:@"000000"] colorWithAlphaComponent:.3];
        [self addSubview:_howBig];
    }
    return _howBig;
}

- (UILabel *)howMuch
{
    if (!_howMuch) {
        _howMuch = [[UILabel alloc]init];
        _howMuch.font = HScaleFont(12);
        _howMuch.textAlignment = NSTextAlignmentCenter;
        _howMuch.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        _howMuch.backgroundColor = [[UIColor colorWithHexString:@"000000"] colorWithAlphaComponent:.3];
        [self addSubview:_howMuch];
    }
    return _howMuch;
}

- (UILabel *)storeName
{
    if (!_storeName) {
        _storeName = [[UILabel alloc]init];
        _storeName.font = HScaleFont(12);
        _storeName.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        [self addSubview:_storeName];
    }
    return _storeName;
}

- (UILabel *)peopleName
{
    if (!_peopleName) {
        _peopleName = [[UILabel alloc]init];
        _peopleName.font = HScaleFont(12);
        _peopleName.textColor = [UIColor colorWithHexString:@"333333"];
        [self addSubview:_peopleName];
    }
    return _peopleName;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
