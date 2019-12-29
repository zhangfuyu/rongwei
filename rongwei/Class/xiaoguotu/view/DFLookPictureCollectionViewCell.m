//
//  DFLookPictureCollectionViewCell.m
//  rongwei
//
//  Created by zhangfuyu on 2019/12/17.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFLookPictureCollectionViewCell.h"

@interface DFLookPictureCollectionViewCell ()

@property (nonatomic , strong) UIImageView *pictureImage;


@end
@implementation DFLookPictureCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor blackColor];
        [self.pictureImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
    }
    return self;
}

- (void)setImageStr:(NSString *)imageStr
{
 
    _imageStr = imageStr;
    [self.pictureImage sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:nil];
}
- (UIImageView *)pictureImage
{
    if (!_pictureImage) {
        _pictureImage = [[UIImageView alloc]init];
        _pictureImage.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_pictureImage];
    }
    return _pictureImage;
}
@end
