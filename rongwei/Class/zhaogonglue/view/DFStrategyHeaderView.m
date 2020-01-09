//
//  DFStrategyHeaderView.m
//  rongwei
//
//  Created by apple on 2019/10/18.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFStrategyHeaderView.h"
#import "DFHomeNavModel.h"
#import "DFFoundConstructionViewController.h"
#import "DFStrategyDetailViewController.h"

@interface DFStrategyHeaderView ()

@property (nonatomic , strong)UIImageView *three;
@property (nonatomic , strong)UIImageView *four;

@end

@implementation DFStrategyHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIImageView *first = [[UIImageView alloc]init];
        first.image = [UIImage imageNamed:@"找设计入口 （合并）"];
        first.tag = 101;
        first.userInteractionEnabled = YES;
        [self addSubview:first];
        
        UITapGestureRecognizer *noneTapGR1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectread:)];
        [first addGestureRecognizer:noneTapGR1];
        
        [first mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(10));
            make.top.mas_equalTo(HScaleHeight(10));
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(175), HScaleHeight(50)));
        }];
        
        UIImageView *secondimage = [[UIImageView alloc]init];
        secondimage.image = [UIImage imageNamed:@"找施工入口（合并）"];
        [self addSubview:secondimage];
        secondimage.tag = 102;
        secondimage.userInteractionEnabled = YES;
        UITapGestureRecognizer *noneTapGR2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectread:)];
        [secondimage addGestureRecognizer:noneTapGR2];
        
        [secondimage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(first.mas_right).offset(HScaleWidth(10));
            make.top.mas_equalTo(first.mas_top);
            make.right.mas_equalTo(-HScaleWidth(10));
            make.bottom.mas_equalTo(first.mas_bottom);
        }];
        
        self.three = [[UIImageView alloc]init];
        self.three.backgroundColor = [UIColor orangeColor];
        self.three.tag = 103;
        self.three.userInteractionEnabled = YES;
        [self addSubview:self.three];
        
        UITapGestureRecognizer *noneTapGR3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectread:)];
        [self.three addGestureRecognizer:noneTapGR3];
        
        [self.three mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(first.mas_left);
            make.top.mas_equalTo(first.mas_bottom).offset(HScaleHeight(10));
            make.right.mas_equalTo(first.mas_right);
            make.height.mas_equalTo(HScaleHeight(70));
        }];
        
        self.four = [[UIImageView alloc]init];
        self.four.backgroundColor = [UIColor orangeColor];
        self.four.tag = 104;
        self.four.userInteractionEnabled = YES;
        [self addSubview:self.four];
        
        UITapGestureRecognizer *noneTapGR4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectread:)];
        [self.four addGestureRecognizer:noneTapGR4];
        
        [self.four mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(secondimage.mas_left);
            make.top.mas_equalTo(secondimage.mas_bottom).offset(HScaleHeight(10));
            make.right.mas_equalTo(secondimage.mas_right);
            make.height.mas_equalTo(HScaleHeight(70));

        }];
    }
    return self;
}
- (void)selectread:(UITapGestureRecognizer *)tap
{
    switch (tap.view.tag) {
        case 101:
            {
                
            }
            break;
            case 102:
                {
                    [self.viewController.navigationController pushViewController:[DFFoundConstructionViewController new] animated:YES];

                }
                break;
            case 103:
                {
                    DFHomeNavModel *first = self.hotarry[0];
                    
                    [[DFUserModelTool shareInstance] formeController:self.viewController withModel:first];
                    
//                    DFStrategyDetailViewController *detail = [[DFStrategyDetailViewController alloc]init];
//                    detail.modelid = first.modelid;
//                    [self.viewController.navigationController pushViewController:detail animated:YES];
                }
                break;
            case 104:
                {
                    DFHomeNavModel *first = self.hotarry[1];
                    [[DFUserModelTool shareInstance] formeController:self.viewController withModel:first];

                    
//                    DFStrategyDetailViewController *detail = [[DFStrategyDetailViewController alloc]init];
//                    detail.modelid = first.modelid;
//                    [self.viewController.navigationController pushViewController:detail animated:YES];
                }
                break;
            
        default:
            break;
    }
}

- (void)setHotarry:(NSMutableArray *)hotarry
{
    _hotarry = hotarry;
    
    if (hotarry.count > 0) {
     
        DFHomeNavModel *first = hotarry[0];
        [self.three sd_setImageWithURL:[NSURL URLWithString:first.pic_url] placeholderImage:nil];
        
        DFHomeNavModel *second = hotarry[1];
        [self.four sd_setImageWithURL:[NSURL URLWithString:second.pic_url] placeholderImage:nil];
    }

}

@end
