//
//  DFCommentBommenView.m
//  rongwei
//
//  Created by zhangfuyu on 2019/11/27.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFCommentBommenView.h"
#import "DFGongLueCommentsViewController.h"

@interface DFCommentBommenView ()

@property (nonatomic , strong) UIButton *foundBtn;

@property (nonatomic , strong) UILabel *commentLaebl;

@end

@implementation DFCommentBommenView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIView *rightlineview = [[UIView alloc]init];
        rightlineview.backgroundColor = [UIColor colorWithHexString:@"E8E8E8"];
        [self addSubview:rightlineview];
        
        [rightlineview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(HScaleHeight(.5));
            
        }];
        
        [self.foundBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(HScaleHeight(7.5));
            make.right.mas_equalTo(-HScaleWidth(10));
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(102), HScaleHeight(38)));
        }];
        
        [self.commentLaebl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(10));
            make.top.mas_equalTo(HScaleWidth(13));
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(149.5), HScaleHeight(28)));
        }];
        self.commentLaebl.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickEvent:)];
        [self.commentLaebl addGestureRecognizer: tap];
        
    }
    return self;
}
- (void)clickEvent:(UITapGestureRecognizer *)tap
{
    NSLog(@"view.tag = %ld",tap.view.tag);
    DFGongLueCommentsViewController *comment = [[DFGongLueCommentsViewController alloc]init];
    comment.bbs_id = self.model.modelId;
    comment.comment_num = self.model.bbs_com_num;
    [self.viewController.navigationController pushViewController:comment animated:YES];
    
}


- (UIButton *)foundBtn
{
    if (!_foundBtn) {
        _foundBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_foundBtn setBackgroundColor:[UIColor colorWithHexString:@"DD1A21"]];
        [_foundBtn setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:UIControlStateNormal];
        _foundBtn.titleLabel.font = HScaleFont(15);
        [_foundBtn setTitle:@"找设计" forState:UIControlStateNormal];
        _foundBtn.layer.cornerRadius = HScaleHeight(19.5);
        [self addSubview:_foundBtn];
    }
    return _foundBtn;
}
- (UILabel *)commentLaebl
{
    if (!_commentLaebl) {
        _commentLaebl = [[UILabel alloc]init];
        _commentLaebl.backgroundColor = [UIColor colorWithHexString:@"F5F6FA"];
        _commentLaebl.textColor = [UIColor colorWithHexString:@"999999"];
        _commentLaebl.font = HScaleFont(12);
        _commentLaebl.layer.cornerRadius = HScaleHeight(14);
        _commentLaebl.layer.masksToBounds = YES;
        _commentLaebl.text = @"  想勾搭，先评论";
        [self addSubview:_commentLaebl];
    }
    return _commentLaebl;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
