//  UITextField+TXEvent.m
//  TXUIKitPro
//
//  Created by 赵小东 on 2020/5/19.
//  Copyright © 赵小东 (QQ:1530591908) All rights reserved.

#import "UITextField+TXSearchEvent.h"

@interface UITextField()<UITextFieldDelegate>


@end

static SearchStateChangeBlock g_searchStateBlock;
static SearchButtonClickedBlock g_searchClickBlock;

static NSString *g_lastText;//最后一次变更的文本


@implementation UITextField(TXSearchEvent)

#pragma mark - Public
- (void)addEventBlock:(SearchStateChangeBlock)stateBlock searchClickBlock:(SearchButtonClickedBlock)searchClickBlock {
    g_searchStateBlock = stateBlock;
    g_searchClickBlock = searchClickBlock;
    self.delegate = self;
    [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    //是否允许开始去编辑，NO不允许编辑，点击输入框的时候调用，becomeFirstResponder也会先去调用这个方法
    //NSLog(@"textFieldShouldBeginEditing");
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    //becomeFirstResponder方法先去调用textFieldShouldBeginEditing，如果为YES则调用此方法.
    //点击输入框的时候（尝试输入的时候）也会调用此方法。
    NSString *searchText = textField.text;
    if (g_searchStateBlock) {
        if (searchText.length > 0) {
            g_searchStateBlock(textField,searchText,TXSearchBarStateSearching);
        } else {
            g_searchStateBlock(textField,searchText,TXSearchBarStateHistory);
        }
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    //NSLog(@"textFieldShouldEndEditing");
    return YES;
}

//下面代码不能打开，否则搜索状态会乱
//有了textFieldDidChange这个方法就没必要打开下面的代码
#if 0
//ios 9
- (void)textFieldDidEndEditing:(UITextField *)textField {
    //NSLog(@"textFieldDidEndEditing");
    if (g_searchStateBlock) {
        if (textField.text.length > 0) {
            g_searchStateBlock(TXSearchBarStateSearching,textField.text);
        } else {
            g_searchStateBlock(TXSearchBarStateHistory,textField.text);
        }
    }
}
//ios 10
- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason {
    //NSLog(@"textFieldDidEndEditing textField reason");
    if (g_searchStateBlock) {
        if (textField.text.length > 0) {
            g_searchStateBlock(TXSearchBarStateSearching,textField.text);
        } else {
            g_searchStateBlock(TXSearchBarStateHistory,textField.text);
        }
    }
}
#endif


//限制字数、限制特定字符的实现
//string新输入的字符
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //NSLog(@"shouldChangeCharactersInRange   %@",string);
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    NSString *searchText = textField.text;
    if (g_searchStateBlock) {
        g_searchStateBlock(textField,searchText,TXSearchBarStateHistory);
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSString *searchText = textField.text;
    if (g_searchStateBlock) {
        if (searchText.length > 0) {
            g_searchStateBlock(textField,searchText,TXSearchBarStateSearchResult);
        } else {
            g_searchStateBlock(textField,searchText,TXSearchBarStateHistory);
        }
    }
    
    if (g_searchClickBlock) {
        g_searchClickBlock(textField,searchText);
    }
    
    return YES;
}

#pragma mark - Target
-(void)textFieldDidChange:(UITextField *)textField {
    NSString *searchText = textField.text;
    if (![g_lastText isEqualToString:textField.text]) {
        if (g_searchStateBlock) {
            if (searchText.length > 0) {
                g_searchStateBlock(textField,searchText,TXSearchBarStateSearching);
            } else {
                g_searchStateBlock(textField,searchText,TXSearchBarStateHistory);
            }
        }
    }
    g_lastText = searchText;
}

@end
