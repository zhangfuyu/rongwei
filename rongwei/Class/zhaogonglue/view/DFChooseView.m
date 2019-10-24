//
//  DFChooseView.m
//  rongwei
//
//  Created by apple on 2019/10/18.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFChooseView.h"
@interface DFChooseView ()

@property (nonatomic ,strong)UIScrollView *scrollview;

@property (nonatomic , strong)NSMutableArray *itemBtnArr;

@end


@implementation DFChooseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.scrollview = [[UIScrollView alloc]init];
        self.scrollview.backgroundColor = [UIColor whiteColor];
        
        self.scrollview.showsVerticalScrollIndicator = NO;
        self.scrollview.showsHorizontalScrollIndicator = NO;
        
        [self addSubview:self.scrollview];
    
        
        [self.scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        
    }
    return self;
}

-(void)setTitleArry:(NSMutableArray *)titleArry
{
    _titleArry = titleArry;
    
    float scroWid = 0;
    
    for (UIButton *choosebtn in self.itemBtnArr) {
        [choosebtn removeFromSuperview];
    }
    
    for (NSInteger index = 0; index < titleArry.count; index ++) {
    
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = index;
        [btn setTitle:titleArry[index] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"DD1A21"] forState:UIControlStateSelected];
        btn.titleLabel.font = HScaleFont(12);
        btn.layer.cornerRadius = 2;
        [self.scrollview addSubview:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        float btnWid = [DFChooseView getWidthWithString:titleArry[index] font:btn.titleLabel.font] + HScaleWidth(20);

        btn.frame = CGRectMake(scroWid, 0, btnWid, CGRectGetHeight(self.bounds));
        
        if (index == 0) {
            btn.selected = YES;
        }
        scroWid += btnWid;
        [self.itemBtnArr addObject:btn];
    }
    
    self.scrollview.contentSize = CGSizeMake(scroWid, CGRectGetHeight(self.bounds));
}

- (void)btnClick:(UIButton *)sender
{
    for (UIButton *clickBtn in self.itemBtnArr) {
        if (clickBtn.tag == sender.tag) {
            clickBtn.selected = YES;
        }
        else
        {
            clickBtn.selected = NO;

        }
    }
    
    //点击按钮在滑动视图中居中显示
    CGRect centerRect = CGRectMake(sender.center.x - CGRectGetWidth(self.scrollview.bounds)/2, 0, CGRectGetWidth(self.scrollview.bounds), CGRectGetHeight(self.scrollview.bounds));
    [self.scrollview scrollRectToVisible:centerRect animated:YES];
    
    
    if (self.clickTypeBlock) {
        self.clickTypeBlock(sender.titleLabel.text);
    }
}

- (NSMutableArray *)itemBtnArr
{
    if (!_itemBtnArr) {
        _itemBtnArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _itemBtnArr;
}
#pragma mark Private
/**
 计算字符串长度
 
 @param string string
 @param font font
 @return 字符串长度
 */
+ (CGFloat)getWidthWithString:(NSString *)string font:(UIFont *)font {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [string boundingRectWithSize:CGSizeMake(0, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width;
}


@end
