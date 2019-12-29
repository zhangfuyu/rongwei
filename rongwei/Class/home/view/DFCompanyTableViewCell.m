//
//  DFCompanyTableViewCell.m
//  rongwei
//
//  Created by apple on 2019/11/21.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFCompanyTableViewCell.h"
@interface DFCompanyTableViewCell ()

@property (nonatomic , strong)UIImageView *imageview;

@property (nonatomic , strong)UILabel *titleLabel;

@property (nonatomic , strong)UILabel *scoreLabel;

@property (nonatomic , strong)UILabel *constructionLabel;

@property (nonatomic , strong)UILabel *distanceLabel;

@end

@implementation DFCompanyTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(HScaleWidth(16));
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(73.5), HScaleHeight(73.5)));
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.imageView.mas_right).offset(HScaleWidth(15.5));
            make.top.mas_equalTo(self.imageView.mas_top);
            make.right.mas_equalTo(-HScaleWidth(16));
        }];
        
        [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLabel.mas_left);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(HScaleHeight(13));
            make.right.mas_equalTo(self.titleLabel.mas_right);
        }];
        
        [self.constructionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.scoreLabel.mas_left);
            make.top.mas_equalTo(self.scoreLabel.mas_bottom).offset(HScaleHeight(21));
            
        }];
        
        [self.distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-HScaleHeight(15));
            make.top.mas_equalTo(self.constructionLabel.mas_top);
        }];
    }
    return self;
}
- (void)setModel:(DFCompanyModel *)model
{
    _model = model;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:nil];
    self.titleLabel.text = model.name;
    self.scoreLabel.text = model.brief;
    self.distanceLabel.text = [NSString stringWithFormat:@"%@km",model.distance];
    self.constructionLabel.text = [NSString stringWithFormat:@"施工工地  %@",model.site_nums];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (UIImageView *)imageView
{
    if (!_imageview) {
        _imageview = [[UIImageView alloc]init];
        [self.contentView addSubview:_imageview];
    }
    return _imageview;
}
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = HScaleFont(15);
        _titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}
- (UILabel *)scoreLabel
{
    if (!_scoreLabel) {
        _scoreLabel = [[UILabel alloc]init];
        _scoreLabel.font = HScaleFont(12);
        _scoreLabel.textColor = [UIColor colorWithHexString:@"DD1A21"];
        [self.contentView addSubview:_scoreLabel];
    }
    return _scoreLabel;
}
- (UILabel *)constructionLabel
{
    if (!_constructionLabel) {
        _constructionLabel = [[UILabel alloc]init];
        _constructionLabel.font = HScaleFont(12);
        _constructionLabel.textColor = [UIColor colorWithHexString:@"999999"];
        [self.contentView addSubview:_constructionLabel];
    }
    return _constructionLabel;
}
- (UILabel *)distanceLabel
{
    if (!_distanceLabel) {
        _distanceLabel = [[UILabel alloc]init];
        _distanceLabel.font = HScaleFont(12);
        _distanceLabel.textColor = [UIColor colorWithHexString:@"999999"];
        _distanceLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_distanceLabel];
        
    }
    return _distanceLabel;
}
@end
