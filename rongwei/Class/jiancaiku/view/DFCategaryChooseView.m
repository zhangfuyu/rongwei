//
//  DFCategaryChooseView.m
//  rongwei
//
//  Created by zhangfuyu on 2019/12/11.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFCategaryChooseView.h"
#import "DFCategoryModel.h"

@interface DFCategaryChooseView ()

@property (nonatomic ,strong)UIScrollView *backview;

@property (nonatomic , strong)NSMutableArray *itemBtnArr;







@end

@implementation DFCategaryChooseView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];

        
        [self.backview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.mas_equalTo(0);
            make.right.mas_offset(-HScaleWidth(35.5));
        }];
        
        
        UIButton *clickbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [clickbtn setImage:[UIImage imageNamed:@"Building_down"] forState:UIControlStateNormal];
        [clickbtn addTarget:self action:@selector(showAllCategary) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:clickbtn];
        
        [clickbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.mas_equalTo(0);
            make.width.mas_equalTo(HScaleWidth(35.5));
        }];
        
        
        
    }
    return self;
}

- (void)setClickId:(NSString *)clickId
{
    _clickId = clickId;
    
    for (NSInteger index = 0; index < self.titleArry.count; index++) {
               
        DFCategoryModel *model = self.titleArry[index];
        if ([model.modelid isEqualToString:clickId]) {
            UIButton *categaryBtn = self.itemBtnArr[index];
            categaryBtn.selected = YES;
            
            //点击按钮在滑动视图中居中显示
            CGRect centerRect = CGRectMake(categaryBtn.center.x - CGRectGetWidth(self.backview.bounds)/2, 0, CGRectGetWidth(self.backview.bounds), CGRectGetHeight(self.backview.bounds));
            [self.backview scrollRectToVisible:centerRect animated:YES];
        }
        else
        {
            if (index > self.itemBtnArr.count - 1) {
                break;
            }
            UIButton *categaryBtn = self.itemBtnArr[index];
            categaryBtn.selected = NO;
        }
    }
}

- (void)setTitleArry:(NSMutableArray *)titleArry
{
    _titleArry = titleArry;
    
    float scroWid = 0;

    
    for (NSInteger index = 0; index < titleArry.count; index ++) {
        
        
        DFCategoryModel *model = titleArry[index];
    
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = index;
        [btn setTitle:model.category_name forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"DD1A21"] forState:UIControlStateSelected];
        btn.titleLabel.font = HScaleFont(12);
        
        [self.backview addSubview:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        float btnWid = [model.category_name widthForFont:btn.titleLabel.font] + HScaleWidth(22);//[DFChooseView getWidthWithString:dic[@"name"] font:btn.titleLabel.font] + HScaleWidth(20);

        scroWid += btnWid;

//        if (ScreenW - scroWid > HScaleWidth(35.5)) {
            btn.frame = CGRectMake(scroWid - btnWid, 0, btnWid, CGRectGetHeight(self.bounds));
            
            if (index == 0) {
                btn.selected = YES;
            }
            [self.itemBtnArr addObject:btn];
//        }
//        else
//        {
//            break;
//        }
        

    }
    
    self.backview.contentSize = CGSizeMake(scroWid, HScaleHeight(37));
    
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
    CGRect centerRect = CGRectMake(sender.center.x - CGRectGetWidth(self.backview.bounds)/2, 0, CGRectGetWidth(self.backview.bounds), CGRectGetHeight(self.backview.bounds));
    [self.backview scrollRectToVisible:centerRect animated:YES];
    
    
    DFCategoryModel *model = self.titleArry[sender.tag];

    
    if (self.clickTypeBlock) {
        
        self.clickTypeBlock([NSString stringWithFormat:@"%@",ISNIL(model.modelid)]);
    }
}
- (void)showAllCategary
{
    if (self.clickShowAllCategaeyBlock) {
        self.clickShowAllCategaeyBlock();
    }
}


- (UIScrollView *)backview
{
    if (!_backview) {
        _backview = [[UIScrollView alloc]init];
        _backview.showsVerticalScrollIndicator = NO;
        _backview.showsHorizontalScrollIndicator = NO;
        _backview.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
        [self addSubview:_backview];
    }
    return _backview;
}
- (NSMutableArray *)itemBtnArr
{
    if (!_itemBtnArr) {
        _itemBtnArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _itemBtnArr;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
