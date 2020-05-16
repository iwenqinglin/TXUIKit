//  TXSearchBar.m
//  TXUIKitPro
//
//  Created by 赵小东 on 2020/5/15.
//  Copyright © 赵小东 (QQ:1530591908) All rights reserved.


#import "TXSearchBar.h"
#import <Masonry.h>

@interface TXSearchBar ()<UITextFieldDelegate>
@property(nonatomic, strong) UITextField *searchField;
@property(nonatomic, copy) SearchStateChangeBlock searchStateBlock;
@property(nonatomic, copy) ClickSearchButtonBlock searchClickBlock;
@property(nonatomic, copy) NSString *lastText;//最后一次变更的文本

@end

@implementation TXSearchBar

#pragma mark - Public
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.searchField];
        [self masonryLayout];
        [self.searchField becomeFirstResponder];
        
    }
    return self;
}

- (void)addEventBlock:(SearchStateChangeBlock)stateBlock clickBlock:(ClickSearchButtonBlock)clickBlock {
    self.searchStateBlock = stateBlock;
    self.searchClickBlock = clickBlock;
}

- (void)resignFirstResponder {
    [self.searchField resignFirstResponder];
}

#pragma mark - Private
- (void)masonryLayout {
    [self.searchField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.top.bottom.equalTo(self);
    }];
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
    //NSLog(@"textFieldDidBeginEditing");
    if (self.searchStateBlock) {
        if (textField.text.length > 0) {
            self.searchStateBlock(TXSearchBarStateEditing,textField.text);
        } else {
            self.searchStateBlock(TXSearchBarStateNormal,textField.text);
        }
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    //NSLog(@"textFieldShouldEndEditing");
    return YES;
}

//ios 9
//- (void)textFieldDidEndEditing:(UITextField *)textField {
//    //NSLog(@"textFieldDidEndEditing");
//    if (self.searchStateBlock) {
//        if (textField.text.length > 0) {
//            self.searchStateBlock(TXSearchBarStateEditing,textField.text);
//        } else {
//            self.searchStateBlock(TXSearchBarStateNormal,textField.text);
//        }
//    }
//}
////ios 10
//- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason {
//    //NSLog(@"textFieldDidEndEditing textField reason");
//    if (self.searchStateBlock) {
//        if (textField.text.length > 0) {
//            self.searchStateBlock(TXSearchBarStateEditing,textField.text);
//        } else {
//            self.searchStateBlock(TXSearchBarStateNormal,textField.text);
//        }
//    }
//}

//限制字数、限制特定字符的实现
//string新输入的字符
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //NSLog(@"shouldChangeCharactersInRange   %@",string);
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    //NSLog(@"textFieldShouldClear");
    if (self.searchStateBlock) {
        self.searchStateBlock(TXSearchBarStateNormal,textField.text);
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //NSLog(@"textFieldShouldReturn");
    if (textField.text.length > 0) {
        self.searchStateBlock(TXSearchBarStateEnd,textField.text);
    } else {
        self.searchStateBlock(TXSearchBarStateNormal,textField.text);
    }
    if (self.searchClickBlock) {
        self.searchClickBlock(textField.text);
    }
    [self.searchField resignFirstResponder];
    return YES;
}

#pragma mark - Target
-(void)textFieldDidChange:(UITextField *)textField {
    if (![self.lastText isEqualToString:textField.text]) {
        if (self.searchStateBlock) {
            if (textField.text.length > 0) {
                self.searchStateBlock(TXSearchBarStateEditing,textField.text);
            } else {
                self.searchStateBlock(TXSearchBarStateNormal,textField.text);
            }
        }
    }
    self.lastText = textField.text;
}


#pragma mark - Getter/Setter
- (UITextField *)searchField {
    if (!_searchField) {
        _searchField = [[UITextField alloc] initWithFrame:CGRectZero];
        _searchField.delegate = self;
        [_searchField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _searchField.borderStyle = UITextBorderStyleNone;
        _searchField.clearButtonMode = UITextFieldViewModeAlways;
        _searchField.returnKeyType = UIReturnKeySearch;
    }
    return _searchField;
}

- (void)setPlaceholder:(NSString *)placeholder {
    if (_placeholder != placeholder) {
        _placeholder = placeholder;
        self.searchField.placeholder = placeholder;
    }
}

@end
