//
//  DfDesignerTableViewCell.m
//  rongwei
//
//  Created by apple on 2019/9/25.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DfDesignerTableViewCell.h"

@interface DfDesignerTableViewCell ()

@property (nonatomic , strong) UIImageView *headerImage;

@property (nonatomic , strong) UILabel *nameLabel;

@property (nonatomic , strong) UILabel *priceLabel;

@property (nonatomic , strong) UILabel *goodAtLabel;

@property (nonatomic , strong) UILabel *workYearLabel;

@property (nonatomic , strong) UILabel *signbillLabel;

@property (nonatomic , strong) UILabel *appointmentLabel;

@end

@implementation DfDesignerTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(HScaleHeight(16));
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(75), HScaleHeight(75)));
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.headerImage.mas_right).offset(HScaleWidth(16));
            make.top.mas_equalTo(self.headerImage.mas_top);
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(100), HScaleHeight(15)));
            
        }];
        
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView.mas_right).offset(-HScaleWidth(23));
            make.top.mas_equalTo(HScaleHeight(18));
            make.height.mas_equalTo(HScaleHeight(12));
        }];
        
        [self.goodAtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nameLabel.mas_left);
            make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(HScaleHeight(9));
            make.height.mas_equalTo(HScaleHeight(11));
            make.right.mas_equalTo(-HScaleWidth(23));
        }];
        [self.workYearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nameLabel.mas_left);
            make.top.mas_equalTo(self.goodAtLabel.mas_bottom).offset(HScaleHeight(6));
            make.height.mas_equalTo(HScaleHeight(10));
        }];
        
        [self.signbillLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nameLabel.mas_left);
            make.top.mas_equalTo(self.workYearLabel.mas_bottom).offset(HScaleHeight(11));
            make.height.mas_equalTo(HScaleHeight(11));
        }];
        
        [self.appointmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.signbillLabel.mas_top);
            make.left.mas_equalTo(self.signbillLabel.mas_right).offset(HScaleWidth(27));
            make.height.mas_equalTo(HScaleHeight(11));

        }];
        
    }
    return self;
}


- (void)setModel:(DFDesignerModel *)model
{
    _model = model;
    
    
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"shejishi (1)"]];
    
    self.nameLabel.text = model.name;
    
    
    if (model.min_money.length == 0 && model.max_money.length == 0) {
        self.priceLabel.text = @"价格面议";
    }
    else
    {
        self.priceLabel.text = [NSString stringWithFormat:@"%d-%d/㎡",[model.min_money intValue],[model.max_money intValue]];

    }
    
    NSMutableArray *stylearry = [NSMutableArray arrayWithCapacity:0];

    if (model.style.count > 0) {
        for (NSDictionary *dic in model.style) {
            [stylearry addObject:dic[@"name"]];
        }
        self.goodAtLabel.text = [NSString stringWithFormat:@"擅长风格:%@",[stylearry componentsJoinedByString:@"、"]];

    }
    else
    {
        self.goodAtLabel.text = [NSString stringWithFormat:@"擅长风格:"];

    }
    
    
    self.workYearLabel.text = [NSString stringWithFormat:@"%d年以上|%d套作品",[model.years intValue],[model.works_num intValue]];
    
    self.signbillLabel.text = [NSString stringWithFormat:@"签单:%d人",[model.order_num intValue]];
    
    self.appointmentLabel.text = [NSString stringWithFormat:@"预约:%d人",[model.appointment_num intValue]];
    
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (UIImageView *)headerImage
{
    if (!_headerImage) {
        _headerImage = [[UIImageView alloc]init];
        _headerImage.layer.cornerRadius = HScaleHeight(3);
        [self.contentView addSubview:_headerImage];
    }
    return _headerImage;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = HScaleFont(15);
        _nameLabel.textColor = [UIColor colorWithHexString:@"333333"];
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
}

- (UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textAlignment = NSTextAlignmentRight;
        _priceLabel.font = HScaleFont(12);
        _priceLabel.textColor = [UIColor colorWithHexString:@"C82126"];
        [self.contentView addSubview:_priceLabel];
    }
    return _priceLabel;
}

- (UILabel *)goodAtLabel
{
    if (!_goodAtLabel) {
        _goodAtLabel = [[UILabel alloc]init];
        _goodAtLabel.font = HScaleFont(11);
        _goodAtLabel.textColor = [UIColor colorWithHexString:@"999999"];
        [self.contentView addSubview:_goodAtLabel];
    }
    return _goodAtLabel;
}
- (UILabel *)workYearLabel
{
    if (!_workYearLabel) {
        _workYearLabel = [[UILabel alloc]init];
        _workYearLabel.font = HScaleFont(10);
        _workYearLabel.textColor = [UIColor colorWithHexString:@"999999"];
        [self.contentView addSubview:_workYearLabel];
    }
    return _workYearLabel;
}
- (UILabel *)signbillLabel
{
    if (!_signbillLabel) {
          _signbillLabel = [[UILabel alloc]init];
          _signbillLabel.font = HScaleFont(11);
          _signbillLabel.textColor = [UIColor colorWithHexString:@"999999"];
          [self.contentView addSubview:_signbillLabel];
    }
    return _signbillLabel;
}

- (UILabel *)appointmentLabel
{
    if (!_appointmentLabel) {
          _appointmentLabel = [[UILabel alloc]init];
          _appointmentLabel.font = HScaleFont(11);
          _appointmentLabel.textColor = [UIColor colorWithHexString:@"999999"];
          [self.contentView addSubview:_appointmentLabel];
    }
    return _appointmentLabel;
}

@end
