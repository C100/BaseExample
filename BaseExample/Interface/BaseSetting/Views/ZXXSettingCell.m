//
//  ZXXSettingCell.m
//  ZXXWeb
//
//  Created by zoekebi on 16/10/24.
//  Copyright © 2016年 www.iphonetrain.com. All rights reserved.
//

#import "ZXXSettingCell.h"

#define TITLEFONT [UIFont fontWithName:@"STHeitiSC-Light" size:16]
#define SUBTITLEFONT [UIFont fontWithName:@"STHeitiSC-Light" size:16]

#define TITLECOLOR [UIColor colorWithWhite:0.200 alpha:1.000]
#define SUBTITLECOLOR [UIColor colorWithWhite:0.200 alpha:1.000]

#define ARROWLABLEFONT FONT_COMMON
#define ARROWLABLECOLOR [UIColor colorWithWhite:0.400 alpha:1.000]
#define TEXTFIELDFONT [UIFont fontWithName:@"STHeitiSC-Light" size:16]
#define TEXTFIELDCOLOR [UIColor colorWithWhite:0.400 alpha:1.000]

static NSString *placeholder = @"请输入文字";
@interface ZXXSettingCell ()<UITextFieldDelegate>

/**
 右边提示数字
 */
@property (nonatomic, weak)ZXXBadgeView *badgeView;
/**
 控件开关
 */
@property (nonatomic, weak)UISwitch *switchView;

/**
 右侧带有label和跳转icon
 */
@property (nonatomic, weak)UILabel *arrowLabel;
/**
 右侧textField
 */
@property(nonatomic,strong)UITextField *textField;

@end

@implementation ZXXSettingCell

- (ZXXBadgeView *)badgeView{
    if (_badgeView == nil) {
        ZXXBadgeView *badgeView = [ZXXBadgeView buttonWithType:UIButtonTypeCustom];
        UIView *view = [[UIView alloc] init];
        [view addSubview:badgeView];
        self.accessoryView = view;
        [badgeView makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(view);
            make.centerY.equalTo(view);
        }];
        _badgeView = badgeView;
    }
    return _badgeView;
}

- (UISwitch *)switchView{
    if (_switchView == nil) {
        UISwitch *switchView = [[UISwitch alloc] init];
        self.accessoryView = switchView;
        [switchView addTarget:self action:@selector(switchViewValueChanged) forControlEvents:UIControlEventValueChanged];
        _switchView = switchView;
    }
    return _switchView;
}
- (void)switchViewValueChanged{
    self.item.on = self.switchView.on;
}
/**带有label和跳转icon*/
- (UILabel *)arrowLabel{
    if (_arrowLabel == nil) {
        UIView *view = [[UIView alloc] init];
        UILabel *label = [[UILabel alloc] init];
        UIImageView *imgV = [[UIImageView alloc] initWithImage:TableViewCellDisclosureIndicatorImage];
        [view addSubview:imgV];
        [view addSubview:label];
        [imgV makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(view);
            make.centerY.equalTo(view);
        }];
        label.font = ARROWLABLEFONT;
        label.textColor = ARROWLABLECOLOR;
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(imgV.left).offset(-10);
            make.centerY.equalTo(view);
        }];
        _arrowLabel = label;
        self.accessoryView = view;
    }
    return _arrowLabel;
}

- (UITextField *)textField{
    if (_textField == nil) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNoteTodoAction) name:UIKeyboardWillHideNotification object:nil];
        UITextField *textField = [[UITextField alloc] init];
        textField.textAlignment = NSTextAlignmentRight;
        textField.delegate = self;
        textField.returnKeyType = UIReturnKeyDone;
        textField.font = TEXTFIELDFONT;
        textField.textColor = TEXTFIELDCOLOR;
        textField.placeholder = placeholder;
        self.accessoryView = textField;
        _textField = textField;
    }
    return _textField;
}

#pragma mark - textFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField endEditing:YES];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([self.item.rightTitle isEqualToString:textField.text]) {
        return;
    }else{
        self.item.rightTitle = textField.text;
    }
}
- (void)receiveNoteTodoAction{
    [self endEditing:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    if ([self.reuseIdentifier containsString:CELLCOMMON_EDIT]) {
        [[NSNotificationCenter defaultCenter]postNotificationName:UIKeyboardWillHideNotification object:nil];
    }
}

+ (instancetype)cellTableView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier{
    
    ZXXSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
        cell.separatorInset = UIEdgeInsetsZero;
    }
    return cell;
}

- (void)setItem:(ZXXSetItem *)item{
    _item = item;
    if ([item class] != [ZXXArrowItem class]&&[item class] != [ZXXLabelArrowItem class]) {// 不是ZXXArrowItem样式时可为不可选中样式
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }else{
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    
    if (item.class == [ZXXArrowItem class]) {//
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if (item.class == [ZXXCheakItem class]){
        if (item.cheak == YES) {
            self.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            self.accessoryType = UITableViewCellAccessoryNone;
        }
    }else if (item.class == [ZXXLabelArrowItem class]){//
        self.arrowLabel.text = item.rightTitle;
        if (item.attribute.rightTitleFont!=nil) {
            self.arrowLabel.font = item.attribute.rightTitleFont;
        }else{
            self.arrowLabel.font = ARROWLABLEFONT;
        }
        if (item.attribute.rightTitleColor!=nil) {
            self.arrowLabel.textColor = item.attribute.rightTitleColor;
        }else{
            self.arrowLabel.textColor = ARROWLABLECOLOR;
        }
    }else if (item.class == [ZXXBadgeItem class]){//
        self.badgeView.badgeValue = item.badgeValue;
    }else if (item.class == [ZXXSwitchItem class]){
        self.switchView.on = item.on;
    }else if (item.class == [ZXXTextFieldItem class]){
        self.textField.text = item.rightTitle;
        if (item.attribute.rightTitleFont!=nil) {
            self.textField.font = item.attribute.rightTitleFont;
        }else{
            self.textField.font = TEXTFIELDFONT;
        }
        if (item.attribute.rightTitleColor!=nil) {
            self.textField.textColor = item.attribute.rightTitleColor;
        }else{
            self.textField.textColor = TEXTFIELDCOLOR;
        }
        if (item.attribute.rightPlaceHolder!=nil) {
            self.textField.placeholder = item.attribute.rightPlaceHolder;
        }else{
            self.textField.placeholder = placeholder;
        }
    }
    
    if (item.title) {
        self.textLabel.text = item.title;
        if (item.attribute.titleFont!=nil) {
            self.textLabel.font = item.attribute.titleFont;
        }else{
            self.textLabel.font = TITLEFONT;
        }
        if (item.attribute.titleColor!=nil) {
            self.textLabel.textColor = item.attribute.titleColor;
        }else{
            self.textLabel.textColor = TITLECOLOR;
        }
    }else{
        self.textLabel.text = nil;
    }
    if (item.subTitle) {
        self.detailTextLabel.text = item.subTitle;
        if (item.attribute.subTitleFont!=nil) {
            self.detailTextLabel.font = item.attribute.subTitleFont;
        }else{
            self.detailTextLabel.font = SUBTITLEFONT;
        }
        if (item.attribute.subTitleColor!=nil) {
            self.detailTextLabel.textColor = item.attribute.subTitleColor;
        }else{
            self.detailTextLabel.textColor = SUBTITLECOLOR;
        }
    }else{
        self.detailTextLabel.text = nil;
    }
    if (item.image) {
        self.imageView.image = item.image;
    }else{
        self.imageView.image = nil;
    }
    
    self.imageEdgeInsets = item.attribute.imageEdgeInsets;
    self.textLabelEdgeInsets = item.attribute.textLabelEdgeInsets;
    self.detailTextLabelEdgeInsets = item.attribute.detailTextLabelEdgeInsets;
    self.accessoryEdgeInsets = item.attribute.accessoryEdgeInsets;
    
}

/// 在父类中已经实现了布局。只要设置相关的属性就行了
- (void)layoutSubviews{
    [super layoutSubviews];
    if (self.item.class == [ZXXTextFieldItem class]) {
        [self.textField remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self).offset(-20);
        }];
    }
}

- (void)dealloc{
    if (_textField) {
        [[NSNotificationCenter defaultCenter]removeObserver:self];
    }
}
@end
