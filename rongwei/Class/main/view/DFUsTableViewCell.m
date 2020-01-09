//
//  DFUsTableViewCell.m
//  rongwei
//
//  Created by zhangfuyu on 2020/1/9.
//  Copyright © 2020 zhangfuyu. All rights reserved.
//

#import "DFUsTableViewCell.h"

@interface DFUsTableViewCell ()

@property (nonatomic , strong) UILabel *moreLineLabel;

@end

@implementation DFUsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.moreLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(20));
            make.right.mas_equalTo(-HScaleWidth(20));
            make.top.mas_equalTo(HScaleHeight(20));
        }];
    }
    return self;
}

- (void)setContentText:(NSString *)contentText
{
    _contentText = contentText;
    self.moreLineLabel.text = contentText;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UILabel *)moreLineLabel
{
    if (!_moreLineLabel) {
        _moreLineLabel = [[UILabel alloc]init];
        _moreLineLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _moreLineLabel.font = HScaleFont(12);
        _moreLineLabel.numberOfLines = 0;
        [self.contentView addSubview:_moreLineLabel];
    }
    return _moreLineLabel;
}
@end
