//
//  DFZiXunListHeaderView.m
//  rongwei
//
//  Created by zhangfuyu on 2019/12/21.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFZiXunListHeaderView.h"

@implementation DFZiXunListHeaderView


- (instancetype)initWithFrame:(CGRect)frame withModel:(DFGongLueModel *)model
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
        
        CGFloat selfHeighet = HScaleHeight(15.5);
        
        UIImageView *questImage = [[UIImageView alloc]init];
        questImage.image = [UIImage imageNamed:@"ziyuan"];
        [self addSubview:questImage];
        
        [questImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(10));
            make.top.mas_equalTo(HScaleHeight(15.5));
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(12.5), HScaleHeight(13)));
            
        }];
        
        UILabel *quesetLabel = [[UILabel alloc]init];
        quesetLabel.font = HScaleFont(12);
        quesetLabel.textColor = [UIColor colorWithHexString:@"333333"];
        
        NSString *questText = [NSString stringWithFormat:@"%@#%@",model.bbs_title,model.modelclass[@"name"]];

        
        if ([(NSString *)model.modelclass[@"name"] length] > 0) {
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:questText];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"333333"] range:NSMakeRange(0,questText.length - ([(NSString *)model.modelclass[@"name"] length] + 1))];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"DD1A21"] range:NSMakeRange(questText.length - ([(NSString *)model.modelclass[@"name"] length] + 1),[(NSString *)model.modelclass[@"name"] length] + 1)];
            quesetLabel.attributedText = str;
        }
        else
        {
            quesetLabel.text = questText;
        }
        
        
        quesetLabel.numberOfLines = 0;
        [self addSubview:quesetLabel];

        
        [quesetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(questImage.mas_right).offset(HScaleWidth(8));
            make.top.mas_equalTo(HScaleHeight(15.5));
            make.right.mas_equalTo(-HScaleWidth(12.5));
        }];
        
        selfHeighet += [quesetLabel.text heightForFont:quesetLabel.font width:ScreenW - HScaleWidth(12.5) - HScaleWidth(30.5)];
        
        
        
        
        
        
    
        selfHeighet += HScaleHeight(11.5);
        
        
        
        UILabel *contentLabel = [[UILabel alloc]init];
        contentLabel.font = HScaleFont(12);
        contentLabel.textColor = [UIColor colorWithHexString:@"999999"];
        contentLabel.numberOfLines = 0;
        contentLabel.text = model.bbs_content;
        [self addSubview:contentLabel];
        
        if (model.bbs_content.length > 0 ) {
            [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(quesetLabel.mas_left);
                make.right.mas_equalTo(quesetLabel.mas_right);
                make.top.mas_equalTo(quesetLabel.mas_bottom).offset(HScaleHeight(11.5));
            }];
            
            selfHeighet += [model.bbs_content heightForFont:contentLabel.font width:ScreenW - HScaleWidth(12.5) - HScaleWidth(30.5)];

        }
        else
        {
            [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(quesetLabel.mas_left);
                make.right.mas_equalTo(quesetLabel.mas_right);
                make.top.mas_equalTo(quesetLabel.mas_bottom).offset(HScaleHeight(11.5));
                make.top.mas_equalTo(.1);
            }];
        }
        
        
        
        
        UIImageView *headerImage = [[UIImageView alloc]init];
        [headerImage sd_setImageWithURL:[NSURL URLWithString:model.bbs_user_image] placeholderImage:[UIImage imageNamed:@"头像_男孩"]];
        [self addSubview:headerImage];
        
        [headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(contentLabel.mas_bottom).offset(HScaleHeight(15));
            make.left.mas_equalTo(HScaleWidth(HScaleWidth(10)));
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(15), HScaleHeight(15)));
        }];
        
        selfHeighet += HScaleHeight(15);
        
        selfHeighet += HScaleHeight(15);
        
        
        UILabel *timeLabel = [[UILabel alloc]init];
        timeLabel.textColor = [UIColor colorWithHexString:@"999999"];
        timeLabel.font = HScaleFont(11);
        timeLabel.textAlignment = NSTextAlignmentRight;
        timeLabel.text = [NSString stringWithFormat:@"提问于:%@",model.created_at];
        [self addSubview:timeLabel];
        
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-HScaleWidth(13));
            make.top.mas_equalTo(contentLabel.mas_bottom).offset(HScaleHeight(17));
        }];
        
        
        
        UILabel *nameLaebl = [[UILabel alloc]init];
        nameLaebl.textColor = [UIColor colorWithHexString:@"999999"];
        nameLaebl.font = HScaleFont(12);
        nameLaebl.text = model.bbs_user_name;
        [self addSubview:nameLaebl];
        
        [nameLaebl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(headerImage.mas_right).offset(HScaleWidth(6));
            make.top.mas_equalTo(contentLabel.mas_bottom).offset(HScaleHeight(17));
            make.right.mas_equalTo(timeLabel.mas_left).offset(-HScaleWidth(10));
        }];
        
        
        selfHeighet += HScaleHeight(15.5);
        
        
        UIView *linview = [[UIView alloc]init];
        linview.backgroundColor = [UIColor colorWithHexString:@"F7F7F7"];
        [self addSubview:linview];
        
        [linview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(HScaleHeight(5));
        }];
        
        
        selfHeighet += HScaleHeight(5);
        
        
        self.frame = CGRectMake(0, kNavBarAndStatusBarHeight, ScreenW, selfHeighet);
        
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
