//
//  DFFoundConstructionViewController.m
//  rongwei
//
//  Created by apple on 2019/11/20.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFFoundConstructionViewController.h"
#import "DFTextField.h"
#import "DfConstructionHeadrView.h"

@interface DFFoundConstructionViewController ()

@property (nonatomic , strong) DFTextField *searchTextField;

@end

@implementation DFFoundConstructionViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"找施工";
    [self setupNavigationBar];
}
- (void)setupNavigationBar
{

    UIView *navigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, kNavBarAndStatusBarHeight)];
    navigationView.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
//    [self.navigationController.navigationBar addSubview:navigationView];
    [self.view addSubview:navigationView];

//    self.navigationView = navigationView;

    self.searchTextField = [[DFTextField alloc]initWithFrame:CGRectZero];
    self.searchTextField.backgroundColor = [UIColor colorWithHexString:@"F4F4F4"];
    self.searchTextField.layer.cornerRadius = 14;
    self.searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.searchTextField.userInteractionEnabled = YES;
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"找施工" attributes:
    @{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"999999"],
                 NSFontAttributeName:[UIFont systemFontOfSize:12]
         }];
    self.searchTextField.enabled = YES;
    self.searchTextField.attributedPlaceholder = attrString;
    self.searchTextField.font = [UIFont systemFontOfSize:12];
//    searchTextField.delegate = self;
    self.searchTextField.textColor = [UIColor blackColor];
    self.searchTextField.returnKeyType = UIReturnKeySearch;
//    searchTextField.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.24].CGColor;
//    searchTextField.layer.shadowOffset = CGSizeMake(0,2);
//    searchTextField.layer.shadowOpacity = 1;
//    searchTextField.layer.shadowRadius = 4;
    

    [navigationView addSubview:self.searchTextField];
                                                                      
    [self.searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(8 +kStatusBarHeight);
        make.left.mas_equalTo(HScaleWidth(62.5));
        make.height.mas_equalTo(28);
        make.right.mas_equalTo(-HScaleWidth(62.5));
    }];
                                                                      
    self.searchTextField.leftSpace = 29;

    UIView *lefrview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 14 + 15, 28)];
                                      
    UIImageView *searchIconImageView = [[UIImageView alloc] init];
    searchIconImageView.contentMode = UIViewContentModeCenter;
    searchIconImageView.image = [UIImage imageNamed:@"sousuo"];

    [lefrview addSubview:searchIconImageView];
    
    [searchIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(14);
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.centerY.mas_equalTo(lefrview.mas_centerY);
    }];
    
    [self.searchTextField addSubview:lefrview];


//    [searchTextField addTarget:self action:@selector(clickSearchAction) forControlEvents:UIControlEventEditingDidEndOnExit];




    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];

    [searchButton setImage:[UIImage imageNamed:@"home_notice"] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(clickSearchAction) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:searchButton];

    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.searchTextField.mas_right);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(kStatusBarHeight);
        make.right.mas_equalTo(0);
    }];
    
    

    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, 44, 44)];
    backBtn.showsTouchWhenHighlighted = NO;
    [backBtn setImage:[UIImage imageNamed:@"login_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickCancelAction) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:backBtn];



}
- (void)clickSearchAction
{
    
}
- (void)clickCancelAction
{
    [self.navigationController popViewControllerAnimated:YES];
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
