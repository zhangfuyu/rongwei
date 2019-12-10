//
//  DFWorksDetailView.m
//  rongwei
//
//  Created by zhangfuyu on 2019/12/3.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFWorksDetailView.h"
#import <WebKit/WebKit.h>


@interface DFWorksDetailView ()

@property (nonatomic , strong)WKWebView *wkWebView;

@property (nonatomic , strong)UIView *lineview;

@property (nonatomic , assign)float thisHeight;


@end

@implementation DFWorksDetailView

- (instancetype)initWithFrame:(CGRect)frame withModel:(DFDesignerWorkModel *)model
{
    
    if (self = [super initWithFrame:frame]) {
        
        self.thisHeight = 0.0;
        
        UIImageView *bigimageview = [[UIImageView alloc]init];
        [bigimageview sd_setImageWithURL:[NSURL URLWithString:model.designer_image] placeholderImage:nil];
        [self addSubview:bigimageview];
        
        [bigimageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(HScaleHeight(185));
        }];
        
        self.thisHeight += HScaleHeight(185);
        
        UILabel *titlelabel = [[UILabel alloc]init];
        titlelabel.font = HScaleFont(15);
        titlelabel.textColor = [UIColor colorWithHexString:@"333333"];
        titlelabel.numberOfLines = 2;
        titlelabel.text = model.title;
        [self addSubview:titlelabel];
        
        float titlelabelheighr = [titlelabel.text heightForFont:titlelabel.font width:ScreenW - HScaleWidth(34)];
        
        self.thisHeight += HScaleHeight(18);
        
        self.thisHeight += titlelabelheighr;
        
        [titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(15));
            make.right.mas_equalTo(-HScaleWidth(15));
            make.top.mas_equalTo(bigimageview.mas_bottom).offset(HScaleHeight(18));
        }];
        
        
        UIView *smallview = [[UIView alloc]init];
        smallview.backgroundColor = [UIColor colorWithHexString:@"F5F7FA"];
        [self addSubview:smallview];
        
        [smallview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(titlelabel.mas_bottom).offset(HScaleHeight(19.5));
            make.left.mas_equalTo(HScaleWidth(10));
            make.right.mas_equalTo(-HScaleWidth(10));
            make.height.mas_equalTo(HScaleHeight(70));
        }];
        
        self.thisHeight += HScaleHeight(19.5);
        self.thisHeight += HScaleHeight(70);
        
        
        NSArray *subtitle = [NSArray arrayWithObjects:@"风格",@"户型",@"面积",@"造价", nil];
        NSArray *textArry = [NSArray arrayWithObjects:model.style[@"name"],model.shape[@"name"],model.mianji,model.zaojia, nil];
        
        float widh = (ScreenW - 2 * HScaleWidth(10)) / 4;
        
        for (NSInteger index = 0; index < subtitle.count; index ++) {
            UILabel *subtitlelabel = [[UILabel alloc]init];
            subtitlelabel.font = HScaleBoldFont(12);
            subtitlelabel.textColor = [UIColor colorWithHexString:@"333333"];
            subtitlelabel.textAlignment = NSTextAlignmentCenter;
            subtitlelabel.text = subtitle[index];
            [smallview addSubview:subtitlelabel];
            
            [subtitlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(index * widh);
                make.top.mas_equalTo(21);
                make.width.mas_equalTo(widh);
                
            }];
            
            UILabel *detailtextLaebel = [[UILabel alloc]init];
            detailtextLaebel.font = HScaleFont(12);
            detailtextLaebel.textColor = [UIColor colorWithHexString:@"666666"];
            detailtextLaebel.textAlignment = NSTextAlignmentCenter;
            detailtextLaebel.text = textArry[index];
            [smallview addSubview:detailtextLaebel];
            
            [detailtextLaebel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(subtitlelabel.mas_left);
                make.right.mas_equalTo(subtitlelabel.mas_right);
                make.top.mas_equalTo(subtitlelabel.mas_bottom).offset(HScaleHeight(8.5));
            }];
        }
        
        
        self.lineview = [[UIView alloc]init];
        self.lineview.backgroundColor = [UIColor colorWithHexString:@"F7F7F7"];
        [self addSubview:self.lineview];
        
        [self.lineview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(smallview.mas_bottom).offset(HScaleHeight(15));
            make.height.mas_equalTo(HScaleHeight(5));
        }];
        
        self.thisHeight += HScaleHeight(15);
        
        self.thisHeight += HScaleHeight(5);
        
        if (model.content.length > 0) {
             [self.wkWebView loadHTMLString:model.content baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];

        }
        
        if (self.globalBlockInMemory) {
            self.globalBlockInMemory(self.thisHeight);
        }
        
        
        
        UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, 44, 44)];
        backBtn.showsTouchWhenHighlighted = NO;
        [backBtn setImage:[UIImage imageNamed:@"login_back"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(clickCancelAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backBtn];
    }
    
    return self;
}
- (void)clickCancelAction
{
    [self.viewController.navigationController popViewControllerAnimated:YES];
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
