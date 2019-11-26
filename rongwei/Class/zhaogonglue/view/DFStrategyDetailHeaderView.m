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

@property (nonatomic , strong)WKWebView *wkWebView;

@end

@implementation DFStrategyDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame withModel:(DFGongLueModel *)model
{
    if (self = [super initWithFrame:frame])
    {
        UIImageView *upimageview = [[UIImageView alloc]init];
        [upimageview sd_setImageWithURL:[NSURL URLWithString:model.bbs_pic] placeholderImage:nil];
        [self addSubview:upimageview];
        
        [upimageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(HScaleHeight(250));
        }];
        
        UIImageView *userimageview = [[UIImageView alloc]init];
        [userimageview sd_setImageWithURL:[NSURL URLWithString:model.bbs_user_image] placeholderImage:nil];
        userimageview.layer.cornerRadius = 7.5;
        userimageview.layer.masksToBounds = YES;
        [self addSubview:userimageview];
        
        [userimageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(17));
            make.top.mas_equalTo(upimageview.mas_bottom).offset(HScaleHeight(14));
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(15), HScaleHeight(15)));
        }];
        
        
        UILabel *namelabel = [[UILabel alloc]init];
        namelabel.font = HScaleFont(12);
        namelabel.textColor = [UIColor colorWithHexString:@"999999"];
        namelabel.text = model.bbs_user_name;
        [self addSubview:namelabel];
        
        [namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(userimageview.mas_right).offset(HScaleWidth(6));
            make.right.mas_equalTo(- HScaleWidth(30));
            make.centerY.mas_equalTo(userimageview.mas_centerY);
        }];
        
        UILabel *titlelabel = [[UILabel alloc]init];
        titlelabel.font = HScaleFont(15);
        titlelabel.textColor = [UIColor colorWithHexString:@"333333"];
        titlelabel.numberOfLines = 0;
        titlelabel.text = model.bbs_title;
        [self addSubview:titlelabel];
        
        [titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(17));
            make.right.mas_equalTo(-HScaleWidth(17));
            make.top.mas_equalTo(userimageview.mas_bottom).offset(HScaleHeight(HScaleHeight(14.5)));
        }];
        
        UILabel *classlabel = [[UILabel alloc]init];
        classlabel.backgroundColor = [UIColor colorWithHexString:@"FFDEDF"];
        classlabel.textColor = [UIColor colorWithHexString:@"DD1A21"];
        classlabel.text = ISNIL(model.modelclass[@"name"]);
        classlabel.textAlignment = NSTextAlignmentCenter;
        classlabel.font = HScaleFont(9);
        [self addSubview:classlabel];
        
        float width = [classlabel.text widthForFont:classlabel.font];
        
        [classlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(17));
            make.top.mas_equalTo(titlelabel.mas_bottom).offset(HScaleHeight(9));
            make.width.mas_equalTo(width + HScaleWidth(18));
        }];
            
        
        UILabel *looknumberlabel = [[UILabel alloc]init];
        looknumberlabel.textColor = [UIColor colorWithHexString:@"999999"];
        looknumberlabel.font = HScaleFont(12);
        looknumberlabel.text = [NSString stringWithFormat:@"浏览  %@   |   收藏  %@",model.bbs_view,model.bbs_collect_num];
        [self addSubview:looknumberlabel];
        
        [looknumberlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleHeight(17));
            make.top.mas_equalTo(classlabel.mas_bottom).offset(HScaleHeight(9.5));
        }];
        
        UILabel *timerlabel = [[UILabel alloc]init];
        timerlabel.textColor = [UIColor colorWithHexString:@"999999"];
        timerlabel.textAlignment = NSTextAlignmentRight;
        timerlabel.font = HScaleFont(12);
        timerlabel.text = model.updated_at;
        [self addSubview:timerlabel];
        
        [timerlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-HScaleWidth(17));
            make.top.mas_equalTo(looknumberlabel.mas_top);
        }];
        
        UIView *lineview = [[UIView alloc]init];
        lineview.backgroundColor = [UIColor colorWithHexString:@"F7F7F7"];
        [self addSubview:lineview];
        [lineview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(HScaleHeight(5));
            make.top.mas_equalTo(looknumberlabel.mas_bottom).offset(HScaleHeight(14.5));
        }];
        
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        //以下代码适配文本大小，由UIWebView换为WKWebView后，会发现字体小了很多，这应该是WKWebView与html的兼容问题，解决办法是修改原网页，要么我们手动注入JS
//        NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
        //用于进行JavaScript注入
        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:nil injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        [config.userContentController addUserScript:wkUScript];
        
        
        self.wkWebView = [[WKWebView alloc]initWithFrame:CGRectZero configuration:config];
        // 导航代理
        self.wkWebView.navigationDelegate = self;
        self.wkWebView.UIDelegate = self;
        [self addSubview:self.wkWebView];
        
        [self.wkWebView loadHTMLString:model.bbs_content baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
        

        
        
        
        [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(lineview.mas_bottom);
            make.height.mas_equalTo(HScaleHeight(300));
        }];
    }
    return self;
}
#pragma mark - WKNavigationDelegate
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"加载完成");
    CGFloat contentHeight = self.wkWebView.scrollView.contentSize.height;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
