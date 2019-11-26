//
//  DFApi.h
//  rongwei
//
//  Created by zhangfuyu on 2019/9/19.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#ifndef DFApi_h
#define DFApi_h

#define LoginApi   @"userInfo/userNameLogin"

/**
设计师列表
*/
#define DesignerListsApi   @"designer/designer"

/**
设计师详情
*/
#define DesignerDetailApi   @"designer/designer/1"


/**
设计师作品
*/
#define WorkDesignerDetailApi   @"designer/works"

/**
设计师简介
*/
#define DesignerAboutDetailApi   @"designer/about"

/**
设计师评价
*/
#define DesignerCommentDetailApi   @"designer/comments"


/**
注册
*/
#define RegisterUser   @"userInfo/registerUser"


/**
发松验证码
*/
#define SendCode   @"userInfo/sendCode"

/******************/


/**
省市区获取
*/
#define regions   @"regions/list"

/**
首页-导航
*/
#define HomeWorks   @"index/getNav"

/**
首页-广告位接口
*/
#define HomeAds   @"index/ads"


/**
施工工地列表
*/
#define Construction   @"construction/site"

/**
施工公司列表
*/
#define Company   @"construction/company"

/**
获取施工公司 详情
*/
#define CompanyDetail   @"construction/company/1"

/**
施工公司评价列表
*/
#define constructionComments   @"construction/comments"

/**
施工工地详情
*/
#define constructionSiteStageInfos   @"construction/siteStageInfos"

/**
攻略 列表
*/
#define BbsGuide   @"bbs/guide"


#endif /* DFApi_h */
