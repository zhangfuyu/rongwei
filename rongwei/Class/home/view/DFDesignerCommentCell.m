//
//  DFDesignerCommentCell.m
//  rongwei
//
//  Created by apple on 2019/11/19.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFDesignerCommentCell.h"
@interface DFDesignerCommentCell ()

@property (nonatomic , strong)UIImageView *headerimage;

@property (nonatomic , strong)UILabel *nameLabel;

@property (nonatomic , strong)UILabel *timerLabel;

@property (nonatomic , strong)UIButton *commentTypeBtn;

@property (nonatomic , strong)UILabel *commentLabel;

@property (nonatomic , strong)UIView *noCommentView;

@end

@implementation DFDesignerCommentCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.headerimage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(HScaleHeight(15));
            make.left.mas_equalTo(HScaleHeight(10.5));
            make.size.mas_equalTo(CGSizeMake(HScaleHeight(22), HScaleHeight(22)));
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.headerimage.mas_right).offset(HScaleWidth(6));
            make.centerY.mas_equalTo(self.headerimage.mas_centerY);
        }];
        
        [self.timerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nameLabel.mas_right).offset(HScaleHeight(12.5));
            make.centerY.mas_equalTo(self.nameLabel.mas_centerY);

        }];
        
        
        [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(15));
            make.right.mas_equalTo(-HScaleWidth(15));
            make.top.mas_equalTo(self.headerimage.mas_bottom).offset(HScaleHeight(10.5));
        }];
        
        [self.commentTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(55), HScaleWidth(13)));
            make.centerY.mas_equalTo(self.nameLabel.mas_centerY);
        }];
        
        [self.noCommentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
    }
    return self;
}
- (void)setModel:(DFCommentModel *)model
{
    _model = model;
    [self.headerimage sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"头像_男孩"]];
    self.nameLabel.text = model.user_name;
    self.timerLabel.text = model.created_at;
    self.commentLabel.text = model.content;
    
    if ([model.score intValue] == 4 || [model.score intValue] == 5) {
        [self.commentTypeBtn setTitle:@"好评" forState:UIControlStateNormal];
        [self.commentTypeBtn setTitleColor:[UIColor colorWithHexString:@"DD1A21"] forState:UIControlStateNormal];
        [self.commentTypeBtn setImage:[UIImage imageNamed:@"haoping"] forState:UIControlStateNormal];
    }
    else if ([model.score intValue] == 3)
    {
        [self.commentTypeBtn setTitle:@"中评" forState:UIControlStateNormal];
        [self.commentTypeBtn setTitleColor:[UIColor colorWithHexString:@"FF7E00"] forState:UIControlStateNormal];
        [self.commentTypeBtn setImage:[UIImage imageNamed:@"zhongping"] forState:UIControlStateNormal];
    }
    else
    {
        [self.commentTypeBtn setTitle:@"差评" forState:UIControlStateNormal];
        [self.commentTypeBtn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        [self.commentTypeBtn setImage:[UIImage imageNamed:@"chaping"] forState:UIControlStateNormal];
    }
}

- (void)setIsShowNoData:(BOOL)isShowNoData
{
    _isShowNoData = isShowNoData;
    self.noCommentView.hidden = isShowNoData;
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

- (UIView *)noCommentView
{
    if (!_noCommentView) {
        _noCommentView = [[UIView alloc]init];//WithFrame:CGRectMake(0, 0, ScreenW, HScaleHeight(81.5))];
        _noCommentView.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
        _noCommentView.hidden = YES;
        
        [self.contentView addSubview:_noCommentView];

        
        UIImageView *noDataImage = [[UIImageView alloc]init];
        noDataImage.image = [UIImage imageNamed:@"comment_zanwu"];
        [_noCommentView addSubview:noDataImage];
        
        [noDataImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(126.5));
            make.centerY.mas_equalTo(_noCommentView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(34), HScaleHeight(30.5)));
        }];
        
        UILabel *titlelabel = [[UILabel alloc]init];
        titlelabel.text = @"没有相应的评价";
        [titlelabel setTextColor:[UIColor colorWithHexString:@"999999"]];
        titlelabel.font = HScaleFont(12);
        [_noCommentView addSubview:titlelabel];
        
        [titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(noDataImage.mas_right).offset(HScaleWidth(5.5));
            make.top.mas_equalTo(noDataImage.mas_top);
        }];
        
        UILabel *subTitle = [[UILabel alloc]init];
        subTitle.text = @"看看其他的~";
        [subTitle setTextColor:[UIColor colorWithHexString:@"999999"]];
        subTitle.font = HScaleFont(9);
        [_noCommentView addSubview:subTitle];
        
        [subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(noDataImage.mas_right).offset(HScaleWidth(5.5));
            make.bottom.mas_equalTo(noDataImage.mas_bottom);
        }];
        
    }
    return _noCommentView;
}
@end
