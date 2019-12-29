//
//  DFAllCategaryView.m
//  rongwei
//
//  Created by zhangfuyu on 2019/12/12.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFAllCategaryView.h"
#import "DFCategoryModel.h"


@interface DFAllCategaryView ()

@property (nonatomic ,strong)UIView *backview;

@property (nonatomic , strong)NSMutableArray *itemBtnArr;




@end

@implementation DFAllCategaryView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self.backview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_equalTo(0);
        }];
        
        
        UIButton *clickbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [clickbtn setImage:[UIImage imageNamed:@"Pack_up"] forState:UIControlStateNormal];
        [clickbtn addTarget:self action:@selector(hiddenSelf) forControlEvents:UIControlEventTouchUpInside];
        [self.backview addSubview:clickbtn];
        
        [clickbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.mas_equalTo(0);
            make.width.mas_equalTo(HScaleWidth(35.5));
            make.height.mas_equalTo(HScaleHeight(37));
        }];
        
        
        
    }
    return self;
}

- (void)setTitleArry:(NSMutableArray *)titleArry
{
    _titleArry = titleArry;
    
    float scroWid = 0;

    float scroHeight = 0;
    
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

        if (ScreenW - scroWid > HScaleWidth(35.5)) {
            btn.frame = CGRectMake(scroWid - btnWid, scroHeight, btnWid, HScaleHeight(37));
            
            if (index == 0) {
                btn.selected = YES;
            }
        }
        else
        {
            
            scroWid = btnWid;
            
            scroHeight += HScaleHeight(37);
            
            
            btn.frame = CGRectMake(0, scroHeight, btnWid, HScaleHeight(37));
        }
        [self.itemBtnArr addObject:btn];


    }
    
    self.frame = CGRectMake(0, CGRectGetMinY(self.frame), ScreenW, scroHeight + HScaleHeight(37));
    
}

- (void)setClickId:(NSString *)clickId
{
    _clickId = clickId;
    
    for (NSInteger index = 0; index < self.titleArry.count; index++) {
               
        DFCategoryModel *model = self.titleArry[index];
        if ([model.modelid isEqualToString:clickId]) {
            UIButton *categaryBtn = self.itemBtnArr[index];
            categaryBtn.selected = YES;
        }
        else
        {
            UIButton *categaryBtn = self.itemBtnArr[index];
            categaryBtn.selected = NO;
        }
    }
}
- (void)hiddenSelf
{
    self.hidden = YES;
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
    
    DFCategoryModel *model = self.titleArry[sender.tag];
    
    self.hidden = YES;
    
    if (self.clickTypeBlock) {
        self.clickTypeBlock([NSString stringWithFormat:@"%@",ISNIL(model.modelid)]);
    }
}
- (UIView *)backview
{
    if (!_backview) {
        _backview = [[UIView alloc]init];
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
