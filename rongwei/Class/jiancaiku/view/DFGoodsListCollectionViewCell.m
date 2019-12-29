//
//  DFGoodsListCollectionViewCell.m
//  rongwei
//
//  Created by zhangfuyu on 2019/12/12.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFGoodsListCollectionViewCell.h"
#import "DFStoreGoodsView.h"

@interface DFGoodsListCollectionViewCell ()
@property (nonatomic , strong) DFStoreGoodsView *goodsView;
@end

@implementation DFGoodsListCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self.goodsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(HScaleHeight(123.5));
        }];
    }
    return self;
}
- (void)setModel:(DFStoreGoodModel *)model
{
    _model = model;
    self.goodsView.model = model;
}

- (DFStoreGoodsView *)goodsView
{
    if (!_goodsView) {
        _goodsView = [[DFStoreGoodsView alloc]init];
        [self.contentView addSubview:_goodsView];
    }
    return _goodsView;
}
@end
