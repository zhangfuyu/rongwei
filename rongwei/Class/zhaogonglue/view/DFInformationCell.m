//
//  DFInformationCell.m
//  rongwei
//
//  Created by zhangfuyu on 2019/12/19.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFInformationCell.h"

@interface DFInformationCell ()

@property (nonatomic , strong) UILabel *questLabel;

@property (nonatomic , strong) UILabel *answerLabel;

@property (nonatomic , strong) UILabel *answerNumberLabel;

@property (nonatomic , strong) UIImageView *quesrImage;

@property (nonatomic , strong) UIImageView *answerImage;

@property (nonatomic , strong) UIView *lineview;

@end

@implementation DFInformationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.lineview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.height.mas_equalTo(HScaleHeight(5));
        }];
        
        
        [self.quesrImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(10));
            make.top.mas_equalTo(self.lineview.mas_bottom).offset(HScaleWidth(15.5));
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(12.5), HScaleHeight(13)));
        }];
        
        [self.questLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.quesrImage.mas_right).offset(HScaleWidth(8.5));
            make.top.mas_equalTo(self.lineview.mas_bottom).offset(HScaleHeight(15.5));
            make.right.mas_equalTo(-HScaleWidth(12));
        }];
        
        [self.answerImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.quesrImage.mas_bottom).offset(HScaleHeight(9.5));
            make.left.mas_equalTo(self.quesrImage.mas_left);
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(12.5), HScaleHeight(13)));

        }];
        
        [self.answerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.questLabel.mas_left);
            make.right.mas_equalTo(self.questLabel.mas_right);
            make.top.mas_equalTo(self.questLabel.mas_bottom).offset(HScaleHeight(11));
        }];
        
        [self.answerNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(9.5));
            make.bottom.mas_equalTo(-HScaleHeight(14.5));
        }];
        
    }
    return self;
}

- (void)setModel:(DFGongLueModel *)model
{
    _model = model;
    
    self.questLabel.text = model.bbs_title;
    if (model.last_comment.length == 0) {
        self.answerLabel.hidden = YES;
        self.answerImage.hidden = YES;
        
    }
    else
    {
        self.answerLabel.hidden = NO;
        self.answerImage.hidden = NO;
        self.answerLabel.text = model.last_comment;
    }
    
    NSString *nameBig = [NSString stringWithFormat:@"全部 %@ 个回答",model.bbs_com_num];
    
    NSMutableAttributedString *arrti = [[NSMutableAttributedString alloc]initWithString:nameBig];
    NSRange range = [nameBig rangeOfString:model.bbs_com_num];
    
    
    [arrti addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"DD1A21"] range:NSMakeRange(range.location,range.location)];
    
    self.answerNumberLabel.attributedText = arrti;
    
    
}

- (UILabel *)questLabel
{
    if (!_questLabel) {
        _questLabel = [[UILabel alloc]init];
        _questLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _questLabel.font = HScaleFont(12);
        [self.contentView addSubview:_questLabel];
    }
    return _questLabel;
}

- (UILabel *)answerLabel
{
    if (!_answerLabel) {
        _answerLabel = [[UILabel alloc]init];
        _answerLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _answerLabel.font = HScaleFont(12);
        _answerLabel.numberOfLines = 0;
        [self.contentView addSubview:_answerLabel];
    }
    return _answerLabel;
}
- (UILabel *)answerNumberLabel
{
    if (!_answerNumberLabel) {
        _answerNumberLabel = [[UILabel alloc]init];
        _answerNumberLabel.textColor = [UIColor colorWithHexString:@"999999"];
        _answerNumberLabel.font = HScaleFont(11);
        [self.contentView addSubview:_answerNumberLabel];
    }
    return _answerNumberLabel;
}

- (UIImageView *)quesrImage
{
    if (!_quesrImage) {
        _quesrImage = [[UIImageView alloc]init];
        _quesrImage.image = [UIImage imageNamed:@"ziyuan"];
        [self.contentView addSubview:_quesrImage];
    }
    return _quesrImage;
}

- (UIImageView *)answerImage
{
    if (!_answerImage) {
        _answerImage = [[UIImageView alloc]init];
        _answerImage.image = [UIImage imageNamed:@"da_zixun"];
        [self.contentView addSubview:_answerImage];
    }
    return _answerImage;
}

- (UIView *)lineview
{
    if (!_lineview) {
        _lineview = [[UIView alloc]init];
        _lineview.backgroundColor = [UIColor colorWithHexString:@"F7F7F7"];
        [self.contentView addSubview:_lineview];
    }
    return _lineview;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
