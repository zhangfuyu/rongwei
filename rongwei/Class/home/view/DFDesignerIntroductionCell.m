//
//  DFDesignerIntroductionCell.m
//  rongwei
//
//  Created by zhangfuyu on 2019/12/31.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFDesignerIntroductionCell.h"
#import <WebKit/WebKit.h>

@interface DFDesignerIntroductionCell ()

@property (nonatomic , strong)WKWebView *wkWebView;


@end

@implementation DFDesignerIntroductionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setContent:(NSString *)content
{
    [self.wkWebView loadHTMLString:content baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];

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
        [self.contentView addSubview:_wkWebView];

    }
    return _wkWebView;
}

@end
