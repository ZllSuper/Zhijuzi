//
//  APURLsDefine.h
//  AppProject
//
//  Created by Lala on 2017/10/24.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#ifndef APURLsDefine_h
#define APURLsDefine_h

#ifdef CONFIG_MACROS_DEBUG
//////////////////////////////////////////////////////
/// ********************* 开发环境 ********************
//////////////////////////////////////////////////////
#define BASE_URL @"https://app.zjz-tech.com/"
#define BASE_TEST_URL @"https://app.zjz-tech.com/"

#elif CONFIG_MACROS_ADHOC
//////////////////////////////////////////////////////
/// ********************* AdHoc 环境 ********************
//////////////////////////////////////////////////////
#define BASE_URL @"https://app.zjz-tech.com/"
#define BASE_TEST_URL @"https://app.zjz-tech.com/"

#else
//////////////////////////////////////////////////////
/// ********************* 线上环境 ********************
//////////////////////////////////////////////////////
#define BASE_URL @"https://app.zjz-tech.com/"
#define BASE_TEST_URL @"https://app.zjz-tech.com/"

#endif

#endif /* APURLsDefine_h */
