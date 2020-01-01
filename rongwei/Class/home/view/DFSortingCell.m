//
//  DFSortingCell.m
//  rongwei
//
//  Created by zhangfuyu on 2019/12/29.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFSortingCell.h"

@interface DFSortingCell ()

@property (nonatomic , strong) UILabel *titleLabel;
@property (nonatomic , strong) UIImageView *showIamge;

@end

@implementation DFSortingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
            make.left.mas_equalTo(HScaleWidth(29));
        }];
        
        [self.showIamge mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-HScaleWidth(22));
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(16.5), HScaleHeight(11.5)));
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
    }
    return self;
}

- (void)setShowHua:(BOOL)showHua
{

    self.showIamge.hidden = !showHua;
}

- (void)setShowTitle:(NSString *)showTitle
{
    self.titleLabel.text = showTitle;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = HScaleFont(12);
        _titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}
- (UIImageView *)showIamge
{
    if (!_showIamge) {
        _showIamge = [[UIImageView alloc]init];
        _showIamge.hidden = YES;
        _showIamge.image = [UIImage imageNamed:@"勾 选择页面"];
        [self.contentView addSubview:_showIamge];
    }
    return _showIamge;
}
@end
