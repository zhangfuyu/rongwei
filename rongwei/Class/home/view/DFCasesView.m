//
//  DFCasesView.m
//  rongwei
//
//  Created by apple on 2019/9/26.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFCasesView.h"
@interface DFCasesView ()

@property (nonatomic ,strong)UIScrollView *scrollview;

@property (nonatomic , strong)NSMutableArray *itemBtnArr;

@property (nonatomic , strong)UIView *lineview;


@end

@implementation DFCasesView

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
        
        
        self.layer.masksToBounds = YES;
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
    
    self.scrollview.scrollEnabled = self.canscroll;
    
    float scroWid = HScaleWidth(32);
    
    for (UIButton *choosebtn in self.itemBtnArr) {
        [choosebtn removeFromSuperview];
    }
    
    for (NSInteger index = 0; index < titleArry.count; index ++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = index;
        [btn setTitle:titleArry[index] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"DD1A21"] forState:UIControlStateSelected];
        if (index == 0) {
            btn.selected = YES;
        }
        btn.titleLabel.font = HScaleFont(14);
        [self.scrollview addSubview:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        float btnWid = [DFCasesView getWidthWithString:titleArry[index] font:btn.titleLabel.font];
        
        btn.frame = CGRectMake(scroWid, 0, btnWid, CGRectGetHeight(self.bounds));
        
        scroWid += btnWid;
        scroWid += HScaleWidth(76);
        [self.itemBtnArr addObject:btn];
        
        if (index == 0) {

            self.lineview.frame = CGRectMake(CGRectGetMinX(btn.frame), CGRectGetMaxY(btn.frame) - HScaleHeight(3), CGRectGetWidth(btn.frame), HScaleHeight(3));
        }
    }
    
    self.scrollview.contentSize = CGSizeMake(scroWid + 15, CGRectGetHeight(self.bounds));
}
- (void)setWorkcount:(NSString *)workcount
{
    _workcount = workcount;
    UIButton *workbtn = [self.itemBtnArr firstObject];
    [workbtn setTitle:[NSString stringWithFormat:@"作品（%@）",workcount] forState:UIControlStateNormal];
}
- (void)setSelectBtnTag:(NSInteger)selectBtnTag
{
    _selectBtnTag = selectBtnTag;
    UIButton *clickBtn = (UIButton *)[self.itemBtnArr objectOrNilAtIndex:selectBtnTag];
    [self btnClick:clickBtn];
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
    
    [self bringSubviewToFront:self.lineview];
    
    self.lineview.frame = CGRectMake(CGRectGetMinX(sender.frame), CGRectGetMaxY(sender.frame) - HScaleHeight(3), CGRectGetWidth(sender.frame), HScaleHeight(3));

    
    if (self.canscroll) {
         //点击按钮在滑动视图中居中显示
           CGRect centerRect = CGRectMake(sender.center.x - CGRectGetWidth(self.scrollview.bounds)/2, 0, CGRectGetWidth(self.scrollview.bounds), CGRectGetHeight(self.scrollview.bounds));
           [self.scrollview scrollRectToVisible:centerRect animated:YES];
    }
   
    
    
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


- (UIView *)lineview
{
    if (!_lineview) {
        _lineview = [[UIView alloc]init];
        _lineview.backgroundColor = [UIColor colorWithHexString:@"DD1A21"];
        [self addSubview:_lineview];
        
    }
    return _lineview;
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
