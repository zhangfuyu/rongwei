//
//  DFStrategyCommentCell.m
//  rongwei
//
//  Created by zhangfuyu on 2019/12/3.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFStrategyCommentCell.h"

@interface DFStrategyCommentCell ()

@property (nonatomic , strong)UIImageView *headerimage;

@property (nonatomic , strong)UILabel *nameLabel;

@property (nonatomic , strong)UILabel *timerLabel;

@property (nonatomic , strong)UIButton *commentTypeBtn;

@property (nonatomic , strong)UILabel *commentLabel;

@end

@implementation DFStrategyCommentCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.headerimage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(17.5));
            make.top.mas_equalTo(HScaleWidth(20));
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(22), HScaleHeight(22)));
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.headerimage.mas_right).offset(HScaleWidth(6));
            make.centerY.mas_equalTo(self.headerimage.mas_centerY);
            make.right.mas_equalTo(-HScaleWidth(100));
        }];
        
        [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.headerimage.mas_bottom).offset(HScaleHeight(10.5));
            make.left.mas_equalTo(HScaleWidth(17.5));
            make.right.mas_equalTo(-HScaleWidth(17.5));
        }];
        
        [self.timerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.commentLabel.mas_bottom).offset(HScaleHeight(8.5));
            make.right.mas_equalTo(-HScaleWidth(17.5));
        }];
        
        
    }
    return self;
}
- (void)setModel:(DFGongLueCommentModel *)model
{
    _model = model;
    [self.headerimage sd_setImageWithURL:[NSURL URLWithString:model.comment_user_name] placeholderImage:nil];
    self.nameLabel.text = model.comment_user_name;
    self.commentLabel.text = model.com_content;
    self.timerLabel.text = model.created_at;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIImageView *)headerimage
{
    if (!_headerimage) {
        _headerimage = [[UIImageView alloc]init];
        _headerimage.layer.cornerRadius = HScaleWidth(11);
        _headerimage.layer.masksToBounds = YES;
        [self.contentView addSubview:_headerimage];
    }
    return _headerimage;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _nameLabel.font = HScaleFont(11);
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
}

- (UILabel *)timerLabel
{
    if (!_timerLabel) {
        _timerLabel = [[UILabel alloc]init];
        _timerLabel.textColor = [UIColor colorWithHexString:@"999999"];
        _timerLabel.font = HScaleFont(9);
        [self.contentView addSubview:_timerLabel];
    }
    return _timerLabel;
}
- (UILabel *)commentLabel
{
    if (!_commentLabel) {
        _commentLabel = [[UILabel alloc]init];
        _commentLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _commentLabel.font = HScaleFont(11);
        _commentLabel.numberOfLines = 0;
        [self.contentView addSubview:_commentLabel];
    }
    return _commentLabel;
}
- (UIButton *)commentTypeBtn
{
    if (!_commentTypeBtn) {
        _commentTypeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentTypeBtn setTitleColor:UIColorHex(0x010101) forState:UIControlStateNormal];
//        _commentTypeBtn.frame = CGRectMake(0, 0, HScaleWidth(83), 44);
        _commentTypeBtn.titleLabel.font = HScaleFont(11);
        [_commentTypeBtn setTitleColor:[UIColor colorWithHexString:@"DD1A21"] forState:UIControlStateNormal];
        [_commentTypeBtn setTitle:@"  关注" forState:UIControlStateNormal];
        [_commentTypeBtn setImage:[UIImage imageNamed:@"no_Focus_on"] forState:UIControlStateNormal];
//        [_commentTypeBtn setImage:[UIImage imageNamed:@"Focus_on"] forState:UIControlStateSelected];
        [self.contentView addSubview:_commentTypeBtn];
        
    }
    return _commentTypeBtn;
}

@end
