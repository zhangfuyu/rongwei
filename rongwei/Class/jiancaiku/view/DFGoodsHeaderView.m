//
//  DFGoodsHeaderView.m
//  rongwei
//
//  Created by zhangfuyu on 2019/12/13.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFGoodsHeaderView.h"
#import <WebKit/WebKit.h>
#import "DFConfigurationView.h"
#import "DFStoreDetailViewController.h"
#import "SDCycleScrollView.h"


@interface DFGoodsHeaderView ()

@property (nonatomic , strong) UIView *selectView;

@property (nonatomic , strong) UIView *shopView;

@property (nonatomic , strong)WKWebView *wkWebView;

@property (nonatomic , assign)CGFloat selfHeight;

@property (nonatomic , assign)CGFloat wkwebviewContent;

@property (nonatomic , strong)DFGoodsDetailModel *detailModel;

@end

@implementation DFGoodsHeaderView

- (instancetype)initWithFrame:(CGRect)frame withModel:(DFGoodsDetailModel *)model
{
    if (self = [super initWithFrame:frame]) {
        
        
        self.detailModel = model;
        
        self.selfHeight = 0.0;
        
        self.wkwebviewContent = 0.0;
        
        
         SDCycleScrollView *scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0 , ScreenW, HScaleHeight(250)) delegate:self placeholderImage:[UIImage imageNamed:@""]];
         scrollView.autoScrollTimeInterval = 5;
         scrollView.layer.cornerRadius = HScaleHeight(5);
         scrollView.backgroundColor = [UIColor whiteColor];
         scrollView.currentPageDotColor = [UIColor whiteColor];
    //    scrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
         scrollView.pageDotColor = [UIColor colorWithWhite:1 alpha:0.6];
         scrollView.pageControlBottomOffset = 12;
         scrollView.pageDotColor = [UIColor colorWithWhite:1 alpha:.6];
         scrollView.currentPageDotColor = [UIColor whiteColor];
         scrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
         scrollView.imageSize = CGSizeMake(ScreenW, HScaleHeight(250));
         [self addSubview:scrollView];
        
        [scrollView setImageURLStringsGroup:model.infos[@"spu_thumb_json"]];
        
//        UIImageView *imageview = [[UIImageView alloc]init];
//        [imageview sd_setImageWithURL:[NSURL URLWithString:model.goods_thumb] placeholderImage:nil];
//        [self addSubview:imageview];
//
//        [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.left.right.mas_equalTo(0);
//            make.height.mas_equalTo(HScaleHeight(250));
//        }];
        
        self.selfHeight += HScaleHeight(250);
        
        self.selfHeight += HScaleHeight(17.5);
        
        UILabel *nameLaebl = [[UILabel alloc]init];
        nameLaebl.font = HScaleFont(15);
        nameLaebl.textColor = [UIColor colorWithHexString:@"333333"];
        nameLaebl.numberOfLines = 0;
        [self addSubview:nameLaebl];
        
        nameLaebl.text = model.goods_name;
        
        CGFloat nameLebelHeight = [nameLaebl.text heightForFont:nameLaebl.font width:ScreenW - HScaleWidth(38)];
        
        self.selfHeight += nameLebelHeight;
        
        [nameLaebl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(19));
            make.right.mas_equalTo(-HScaleWidth(19));
            make.top.mas_equalTo(scrollView.mas_bottom).offset(HScaleHeight(17.5));
            
        }];
        
        
        UILabel *subTitleLabel = [[UILabel alloc]init];
        nameLaebl.font = HScaleFont(12);
        nameLaebl.textColor = [UIColor colorWithHexString:@"999999"];
        nameLaebl.numberOfLines = 0;
        [self addSubview:nameLaebl];
        
        [self addSubview:subTitleLabel];
        
        [subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(19));
            make.right.mas_equalTo(-HScaleWidth(19));
            make.top.mas_equalTo(nameLaebl.mas_bottom).offset(HScaleHeight(15.5));
            make.height.mas_equalTo(0);
        }];
        
        self.selfHeight += HScaleHeight(15);
        
        
        UILabel *lowprice = [[UILabel alloc]init];
        lowprice.textColor = [UIColor colorWithHexString:@"DD1A21"];
        lowprice.font = HScaleBoldFont(15);
        [self addSubview:lowprice];
        
        lowprice.text = [NSString stringWithFormat:@"￥%@",model.low_price];
        
        [lowprice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(19));
            make.top.mas_equalTo(nameLaebl.mas_bottom).offset(HScaleHeight(15));
            make.height.mas_equalTo(HScaleHeight(18.5));
        }];
        
        self.selfHeight += HScaleHeight(18.5);
        
        
        UILabel *lineprice = [[UILabel alloc]init];
        lineprice.textColor = [UIColor colorWithHexString:@"999999"];
        lineprice.font = HScaleFont(12);
        [self addSubview:lineprice];
        
        if ([model.line_price floatValue] > 0) {
            NSString *lineLabelText = [NSString stringWithFormat:@"￥%@",model.line_price];

            //中划线
            NSDictionary *attribtDic1 = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
            NSMutableAttributedString *attribtStr1 = [[NSMutableAttributedString alloc]initWithString:lineLabelText attributes:attribtDic1];
            
            lineprice.attributedText = attribtStr1;
        }
        

        
        
        [lineprice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lowprice.mas_right).offset(HScaleWidth(10.5));
            make.bottom.mas_equalTo(lowprice.mas_bottom);
        }];
        
        
        
        UILabel *payNumberLabel = [[UILabel alloc]init];
        payNumberLabel.font = HScaleFont(12);
        payNumberLabel.textColor = [UIColor colorWithHexString:@"999999"];
        payNumberLabel.textAlignment = NSTextAlignmentRight;
        payNumberLabel.text = [NSString stringWithFormat:@"已售%d",[model.sales_actual intValue] + [model.sales_initial intValue]];
        [self addSubview:payNumberLabel];
        
        
        [payNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-HScaleWidth(19));
            make.bottom.mas_equalTo(lowprice.mas_bottom);
        }];
        
        self.selfHeight += HScaleHeight(8.5);

        
        NSArray *spu_tipsArry = model.infos[@"spu_tips"];
        if (spu_tipsArry.count > 0) {
            
            
            CGFloat withSize = HScaleWidth(19);
            
            for (NSInteger index = 0; index < spu_tipsArry.count; index ++) {
                UILabel *tipsLabel = [[UILabel alloc]init];
                tipsLabel.layer.cornerRadius = HScaleWidth(2.5);
                tipsLabel.layer.borderWidth = HScaleWidth(.5);
                tipsLabel.layer.borderColor = [UIColor colorWithHexString:@"DD1A21"].CGColor;
                tipsLabel.textColor = [UIColor colorWithHexString:@"DD1A21"];
                tipsLabel.font = HScaleFont(9);
                tipsLabel.textAlignment = NSTextAlignmentCenter;
                tipsLabel.text = spu_tipsArry[index];
                [self addSubview:tipsLabel];
                
                CGFloat labelwith = [tipsLabel.text widthForFont:tipsLabel.font] + HScaleWidth(16);
                
                
                [tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(withSize);
                    make.top.mas_equalTo(lowprice.mas_bottom).offset(HScaleHeight(8.5));
                    make.width.mas_equalTo(labelwith);
                    make.height.mas_equalTo(HScaleHeight(17));
                }];
                
                withSize += labelwith;
                withSize += HScaleWidth(3);
            }
            

        }
        
        self.selfHeight += HScaleHeight(17);

        
        UIButton *collection = [UIButton buttonWithType:UIButtonTypeCustom];
        [collection setTitleColor:UIColorHex(0x010101) forState:UIControlStateNormal];
        collection.frame = CGRectMake(0, 0, HScaleWidth(78), HScaleHeight(17));
        collection.titleLabel.font = HScaleFont(12);
        [collection setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        [collection setTitle:@"  收藏" forState:UIControlStateNormal];
        [collection setImage:[UIImage imageNamed:@"no_Focus_on"] forState:UIControlStateNormal];
        [collection setImage:[UIImage imageNamed:@"Focus_on"] forState:UIControlStateSelected];
//        [collection addTarget:self action:@selector(focusonThis) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:collection];
        
        [collection mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(lowprice.mas_bottom).offset(8.5);
            make.right.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(78), HScaleHeight(17)));
        }];
        
        self.selfHeight += HScaleHeight(17);

        
        
        
        UIView *firstLineview = [[UIView alloc]init];
        firstLineview.backgroundColor = [UIColor colorWithHexString:@"F7F7F7"];
        [self addSubview:firstLineview];
        
        [firstLineview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.selfHeight);
            make.height.mas_equalTo(HScaleHeight(5));
        }];
        
        self.selfHeight += HScaleHeight(5);
        
        
        
        
        //优惠券
        UILabel *delivery = [[UILabel alloc]init];
        delivery.text = @"发货";
        delivery.textColor = [UIColor colorWithHexString:@"999999"];
        delivery.font = HScaleFont(12);
        [self addSubview:delivery];
        
        [delivery mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(19));
            make.top.mas_equalTo(firstLineview.mas_bottom);
            make.height.mas_equalTo(HScaleHeight(40));
        }];
        
        
        UILabel *address = [[UILabel alloc]init];
//        address.text = @"浙江 丽水    |     快递: 0:00 ";
        address.text = [NSString stringWithFormat:@"%@   |     快递: 0:00 ",model.shopDetailModel.address];
        address.textColor = [UIColor colorWithHexString:@"333333"];
        address.font = HScaleFont(12);
        [self addSubview:address];
        
        [address mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(89));
            make.top.mas_equalTo(delivery.mas_top);
            make.bottom.mas_equalTo(delivery.mas_bottom);
        }];
        
        
        UIImageView *addressImage = [[UIImageView alloc]init];
        addressImage.image = [UIImage imageNamed:@"weizhi"];
        [self addSubview:addressImage];
        
        [addressImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(74));
            make.centerY.mas_equalTo(delivery.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(9.5), HScaleHeight(11.5)));
        }];
        
        self.selfHeight += HScaleHeight(40);
        
        UIView *secondlineview = [[UIView alloc]init];
        secondlineview.backgroundColor = [UIColor colorWithHexString:@"F7F7F7"];

        [self addSubview:secondlineview];
        
        [secondlineview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(delivery.mas_bottom);
            make.height.mas_equalTo(HScaleHeight(.5));
        }];
        
        self.selfHeight += HScaleHeight(.5);
        
        
        
        self.selectView = [[UIView alloc]init];
        [self addSubview:self.selectView];
        
        [self.selectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(secondlineview.mas_bottom);
            make.height.mas_equalTo(HScaleHeight(40));
        }];
        
        UILabel *choose = [[UILabel alloc]init];
        choose.text = @"选择";
        choose.textColor = [UIColor colorWithHexString:@"999999"];
        choose.font = HScaleFont(12);
        [self.selectView addSubview:choose];
        
        [choose mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(19));
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(HScaleHeight(40));
        }];
        
        UILabel *numberPace = [[UILabel alloc]init];
        numberPace.text = @"规格数量";
        numberPace.textColor = [UIColor colorWithHexString:@"333333"];
        numberPace.font = HScaleFont(12);
        [self.selectView addSubview:numberPace];
        
        [numberPace mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(89));
            make.top.mas_equalTo(choose.mas_top);
            make.bottom.mas_equalTo(choose.mas_bottom);
        }];
        
        
//        UIView *threelineview = [[UIView alloc]init];
//        threelineview.backgroundColor = [UIColor colorWithHexString:@"F7F7F7"];
//
//        [self.selectView addSubview:threelineview];
//
//        [threelineview mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.mas_equalTo(0);
//            make.bottom.mas_equalTo(self.selectView.mas_bottom);
//            make.height.mas_equalTo(HScaleHeight(.5));
//        }];
        
        self.selfHeight += HScaleHeight(40);
        
        
        
        UIView *fourLineview = [[UIView alloc]init];
        fourLineview.backgroundColor = [UIColor colorWithHexString:@"F7F7F7"];
        [self addSubview:fourLineview];
        
        [fourLineview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.selfHeight);
            make.height.mas_equalTo(HScaleHeight(5));
        }];
        
        self.selfHeight += HScaleHeight(5);
        
        
        
        NSArray *titleArry = [NSArray arrayWithObjects:@"正品保障",@"正规厂家",@"先行赔付",@"假一赔十", nil];
        NSArray *imageArry = [NSArray arrayWithObjects:@"goods_baozhang",@"goods_tubiaolunkuo-",@"goods_wendingyunliquechepeifu",@"goods_jiayipeishi", nil];

        for (NSInteger index = 0; index < titleArry.count; index ++) {
            UIButton *lookView = [UIButton buttonWithType:UIButtonTypeCustom];
            lookView.titleLabel.font = HScaleFont(12);
            [lookView setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
            [lookView setTitle:titleArry[index] forState:UIControlStateNormal];
            [lookView setImage:[UIImage imageNamed:imageArry[index]] forState:UIControlStateNormal];
//            [lookView setImage:[UIImage imageNamed:@"Focus_on"] forState:UIControlStateSelected];
    //        [collection addTarget:self action:@selector(focusonThis) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:lookView];

            [lookView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(fourLineview.mas_bottom);
                make.left.mas_equalTo(ScreenW / 4 * index);
                make.size.mas_equalTo(CGSizeMake(ScreenW / 4, HScaleHeight(41.5)));
            }];
        }

        self.selfHeight += HScaleHeight(41.5);



        UIView *fiveLineview = [[UIView alloc]init];
        fiveLineview.backgroundColor = [UIColor colorWithHexString:@"F7F7F7"];
        [self addSubview:fiveLineview];

        [fiveLineview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.selfHeight);
            make.height.mas_equalTo(HScaleHeight(5));
        }];

        self.selfHeight += HScaleHeight(5);

        self.commentSet = self.selfHeight;
        
        
        
        
        
        /****暂无评论**********/
        
        UILabel *commentLabel = [[UILabel alloc]init];
        commentLabel.font = HScaleBoldFont(12);
        commentLabel.textColor = [UIColor colorWithHexString:@"333333"];
        commentLabel.text = @"暂无评论";
        [self addSubview:commentLabel];
        
        [commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(17.5));
            make.top.mas_equalTo(fiveLineview.mas_bottom).offset(HScaleHeight(15));
        }];
        
        
        UIImageView *commentImage = [[UIImageView alloc]init];
        commentImage.image = [UIImage imageNamed:@"goods_zanwu"];
        [self addSubview:commentImage];
        
        [commentImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(fiveLineview.mas_bottom).offset(HScaleHeight(51));
            make.left.mas_equalTo(HScaleWidth(126.5));
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(34), HScaleHeight(30.5)));
        }];
        
        
        UILabel *noComment = [[UILabel alloc]init];
        noComment.font = HScaleBoldFont(12);
        noComment.textColor = [UIColor colorWithHexString:@"999999"];
        noComment.text = @"没有相应的评价";
        [self addSubview:noComment];
        
        [noComment mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(commentImage.mas_right).offset(HScaleWidth(5.5));
            make.top.mas_equalTo(commentImage.mas_top).offset(HScaleHeight(2.5));
        }];
        
        
        UILabel *noCommentSub = [[UILabel alloc]init];
        noCommentSub.font = HScaleFont(9);
        noCommentSub.textColor = [UIColor colorWithHexString:@"999999"];
        noCommentSub.text = @"看看其他的~";
        [self addSubview:noCommentSub];
        
        [noCommentSub mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(commentImage.mas_right).offset(HScaleWidth(5.5));
            make.bottom.mas_equalTo(commentImage.mas_bottom).offset(-HScaleHeight(2.5));
        }];
        
        
        self.selfHeight += HScaleHeight(108);
        
        
        self.detailSet = self.selfHeight;
        
        
        
        self.shopView = [[UIView alloc]init];
        self.shopView.backgroundColor = [UIColor colorWithHexString:@"F7F7F7"];
        [self addSubview:self.shopView];
        
        [self.shopView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.selfHeight);
            make.height.mas_equalTo(HScaleHeight(110));
        }];
        
        
        
        UIImageView *shopimageview = [[UIImageView alloc]init];
        [shopimageview sd_setImageWithURL:[NSURL URLWithString:model.shopDetailModel.logo_image] placeholderImage:nil];
        [self.shopView addSubview:shopimageview];
        
        [shopimageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(16));
            make.top.mas_equalTo(HScaleHeight(20.5));
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(49), HScaleHeight(49)));
        }];
        
        
        UILabel *storeName = [[UILabel alloc]init];
        storeName.font = HScaleFont(15);
        storeName.textColor = [UIColor colorWithHexString:@"333333"];
        storeName.text = model.shopDetailModel.shop_name;
        [self.shopView addSubview:storeName];
        
        
        [storeName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(shopimageview.mas_right).offset(HScaleWidth(15.5));
            make.top.mas_equalTo(shopimageview.mas_top);
            make.right.mas_equalTo(-HScaleWidth(80));
        }];
        
        UILabel *businessLabel = [[UILabel alloc]init];
        businessLabel.font = HScaleFont(9);
        businessLabel.textColor = [UIColor colorWithHexString:@"999999"];
        businessLabel.text = [NSString stringWithFormat:@"主营业务  %@",model.shopDetailModel.shop_category];
        [self.shopView addSubview:businessLabel];
        
        [businessLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(storeName.mas_bottom).offset(HScaleHeight(14.5));
            make.left.mas_equalTo(storeName.mas_left);
            make.right.mas_equalTo(-HScaleWidth(20));
        }];
        
        
        UIButton *intoTheShop = [UIButton buttonWithType:UIButtonTypeCustom];
        [intoTheShop setTitle:@"进店逛逛" forState:UIControlStateNormal];
        [intoTheShop setTitleColor:[UIColor colorWithHexString:@"DD1A21"] forState:UIControlStateNormal];
        intoTheShop.titleLabel.font = HScaleFont(11);
        intoTheShop.layer.borderWidth = HScaleWidth(.5);
        intoTheShop.layer.cornerRadius = HScaleWidth(1);
        intoTheShop.layer.borderColor = [UIColor colorWithHexString:@"DD1A21"].CGColor;
        [intoTheShop addTarget:self action:@selector(clickIntoTheShop) forControlEvents:UIControlEventTouchUpInside];
        [self.shopView addSubview:intoTheShop];
        
        
        [intoTheShop mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-HScaleWidth(14));
            make.top.mas_equalTo(HScaleHeight(21.5));
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(63.5), HScaleHeight(18)));
        }];
        
        
        
        NSArray *scoreArry = [NSArray arrayWithObjects:@"商品描述",@"卖家服务",@"物流服务", nil];
        NSArray *scoreNumberArry = [NSArray arrayWithObjects:model.shopDetailModel.description_score,model.shopDetailModel.service_score,model.shopDetailModel.logistics_score, nil];
        
        for (NSInteger index = 0; index < scoreArry.count; index ++) {
            UILabel *scoreLabel = [[UILabel alloc]init];
            scoreLabel.font = HScaleFont(12);
            scoreLabel.textAlignment = NSTextAlignmentCenter;
            scoreLabel.textColor = [UIColor colorWithHexString:@"999999"];
            scoreLabel.attributedText = [self changewithText:scoreArry[index] withScore:scoreNumberArry[index]];
            [self.shopView addSubview:scoreLabel];
            
            
            [scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(ScreenW / 3 * index);
                make.top.mas_equalTo(shopimageview.mas_bottom).offset(HScaleHeight(13.5));
                make.width.mas_equalTo(ScreenW/ 3);
            }];
        }
        
        UIView *sixLineview = [[UIView alloc]init];
        sixLineview.backgroundColor = [UIColor colorWithHexString:@"E5E5E5"];
        [self.shopView addSubview:sixLineview];

        [sixLineview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(self.shopView.mas_bottom);
            make.height.mas_equalTo(HScaleHeight(.5));
        }];
        
        
        self.selfHeight += HScaleHeight(110);
        
        
        if (((NSString *)model.infos[@"content"]).length > 0) {
            
            self.wkWebView = [[WKWebView alloc]initWithFrame:CGRectZero];// configuration:config];
            // 导航代理
    //        _wkWebView.navigationDelegate = self;
    //        _wkWebView.UIDelegate = self;
            self.wkWebView.scrollView.scrollEnabled = NO;
            self.wkWebView.backgroundColor = [UIColor colorWithHexString:@"F7F7F7"];
            [self.wkWebView loadHTMLString:model.infos[@"content"] baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];

            [self addSubview:self.wkWebView];
            [self.wkWebView addObserver:self forKeyPath:@"scrollView.contentSize" options:NSKeyValueObservingOptionNew context:nil];

            


            
            
            [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(0);
                make.top.mas_equalTo(self.shopView.mas_bottom);
                make.bottom.mas_equalTo(self.bottom);
            }];
            
            
        }
        
        self.frame = CGRectMake(0, 0, ScreenW, self.selfHeight);
        
        
        
        
        

        
    }
    return self;
}
- (void)clickIntoTheShop
{
    DFStoreDetailViewController *store = [[DFStoreDetailViewController alloc]init];
    store.store_id = self.detailModel.shop_id;
    [self.viewController.navigationController pushViewController:store animated:YES];
}
// 使用kvo监听到的contensize变化，之所以在这里设置，因为webview加载的内容多的时候 是一段一段加载初开的，所以webview的contensize是实时变化的，所以在这里监听到可以以达到实时改变，不至于页面卡顿
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (object == self.wkWebView && [keyPath isEqual:@"scrollView.contentSize"]) {
        UIScrollView *scrollView = self.wkWebView.scrollView;
        CGSize size = CGSizeMake(ScreenW, scrollView.contentSize.height);
        
        [self.wkWebView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.shopView.mas_bottom);
            make.height.mas_equalTo(size.height);
        }];
    
        self.wkwebviewContent = size.height;
//        self.frame = CGRectMake(0, 0, ScreenW, self.selfHeight + size.height);
        
        dispatch_async(dispatch_get_main_queue(), ^{
                   
            if (self.globalBlockInMemory) {
                self.globalBlockInMemory(self.selfHeight + size.height);
            }
        });
        


    }
}

- (NSMutableAttributedString *)changewithText:(NSString *)text withScore:(NSString *)score
{
    NSInteger scorenumber = score.intValue;
    
    NSString *rellyScore = @"";
    
    NSString *showText = @"";
    
    UIColor *showColor;
    
    if (scorenumber == 1  || scorenumber == 2) {
        rellyScore = [NSString stringWithFormat:@"  %ld  差评",scorenumber];
        showColor = [UIColor colorWithHexString:@"02C90B"];
        
    }
    else if (scorenumber == 3)
    {
        rellyScore = [NSString stringWithFormat:@"  %ld  中评",scorenumber];
        showColor = [UIColor colorWithHexString:@"FFA700"];

    }
    else
    {
        rellyScore = [NSString stringWithFormat:@"  %ld  好评",scorenumber];
        showColor = [UIColor colorWithHexString:@"DD1A21"];

    }
    
    showText = [NSString stringWithFormat:@"%@%@",text,rellyScore];
    
    
    NSRange range = [showText rangeOfString:rellyScore];
    

    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:showText];
    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"999999"] range:NSMakeRange(0,range.location)];
    [attri addAttribute:NSForegroundColorAttributeName value:showColor range:NSMakeRange(range.location,range.length)];
    
    return attri;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    UITouch * touch = touches.anyObject;//获取触摸对象

    
    if (touch.view == self.selectView) {
        
        DFConfigurationView *chooseView = [[DFConfigurationView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) WithModel:self.detailModel];
        
        [self.viewController.view addSubview:chooseView];

        
    }
}

@end
