//
//  DFMainTableViewCell.m
//  rongwei
//
//  Created by zhangfuyu on 2019/9/20.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFMainTableViewCell.h"
#import "DFMainCellBtn.h"

@interface DFMainTableViewCell ()

@property (nonatomic , strong) NSMutableArray *btnArry;

@property (nonatomic , strong) UIImageView *leftImage;

@property (nonatomic , strong) UILabel *titleLabel;

@property (nonatomic , strong) UIButton *clickMoreBtn;
@end

@implementation DFMainTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        

        self.backgroundColor = [UIColor colorWithHexString:@"F2F2F2"];
        
        
        UIView *whiteView = [[UIView alloc]init];
        whiteView.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
        whiteView.layer.cornerRadius = 5;
        [self.contentView addSubview:whiteView];
        
        
        [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(13));
            make.right.mas_equalTo(-HScaleWidth(13));
            make.top.bottom.mas_equalTo(0);
        }];
        
        
        self.leftImage = [[UIImageView alloc]init];
        [whiteView addSubview:self.leftImage];
        
        [self.leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleHeight(15));
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(11), HScaleHeight(11)));
            make.top.mas_equalTo(HScaleHeight(12));
        }];
        
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        self.titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
        [whiteView addSubview:self.titleLabel];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.leftImage.mas_right).offset(HScaleWidth(7));
            make.top.mas_equalTo(HScaleHeight(12));
            make.height.mas_equalTo(HScaleHeight(12));
        }];
        
        
        UIView *lineview = [[UIView alloc]init];
        lineview.backgroundColor = [UIColor colorWithHexString:@"EEEEEE"];
        [self.contentView addSubview:lineview];
        
        [lineview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(HScaleHeight(33));
            make.height.mas_equalTo(HScaleHeight(1));
        }];
        
        
        self.clickMoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.clickMoreBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.clickMoreBtn setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
        [self.clickMoreBtn setTitle:@"查看全部订单 >" forState:UIControlStateNormal];
        [whiteView addSubview:self.clickMoreBtn];
        
        [self.clickMoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(lineview.mas_top);
            make.right.mas_equalTo(0);
            make.width.mas_equalTo(HScaleWidth(94));
        }];
        
        
        
        CGFloat widh = (ScreenW - HScaleWidth(13) * 2 ) / 4;
        
        for (NSInteger index = 1; index < 7; index ++) {
            
            DFMainCellBtn *clickBtn = [DFMainCellBtn buttonWithType:UIButtonTypeCustom];
            
            clickBtn.hidden = YES;
            
            [whiteView addSubview:clickBtn];
            
            clickBtn.tag = 10086 + index;
            
            [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(((index - 1) % 4 ) * widh);
                make.top.mas_equalTo(((index - 1) / 4) * HScaleHeight(81) + HScaleHeight(34));
                make.size.mas_equalTo(CGSizeMake(widh, HScaleHeight(81)));
            }];
            
            [self.btnArry addObject:clickBtn];
            
        }

    }
    return self;
}
- (void)setSubClickBtnArry:(NSArray *)subClickBtnArry
{
    _subClickBtnArry = subClickBtnArry;
    
    for (NSInteger index = 0; index < subClickBtnArry.count; index ++) {
        NSDictionary *dic = subClickBtnArry[index];
        DFMainCellBtn *clickBtn = [self.btnArry objectAtIndex:index];
        clickBtn.hidden = NO;
        clickBtn.titleStr = dic[@"title"];
        clickBtn.imageName = dic[@"iamgeName"];
    }
    
    for (NSInteger index = subClickBtnArry.count; index < self.btnArry.count; index ++) {
        DFMainCellBtn *clickBtn = [self.btnArry objectAtIndex:index];
        clickBtn.hidden = YES;

    }
    
}

- (void)setTitleDic:(NSDictionary *)titleDic
{
    _titleDic = titleDic;
    self.titleLabel.text = titleDic[@"title"];
    NSString *imageName = titleDic[@"iamgeName"];
    if (imageName.length > 0) {
        [self.leftImage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleHeight(15));
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(11), HScaleHeight(11)));
            make.top.mas_equalTo(HScaleHeight(12));
        }];
        self.clickMoreBtn.hidden = NO;
    }
    else
    {
        [self.leftImage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleHeight(15));
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(.1), HScaleHeight(11)));
            make.top.mas_equalTo(HScaleHeight(12));
        }];
        self.clickMoreBtn.hidden = YES;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSMutableArray *)btnArry
{
    if (!_btnArry) {
        _btnArry = [NSMutableArray arrayWithCapacity:0];
    }
    return _btnArry;
}

@end
