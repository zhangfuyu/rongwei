//
//  DFSiteStageInfosCell.m
//  rongwei
//
//  Created by zhangfuyu on 2019/11/25.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFSiteStageInfosCell.h"

@interface DFSiteStageInfosCell ()

@property (nonatomic , strong) UILabel *titleLabel;

@property (nonatomic , strong) UILabel *timeLabel;



@end

@implementation DFSiteStageInfosCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
