//
//  DFAllImageViewController.m
//  rongwei
//
//  Created by zhangfuyu on 2020/1/8.
//  Copyright © 2020 zhangfuyu. All rights reserved.
//

#import "DFAllImageViewController.h"

@interface DFAllImageViewController ()

@end

@implementation DFAllImageViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIScrollView *scroview = [[UIScrollView alloc]init];
    [self.view addSubview:scroview];
    
    [scroview mas_makeConstraints:^(MASConstraintMaker *make) {

//        make.edges.equalTo(self.view).mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(kNavBarAndStatusBarHeight);
        make.bottom.mas_equalTo(-kBottomSafeHeight);
       
    }];
    
    UIImage *image = [UIImage imageNamed:self.imageName];
    
    CGFloat imageHeight = image.size.width / ScreenW * image.size.height;
    
    UIImageView *bigImageview = [[UIImageView alloc]init];
//    bigImageview.contentMode = UIViewContentModeRedraw;

    bigImageview.image = image;
    [scroview addSubview:bigImageview];
    
    [bigImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.width.mas_equalTo(ScreenW);
        if ([self.title isEqualToString:@"看直播"]) {
                    make.height.mas_equalTo(HScaleHeight(764));

        }
        else if ([self.title isEqualToString:@"要监理"])
        {
            make.height.mas_equalTo(HScaleHeight(1490));

        }
        else
        {
            make.height.mas_equalTo(HScaleHeight(1107));

        }

        make.bottom.equalTo(scroview).mas_equalTo(0);


    }];
    
    
//    [scroview mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.right.mas_equalTo(0);
//        make.bottom.mas_equalTo(bigImageview.mas_bottom);
//    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
