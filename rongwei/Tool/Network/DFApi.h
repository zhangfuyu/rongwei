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
#define DesignerListsApi   @"designer/getDesignersList"

/**
设计师详情
*/
#define DesignerDetailApi   @"designer/getOneDesigner"


/**
设计师作品
*/
#define WorkDesignerDetailApi   @"work/designer"

/**
设计师简介
*/
#define DesignerAboutDetailApi   @"designer/about"

/**
设计师评价
*/
#define DesignerCommentDetailApi   @"designer/comment"


/**
注册
*/
#define RegisterUser   @"userInfo/registerUser"


/**
发松验证码
*/
#define SendCode   @"userInfo/sendCode"


#endif /* DFApi_h */
