//
//  TXSearchBarDefines.h
//  TXUIKitPro
//
//  Created by wenqinglin on 2020/5/19.
//  Copyright © 2020年 wenqinglin. All rights reserved.
//

#ifndef TXSearchBarDefines_h
#define TXSearchBarDefines_h


/*
 SearchBar有三种状态：
 1、输入框未输入任何字符，此时=>显示历史记录；
 2、正在输入字符，此时=>显示正在搜索页面；
 3、输入搜索关键字完毕，点击搜索按钮，此时=>显示搜索结果页面。
 */
typedef NS_ENUM(NSInteger, TXSearchBarState) {
    TXSearchBarStateHistory = 0,//显示历史记录
    TXSearchBarStateSearching = 1,//显示正在搜索页面
    TXSearchBarStateSearchResult = 2,//显示搜索结果页面
};

//输入框三种状态的回调
typedef void(^SearchStateChangeBlock)(id control,NSString *searchText,TXSearchBarState state);

//点击搜索按钮的回调
typedef void(^SearchButtonClickedBlock)(id control,NSString *searchText);

//点击搜索框右边的取消按钮回调
typedef void(^CancelButtonClickedBlock)(id control,NSString *searchText);


#endif /* TXSearchBarDefines_h */
