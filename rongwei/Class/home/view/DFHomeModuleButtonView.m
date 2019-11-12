//
//  DFHomeModuleButtonView.m
//  rongwei
//
//  Created by apple on 2019/10/14.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFHomeModuleButtonView.h"
@interface DFHomeModuleButtonView ()

/**
 <#Description#>
 */
@property (nonatomic, strong) NSString *imageName;

/**
 <#Description#>
 */
@property (nonatomic, strong) NSString *title;

@end

@implementation DFHomeModuleButtonView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithImageName:(NSString *)imageName withTitle:(NSString *)title {
    
    if (self = [super init]) {
        self.imageName = imageName;
        self.title = title;
//        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
    
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.image = [UIImage imageNamed:ISNIL(self.imageName)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.imageName] placeholderImage:nil];
    [self addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(HScaleHeight(44));
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = HScaleFont(12);
    titleLabel.textColor = [UIColor colorWithHexString:@"3A405E"];
    titleLabel.text = ISNIL(self.title);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(imageView.mas_bottom).with.offset(HScaleHeight(6));/*(HScaleHeight(-16))*/;
    }];
    
    
    UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:actionButton];
    
    [actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    self.actionButton = actionButton;
    
}


@end
