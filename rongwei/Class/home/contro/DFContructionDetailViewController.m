//
//  DFContructionDetailViewController.m
//  rongwei
//
//  Created by apple on 2019/11/22.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFContructionDetailViewController.h"
#import "DFConstructionModel.h"

@interface DFContructionDetailViewController ()

@end

@implementation DFContructionDetailViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"找施工";
    
    UIButton *message = [UIButton buttonWithType:UIButtonTypeCustom];
    [message setTitleColor:UIColorHex(0x010101) forState:UIControlStateNormal];
    message.frame = CGRectMake(0, 0, HScaleWidth(83), 44);
    message.titleLabel.font = HScaleFont(12);
    [message setTitleColor:[UIColor colorWithHexString:@"DD1A21"] forState:UIControlStateNormal];
    [message setImage:[UIImage imageNamed:@"home_notice"] forState:UIControlStateNormal];
//    [message addTarget:self action:@selector(focusonThis) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtn1 = [[UIBarButtonItem alloc] initWithCustomView:message];
    self.navigationItem.rightBarButtonItem = rightBtn1;
    
    [self getConstruction];
}
//请求施工详情
- (void)getConstruction
{
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:CompanyDetail withParameter:nil withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
            
            NSArray *dataarry = response[@"data"];
            
//            for (NSInteger index = 0; index < dataarry.count; index ++) {
//                DFConstructionModel *model = [[DFConstructionModel alloc]initWithDictionary:dataarry[index] error:nil];
//                [self.constructionArry addObject:model];
//            }
//
//            self.header.dataArry = self.constructionArry;
        }
    }];
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
