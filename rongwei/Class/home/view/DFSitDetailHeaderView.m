//
//  DFSitDetailHeaderView.m
//  rongwei
//
//  Created by zhangfuyu on 2019/12/4.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFSitDetailHeaderView.h"
#import "DFEsignerDetialViewController.h"

@interface DFSitDetailHeaderView ()

@property (nonatomic , strong) DFDesignerModel *detailModel;

@end

@implementation DFSitDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame withmodel:(DFDesignerModel *)model
{
    if (self = [super initWithFrame:frame]) {
        
        self.detailModel = model;
        
        UIImageView *headerimageview = [[UIImageView alloc]init];
        [headerimageview sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"shejishi (1)"]];
        [self addSubview:headerimageview];
        
        [headerimageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(10));
            make.top.mas_equalTo(15);
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(40), HScaleHeight(40)));
        }];
        
        UILabel *nameLabel = [[UILabel alloc]init];
        nameLabel.font = HScaleBoldFont(15);
        nameLabel.textColor = [UIColor colorWithHexString:@"333333"];
        [self addSubview:nameLabel];
        
        nameLabel.text = model.name;
        
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(headerimageview.mas_right).offset(HScaleWidth(15.5));
            make.top.mas_equalTo(HScaleHeight(17.5));
        }];
        
        UILabel *workYearLabel = [[UILabel alloc]init];
        workYearLabel.textColor = [UIColor colorWithHexString:@"C82126"];
        workYearLabel.backgroundColor = [UIColor colorWithHexString:@"FDE8EF"];
        workYearLabel.font = HScaleFont(10);
        workYearLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:workYearLabel];
        
        workYearLabel.text = [NSString stringWithFormat:@"%d年经验",[model.years intValue]];
        
        [workYearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(nameLabel.mas_right).offset(HScaleWidth(8));
            make.top.mas_equalTo(HScaleHeight(17));
            make.width.mas_equalTo(HScaleWidth(55));

        }];
        
        
        NSString *number = [NSString stringWithFormat:@"%@",model.works_num.length > 0 ? model.works_num : @"0"];
        NSString *looknum = [NSString stringWithFormat:@"%@",model.comment_num.length > 0 ? model.comment_num : @"0"];
        NSString *appointmentnum = [NSString stringWithFormat:@"%@",model.appointment_num.length > 0 ? model.appointment_num : @"0"];

        
        UILabel *subdetailelabel = [[UILabel alloc]init];
        subdetailelabel.textColor = [UIColor colorWithHexString:@"A5A5A5"];
        subdetailelabel.font = HScaleBoldFont(11);
        subdetailelabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:subdetailelabel];
        
        NSString *subdetailtext = [NSString stringWithFormat:@"%@套作品  %@次评价  %@人预约",number,looknum,appointmentnum];
        
        NSMutableAttributedString *attritext = [[NSMutableAttributedString alloc]initWithString:subdetailtext];
        NSRange range = [subdetailtext rangeOfString:number];
        NSRange range1 = [subdetailtext rangeOfString:looknum];
        NSRange range2 = [subdetailtext rangeOfString:appointmentnum];
        
        [attritext addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"D25C63"]} range:range];
        [attritext addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"D25C63"]} range:range1];
        [attritext addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"D25C63"]} range:range2];
        subdetailelabel.attributedText = attritext;
        
        [subdetailelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(nameLabel.mas_left);
            make.bottom.mas_equalTo(headerimageview.mas_bottom).offset(-HScaleHeight(4));
            
        }];
        
        
        UILabel *titlelabel = [[UILabel alloc]init];
        titlelabel.textColor = [UIColor colorWithHexString:@"333333"];
        titlelabel.font = HScaleBoldFont(12);
        titlelabel.text = @"同设计师其他案例";
        titlelabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titlelabel];
        
        [titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(headerimageview.mas_left);
            make.bottom.mas_equalTo(self.mas_bottom).offset(-HScaleHeight(12));
        }];

        
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    DFEsignerDetialViewController *detail = [[DFEsignerDetialViewController alloc]init];
    detail.model = self.detailModel;
    [self.viewController.navigationController pushViewController:detail animated:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
