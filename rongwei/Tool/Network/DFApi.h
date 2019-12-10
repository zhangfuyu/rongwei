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
#define DesignerDetailApi   @"designer/designer"


/**
设计师作品
*/
#define WorkDesignerDetailApi   @"designer/works"

/**
设计师简介
*/
#define DesignerAboutDetailApi   @"designer/about"

/**
指定ID 作品 详情
*/
#define DesignerAboutworksApi   @"designer/works"

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

/**
攻略 攻略-攻略分类列表
*/
#define BbsClass   @"bbs/class"

/**
根据攻略ID 获取该攻略下方评论
*/
#define BbsGuideComment   @"bbs/comment"

/**
找攻略 广告位
*/
#define BbsADS   @"bbs/ads"

/**
建材城首页广告接口
*/
#define ShopADS   @"shop/ads"

/**
获取店铺列表
*/
#define ShopStore   @"shop/store"

/**
商品列表
*/
#define ShopGoods   @"shop/goods"


#endif /* DFApi_h */
