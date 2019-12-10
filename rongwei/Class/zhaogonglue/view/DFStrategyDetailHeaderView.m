//
//  DFStrategyDetailHeaderView.m
//  rongwei
//
//  Created by apple on 2019/11/26.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFStrategyDetailHeaderView.h"
#import <WebKit/WebKit.h>

@interface DFStrategyDetailHeaderView ()<WKNavigationDelegate , WKUIDelegate>
@property (nonatomic , strong)UIImageView *upimageview;
@property (nonatomic , strong)UIImageView *userimageview;
@property (nonatomic , strong)UILabel *namelabel;
@property (nonatomic , strong)UILabel *titlelabel;
@property (nonatomic , strong)UILabel *classlabel;
@property (nonatomic , strong)UILabel *looknumberlabel;
@property (nonatomic , strong)UILabel *timerlabel;
@property (nonatomic , strong)UIView *lineview;
@property (nonatomic , strong)WKWebView *wkWebView;
@property (nonatomic , assign)float thisHeight;


@end

@implementation DFStrategyDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {



        

    }
    return self;
}

- (void)setModel:(DFGongLueModel *)model
{
    _model = model;
    [self.upimageview sd_setImageWithURL:[NSURL URLWithString:model.bbs_pic] placeholderImage:nil];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, 44, 44)];
    backBtn.showsTouchWhenHighlighted = NO;
    [backBtn setImage:[UIImage imageNamed:@"Strategy_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickCancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backBtn];
    
    
     
    self.thisHeight += HScaleHeight(250);
    self.thisHeight += HScaleHeight(14);
     
     [self.userimageview sd_setImageWithURL:[NSURL URLWithString:model.bbs_user_image] placeholderImage:nil];
        
    self.thisHeight += HScaleHeight(15);
     
     self.namelabel.text = model.bbs_user_name;
    
    self.thisHeight += HScaleHeight(14.5);


     self.titlelabel.text = model.bbs_title;
    
    float titlelabelheighr = [self.titlelabel.text heightForFont:self.titlelabel.font width:ScreenW - HScaleWidth(34)];
    
    self.thisHeight += titlelabelheighr;

     
    self.thisHeight += HScaleHeight(9);
    
     self.classlabel.text = ISNIL(model.modelclass[@"name"]);

     float width = [self.classlabel.text widthForFont:self.classlabel.font];
     
     [self.classlabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(HScaleWidth(17));
         make.top.mas_equalTo(self.titlelabel.mas_bottom).offset(HScaleHeight(9));
         make.width.mas_equalTo(width + HScaleWidth(18));
     }];
     

    self.thisHeight += HScaleHeight(9);
    
    self.thisHeight += HScaleHeight(13.5);
     

     self.looknumberlabel.text = [NSString stringWithFormat:@"浏览  %@   |   收藏  %@",model.bbs_view,model.bbs_collect_num];

    self.thisHeight += HScaleHeight(12);
     
     self.timerlabel.text = model.updated_at;

    self.thisHeight += HScaleHeight(14.5);
     
     self.lineview.backgroundColor = [UIColor colorWithHexString:@"F7F7F7"];

    self.thisHeight += HScaleHeight(5);
    
     [self.wkWebView loadHTMLString:model.bbs_content baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    
    if (self.globalBlockInMemory) {
        self.globalBlockInMemory(self.thisHeight);
    }
}
- (void)clickCancelAction
{
    [self.viewController.navigationController popViewControllerAnimated:YES];
}

- (UIImageView *)upimageview
{
    if (!_upimageview) {
        _upimageview = [[UIImageView alloc]init];

        [self addSubview:_upimageview];
        
        [_upimageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(HScaleHeight(250));
        }];
    }
    return _upimageview;
}
- (UIImageView *)userimageview
{
    if (!_userimageview) {
        _userimageview = [[UIImageView alloc]init];
        _userimageview.layer.cornerRadius = 7.5;
        _userimageview.layer.masksToBounds = YES;
        [self addSubview:_userimageview];
       
        [_userimageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(17));
            make.top.mas_equalTo(self.upimageview.mas_bottom).offset(HScaleHeight(14));
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(15), HScaleHeight(15)));
        }];
    }
    return _userimageview;
}
- (UILabel *)namelabel
{
    if (!_namelabel) {
        _namelabel = [[UILabel alloc]init];
        _namelabel.font = HScaleFont(12);
        _namelabel.textColor = [UIColor colorWithHexString:@"999999"];
        [self addSubview:_namelabel];
        
        [_namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.userimageview.mas_right).offset(HScaleWidth(6));
            make.right.mas_equalTo(- HScaleWidth(30));
            make.centerY.mas_equalTo(self.userimageview.mas_centerY);
        }];
    }
    return _namelabel;
}
- (UILabel *)titlelabel
{
    if (!_titlelabel) {
        _titlelabel = [[UILabel alloc]init];
        _titlelabel.font = HScaleFont(15);
        _titlelabel.textColor = [UIColor colorWithHexString:@"333333"];
        _titlelabel.numberOfLines = 0;
        [self addSubview:_titlelabel];
        
        [_titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(17));
            make.right.mas_equalTo(-HScaleWidth(17));
            make.top.mas_equalTo(self.userimageview.mas_bottom).offset(HScaleHeight(HScaleHeight(14.5)));
        }];
    }
    return _titlelabel;
}
- (UILabel *)classlabel
{
    if (!_classlabel) {
        _classlabel = [[UILabel alloc]init];
        _classlabel.backgroundColor = [UIColor colorWithHexString:@"FFDEDF"];
        _classlabel.textColor = [UIColor colorWithHexString:@"DD1A21"];
        _classlabel.textAlignment = NSTextAlignmentCenter;
        _classlabel.font = HScaleFont(9);
        [self addSubview:_classlabel];
    }
    return _classlabel;
}
- (UILabel *)looknumberlabel
{
    if (!_looknumberlabel) {
        _looknumberlabel = [[UILabel alloc]init];
        _looknumberlabel.textColor = [UIColor colorWithHexString:@"999999"];
        _looknumberlabel.font = HScaleFont(12);
        [self addSubview:_looknumberlabel];
        
        [_looknumberlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleHeight(17));
            make.top.mas_equalTo(self.classlabel.mas_bottom).offset(HScaleHeight(9.5));
        }];
    }
    return _looknumberlabel;
    
}

- (UILabel *)timerlabel
{
    if (!_timerlabel) {
        _timerlabel = [[UILabel alloc]init];
        _timerlabel.textColor = [UIColor colorWithHexString:@"999999"];
        _timerlabel.textAlignment = NSTextAlignmentRight;
        _timerlabel.font = HScaleFont(12);
        [self addSubview:_timerlabel];
        
        [_timerlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-HScaleWidth(17));
            make.top.mas_equalTo(self.looknumberlabel.mas_top);
        }];
    }
    return _timerlabel;
}

- (UIView *)lineview
{
    if (!_lineview) {
        _lineview = [[UIView alloc]init];
        [self addSubview:_lineview];
        [_lineview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(HScaleHeight(5));
            make.top.mas_equalTo(self.looknumberlabel.mas_bottom).offset(HScaleHeight(14.5));
        }];
    }
    return _lineview;
}
- (WKWebView *)wkWebView
{
    if (!_wkWebView) {
//        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        //以下代码适配文本大小，由UIWebView换为WKWebView后，会发现字体小了很多，这应该是WKWebView与html的兼容问题，解决办法是修改原网页，要么我们手动注入JS
//        NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
        //用于进行JavaScript注入
//        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:nil injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
//        [config.userContentController addUserScript:wkUScript];
        
        
        _wkWebView = [[WKWebView alloc]initWithFrame:CGRectZero];// configuration:config];
        // 导航代理
//        _wkWebView.navigationDelegate = self;
//        _wkWebView.UIDelegate = self;
        _wkWebView.scrollView.scrollEnabled = NO;
        [self addSubview:_wkWebView];
        [_wkWebView addObserver:self forKeyPath:@"scrollView.contentSize" options:NSKeyValueObservingOptionNew context:nil];

        

        
        
        
        [_wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.lineview.mas_bottom);
//            make.height.mas_equalTo(HScaleHeight(300));
            make.bottom.mas_equalTo(self.bottom);
        }];
    }
    return _wkWebView;
}
// 使用kvo监听到的contensize变化，之所以在这里设置，因为webview加载的内容多的时候 是一段一段加载初开的，所以webview的contensize是实时变化的，所以在这里监听到可以以达到实时改变，不至于页面卡顿
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (object == self.wkWebView && [keyPath isEqual:@"scrollView.contentSize"]) {
        UIScrollView *scrollView = self.wkWebView.scrollView;
        CGSize size = CGSizeMake(ScreenW, scrollView.contentSize.height);
        [self.wkWebView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.lineview.mas_bottom);
            make.height.mas_equalTo(size.height);
        }];
        
//        self.thisHeight += size.height;

        if (self.globalBlockInMemory) {
            self.globalBlockInMemory(self.thisHeight + size.height);
//            [self.wkWebView removeObserver:self forKeyPath:@"scrollView.contentSize"];

        }
        
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
