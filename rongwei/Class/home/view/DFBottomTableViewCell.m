//
//  DFBottomTableViewCell.m
//  rongwei
//
//  Created by apple on 2019/11/25.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFBottomTableViewCell.h"
#import "DFConstructionSiteViewController.h"
#import "DFRvaluationViewController.h"
#import "DFInformationViewController.h"

@implementation DFBottomTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

#pragma mark Setter
- (void)setViewControllers:(NSMutableArray *)viewControllers
{
    _viewControllers = viewControllers;
}

- (void)setCellCanScroll:(BOOL)cellCanScroll
{
    _cellCanScroll = cellCanScroll;
    
    for (DFConstructionSiteViewController *VC in _viewControllers) {
        VC.vcCanScroll = cellCanScroll;

        if (!cellCanScroll) {//如果cell不能滑动，代表到了顶部，修改所有子vc的状态回到顶部
            VC.scrollView.contentOffset = CGPointZero;
        }
    }

    for (DFRvaluationViewController *VC in _viewControllers) {
        VC.vcCanScroll = cellCanScroll;

        if (!cellCanScroll) {//如果cell不能滑动，代表到了顶部，修改所有子vc的状态回到顶部
            VC.scrollView.contentOffset = CGPointZero;
        }
    }

    for (DFInformationViewController *VC in _viewControllers) {
        VC.vcCanScroll = cellCanScroll;

        if (!cellCanScroll) {//如果cell不能滑动，代表到了顶部，修改所有子vc的状态回到顶部
            VC.scrollView.contentOffset = CGPointZero;
        }
    }
//    for (GHAllDepartmentsViewController *VC in _viewControllers) {
//           VC.vcCanScroll = cellCanScroll;
//
//           if (!cellCanScroll) {//如果cell不能滑动，代表到了顶部，修改所有子vc的状态回到顶部
//               VC.scrollView.contentOffset = CGPointZero;
//           }
//       }
    
}

- (void)setIsRefresh:(BOOL)isRefresh
{
    _isRefresh = isRefresh;
    
//    for (GHNewReviewController *ctrl in self.viewControllers) {
//        if ([ctrl.title isEqualToString:self.currentTagStr]) {
//            ctrl.isRefresh = isRefresh;
//        }
//    }
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
