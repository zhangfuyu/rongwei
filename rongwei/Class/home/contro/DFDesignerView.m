//
//  DFDesignerView.m
//  rongwei
//
//  Created by apple on 2019/9/26.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFDesignerView.h"

@interface DFDesignerView ()

@property (nonatomic , strong) UIImageView *headeriamge;

@property (nonatomic , strong) UILabel *nameLabel;

@property (nonatomic , strong) UILabel *workYearLabel;

@property (nonatomic , strong) UILabel *goodAtLabel;

@property (nonatomic , strong) UILabel *moneyLabel;

@property (nonatomic , strong) UIButton *appointmentBtn;

@property (nonatomic , strong) UIView *secondView;

@property (nonatomic , strong) UILabel *signbillLabel;

@property (nonatomic , strong) UILabel *appointmentLabel;

@property (nonatomic , strong) UILabel *browseLabel;//浏览

@property (nonatomic , strong) UILabel *signbillsubLabel;

@property (nonatomic , strong) UILabel *appointmentsubLabel;

@property (nonatomic , strong) UILabel *browsesubLabel;//浏览
@end

@implementation DFDesignerView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
        
        [self.headeriamge mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(10));
            make.top.mas_equalTo(HScaleHeight(18));
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(75), HScaleHeight(75)));
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.headeriamge.mas_right).offset(HScaleWidth(15));
            make.top.mas_equalTo(self.headeriamge.mas_top);
            make.height.mas_equalTo(HScaleHeight(15));
        }];
        
        [self.workYearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.nameLabel.mas_top);
            make.bottom.mas_equalTo(self.nameLabel.mas_bottom);
            make.left.mas_equalTo(self.nameLabel.mas_right).offset(HScaleWidth(13));
            make.width.mas_equalTo(HScaleWidth(55));
        }];
        
        [self.goodAtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nameLabel.mas_left);
            make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(HScaleHeight(9));
            make.right.mas_equalTo(-HScaleWidth(90));
        }];
        
        [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nameLabel.mas_left);
            make.bottom.mas_equalTo(self.headeriamge.mas_bottom);
            make.height.mas_equalTo(HScaleHeight(15));
        }];
        
        
        [self.appointmentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(HScaleHeight(43));
            make.right.mas_equalTo(-HScaleWidth(10));
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(72), HScaleHeight(25)));
        }];
        
        [self.secondView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.headeriamge.mas_left);
            make.top.mas_equalTo(self.headeriamge.mas_bottom).offset(HScaleHeight(15));
            make.right.mas_equalTo(self.mas_right).offset(-HScaleWidth(10));
            make.height.mas_equalTo(HScaleHeight(70));
        }];
        
        [self.signbillLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(HScaleHeight(18));
            make.width.mas_equalTo((ScreenW - (2 * HScaleWidth(10))) / 3);
            make.height.mas_equalTo(HScaleHeight(18));
        }];
        
        [self.signbillsubLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.signbillLabel.mas_left);
            make.right.mas_equalTo(self.signbillLabel.mas_right);
            make.top.mas_equalTo(self.signbillLabel.mas_bottom).offset(HScaleHeight(11));
            make.height.mas_equalTo(HScaleHeight(10));
        }];
        
        [self.browseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.signbillLabel.mas_right);
            make.top.mas_equalTo(self.signbillLabel.mas_top);
            make.width.mas_equalTo((ScreenW - (2 * HScaleWidth(10))) / 3);
            make.height.mas_equalTo(HScaleHeight(18));
            
        }];
        
        [self.browsesubLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.browseLabel.mas_left);
            make.right.mas_equalTo(self.browseLabel.mas_right);
            make.top.mas_equalTo(self.browseLabel.mas_bottom).offset(HScaleHeight(11));
            make.height.mas_equalTo(HScaleHeight(10));
        }];
        [self.appointmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.browseLabel.mas_right);
            make.top.mas_equalTo(self.browseLabel.mas_top);
            make.width.mas_equalTo((ScreenW - (2 * HScaleWidth(10))) / 3);
            make.height.mas_equalTo(HScaleHeight(18));
        }];
        [self.appointmentsubLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.mas_equalTo(self.appointmentLabel.mas_left);
           make.right.mas_equalTo(self.appointmentLabel.mas_right);
           make.top.mas_equalTo(self.appointmentLabel.mas_bottom).offset(HScaleHeight(11));
           make.height.mas_equalTo(HScaleHeight(10));
              
        }];
    }
    return self;
}

- (void)setModel:(DFDesignerModel *)model
{
    [self.headeriamge sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"shejishi (1)"]];
       
       self.nameLabel.text = model.name;
       
       
       if (model.min_money.length == 0 && model.max_money.length == 0) {
           self.moneyLabel.text = @"价格面议";
       }
       else
       {
           self.moneyLabel.text = [NSString stringWithFormat:@"%d-%d元/㎡",[model.min_money intValue],[model.max_money intValue]];

       }
       
       
       self.goodAtLabel.text = [NSString stringWithFormat:@"擅长风格:%@",[model.styles_name componentsJoinedByString:@"、"]];
       
       self.workYearLabel.text = [NSString stringWithFormat:@"%d年经验",[model.years intValue]];
    
    
    self.signbillLabel.text =  [NSString stringWithFormat:@"%d",[model.order_num intValue]];
    
    self.appointmentLabel.text = [NSString stringWithFormat:@"%d",[model.appointment_num intValue]];
       
    self.browseLabel.text = [NSString stringWithFormat:@"%d",[model.comment_num intValue]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (UIImageView *)headeriamge
{
    if (!_headeriamge) {
        _headeriamge = [[UIImageView alloc]init];
        [self addSubview:_headeriamge];
    }
    return _headeriamge;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = HScaleBoldFont(15);
        _nameLabel.textColor = [UIColor colorWithHexString:@"333333"];
        [self addSubview:_nameLabel];
    }
    return _nameLabel;
}

- (UILabel *)workYearLabel
{
    if (!_workYearLabel) {
        _workYearLabel = [[UILabel alloc]init];
        _workYearLabel.textColor = [UIColor colorWithHexString:@"C82126"];
        _workYearLabel.backgroundColor = [UIColor colorWithHexString:@"FDE8EF"];
        _workYearLabel.font = HScaleFont(10);
        _workYearLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_workYearLabel];
    }
    return _workYearLabel;
}

- (UILabel *)goodAtLabel
{
    if (!_goodAtLabel) {
        _goodAtLabel = [[UILabel alloc]init];
        _goodAtLabel.textColor = [UIColor colorWithHexString:@"999999"];
        _goodAtLabel.font = HScaleFont(11);
        _goodAtLabel.numberOfLines = 2;
        [self addSubview:_goodAtLabel];
    }
    return _goodAtLabel;
}

- (UILabel *)moneyLabel
{
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc]init];
        _moneyLabel.textColor = [UIColor colorWithHexString:@"C82126"];
        _moneyLabel.font = HScaleBoldFont(15);
        [self addSubview:_moneyLabel];
    }
    return _moneyLabel;
}

- (UIButton *)appointmentBtn
{
    if (!_appointmentBtn) {
        _appointmentBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _appointmentBtn.backgroundColor = [UIColor colorWithHexString:@"DD1A21"];
        [_appointmentBtn setTitle:@"预约TA" forState:UIControlStateNormal];
        _appointmentBtn.titleLabel.font = HScaleFont(12);
        [_appointmentBtn setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:UIControlStateNormal];
        _appointmentBtn.layer.cornerRadius = HScaleHeight(1);
        [self addSubview:_appointmentBtn];
    }
    return _appointmentBtn;
}

- (UIView *)secondView
{
    if (!_secondView) {
        _secondView = [[UIView alloc]init];
        _secondView.backgroundColor = [UIColor colorWithHexString:@"F5F6FA"];
        _secondView.layer.cornerRadius = HScaleHeight(3);
        _secondView.layer.masksToBounds = YES;
        [self addSubview:_secondView];
    }
    return _secondView;
}

- (UILabel *)signbillLabel
{
    if (!_signbillLabel) {
        _signbillLabel = [[UILabel alloc]init];
        _signbillLabel.font = HScaleBoldFont(18);
        _signbillLabel.textAlignment = NSTextAlignmentCenter;
        [self.secondView addSubview:_signbillLabel];
    }
    return _signbillLabel;
}

- (UILabel *)appointmentLabel
{
   
    if (!_appointmentLabel) {
        _appointmentLabel = [[UILabel alloc]init];
        _appointmentLabel.font = HScaleBoldFont(18);
        _appointmentLabel.textAlignment = NSTextAlignmentCenter;
        [self.secondView addSubview:_appointmentLabel];
    }
       
    return _appointmentLabel;
}


- (UILabel *)browseLabel
{
   
    if (!_browseLabel) {
        _browseLabel = [[UILabel alloc]init];
        _browseLabel.font = HScaleBoldFont(18);
        _browseLabel.textAlignment = NSTextAlignmentCenter;
        [self.secondView addSubview:_browseLabel];
    }
       
    return _browseLabel;
}

- (UILabel *)signbillsubLabel
{
    if (!_signbillsubLabel) {
        _signbillsubLabel = [[UILabel alloc]init];
        _signbillsubLabel.text = @"签单";
        _signbillsubLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _signbillsubLabel.font = HScaleFont(10);
        _signbillsubLabel.textAlignment = NSTextAlignmentCenter;
        [self.secondView addSubview:_signbillsubLabel];
    }
    return _signbillsubLabel;
}
- (UILabel *)appointmentsubLabel
{
    if (!_appointmentsubLabel) {
        _appointmentsubLabel = [[UILabel alloc]init];
        _appointmentsubLabel.text = @"预约";
        _appointmentsubLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _appointmentsubLabel.font = HScaleFont(10);
        _appointmentsubLabel.textAlignment = NSTextAlignmentCenter;
        [self.secondView addSubview:_appointmentsubLabel];
    }
    return _appointmentsubLabel;
}

- (UILabel *)browsesubLabel
{
    if (!_browsesubLabel) {
        _browsesubLabel = [[UILabel alloc]init];
        _browsesubLabel.text = @"浏览";
        _browsesubLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _browsesubLabel.font = HScaleFont(10);
        _browsesubLabel.textAlignment = NSTextAlignmentCenter;
        [self.secondView addSubview:_browsesubLabel];
    }
    return _browsesubLabel;
}
@end
