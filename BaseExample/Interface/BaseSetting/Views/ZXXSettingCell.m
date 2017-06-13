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
 替代_imageView
 */
@property (nonatomic,weak)UIImageView *imgView;
/**
 替代_textLabel
 */
@property (nonatomic,weak)UILabel *titleLable;
/**
 替代_detailTextLabel
 */
@property (nonatomic,weak)UILabel *subtitleLabel;
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
@property(nonatomic,weak)UITextField *textField;

@end

@implementation ZXXSettingCell
- (UIImageView *)imgView{
    if (_imgView==nil) {
        UIImageView *imgView = [[UIImageView alloc] init];
        [self.contentView addSubview:imgView];
        _imgView = imgView;
    }
    return _imgView;
}
/**
 主标题
 */
- (UILabel *)titleLable{
    if (_titleLable==nil) {
        UILabel *label = [[UILabel alloc] init];
        label.font = TITLEFONT;
        label.textColor = TITLECOLOR;
        label.numberOfLines = 0;
        [self.contentView addSubview:label];
        _titleLable = label;
    }
    return _titleLable;
}

/**
 副标题
 */
- (UILabel *)subtitleLabel{
    if (_subtitleLabel==nil) {
        UILabel *label = [[UILabel alloc] init];
        label.font = SUBTITLEFONT;
        label.textColor = SUBTITLECOLOR;
        label.numberOfLines = 0;
        [self.contentView addSubview:label];
        _subtitleLabel = label;
    }
    return _subtitleLabel;
}

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
        UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Disclosure Indicator"]];
        [view addSubview:imgV];
        [view addSubview:label];
        [imgV makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(view);
            make.centerY.equalTo(view);
            make.size.sizeOffset(CGSizeMake(8, 13));
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
        cell = [[self alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
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
        self.accessoryView = nil;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if (item.class == [ZXXCheakItem class]){
        self.accessoryView = nil;
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
        self.titleLable.text = item.title;
        if (item.attribute.titleFont!=nil) {
            self.titleLable.font = item.attribute.titleFont;
        }else{
            self.titleLable.font = TITLEFONT;
        }
        if (item.attribute.titleColor!=nil) {
            self.titleLable.textColor = item.attribute.titleColor;
        }else{
            self.titleLable.textColor = TITLECOLOR;
        }
    }else{
        [self.titleLable removeFromSuperview];
    }
    if (item.subTitle) {
        self.subtitleLabel.text = item.subTitle;
        if (item.attribute.subTitleFont!=nil) {
            self.subtitleLabel.font = item.attribute.subTitleFont;
        }else{
            self.subtitleLabel.font = SUBTITLEFONT;
        }
        if (item.attribute.subTitleColor!=nil) {
            self.subtitleLabel.textColor = item.attribute.subTitleColor;
        }else{
            self.subtitleLabel.textColor = SUBTITLECOLOR;
        }
    }else{
        [self.subtitleLabel removeFromSuperview];
    }
    if (item.image) {
        self.imgView.image = item.image;
    }else{
        [self.imgView removeFromSuperview];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (self.item.class == [ZXXTextFieldItem class]) {
        [self.textField remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self).offset(-20);
        }];
    }
    // 带图片的cell
    if ([self.reuseIdentifier containsString:CELLCOMMON] || [self.reuseIdentifier containsString:CELLCOMMON_EDIT]) {
        BOOL isImg = self.item.image!=nil?YES:NO;
        BOOL isTitle = self.item.title!=nil?YES:NO;
        BOOL isSubTitle = self.item.subTitle!=nil?YES:NO;
        [self layoutCommonWithImage:isImg WithTitle:isTitle WithSubTitle:isSubTitle];
        
    }
}

- (void)layoutCommonWithImage:(BOOL)isImg WithTitle:(BOOL)isTitle WithSubTitle:(BOOL)isSubTitle{
    CGFloat height = self.frame.size.height;
    if (isImg==YES) {
        if(self.item.attribute.size.height>0){
            [self.imgView remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(14);
                make.centerY.equalTo(self);
                make.size.sizeOffset(self.item.attribute.size);
            }];
        }else{
            [self.imgView remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(14);
                make.centerY.equalTo(self);
                make.size.sizeOffset(CGSizeMake(height-20, height-20));
            }];
        }
        if (isTitle==YES) {
            if (isSubTitle==YES) {
                if (self.item.attribute.topMargin>0) {
                    [self.titleLable remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self.imgView.right).offset(10);
                        make.top.equalTo(self).offset(self.item.attribute.topMargin);
                    }];
                }else{
                    [self.titleLable remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self.imgView.right).offset(10);
                        make.centerY.equalTo(self).offset(-height/4);
                    }];
                }
                if (self.item.attribute.bottomMargin>0) {
                    [self.subtitleLabel remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self.imgView.right).offset(10);
                        make.bottom.equalTo(self).offset(-self.item.attribute.bottomMargin);
                    }];
                }else{
                    [self.subtitleLabel remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self.imgView.right).offset(10);
                        make.centerY.equalTo(self).offset(height/4);
                    }];
                }
            }else{
                if (self.item.attribute.topMargin>0) {
                    [self.titleLable remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self.imgView.right).offset(10);
                        make.top.equalTo(self).offset(self.item.attribute.topMargin);
                    }];
                }else{
                    [self.titleLable remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self.imgView.right).offset(10);
                        make.centerY.equalTo(self);
                    }];
                }
            }
        }else{
            if (isSubTitle==YES) {
                if (self.item.attribute.bottomMargin>0) {
                    [self.subtitleLabel remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self.imgView.right).offset(10);
                        make.bottom.equalTo(self).offset(-self.item.attribute.bottomMargin);
                    }];
                }else{
                    [self.subtitleLabel remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self.imgView.right).offset(10);
                        make.centerY.equalTo(self);
                    }];
                }
            }
        }
    }else{
        if (isTitle==YES) {
            if (isSubTitle==YES) {
                if (self.item.attribute.topMargin>0) {
                    [self.titleLable remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self).offset(14);
                        make.top.equalTo(self).offset(self.item.attribute.topMargin);
                    }];
                }else{
                    [self.titleLable remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self).offset(14);
                        make.centerY.equalTo(self).offset(-height/4);
                    }];
                }
                if (self.item.attribute.bottomMargin>0) {
                    [self.subtitleLabel remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self).offset(14);
                        make.bottom.equalTo(self).offset(-self.item.attribute.bottomMargin);
                    }];
                }else{
                    [self.subtitleLabel remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self).offset(14);
                        make.centerY.equalTo(self).offset(height/4);
                    }];
                }
            }else{
                if (self.item.attribute.topMargin>0) {
                    [self.titleLable remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self).offset(14);
                        make.top.equalTo(self).offset(self.item.attribute.topMargin);
                    }];
                }else{
                    [self.titleLable remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self).offset(14);
                        make.centerY.equalTo(self);
                    }];
                }
            }
        }else{
            if (self.item.subTitle) {
                if (self.item.attribute.bottomMargin>0) {
                    [self.subtitleLabel remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self).offset(14);
                        make.bottom.equalTo(self).offset(self.item.attribute.bottomMargin);
                    }];
                }else{
                    [self.subtitleLabel remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self).offset(14);
                        make.centerY.equalTo(self);
                    }];
                }
            }
        }
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)dealloc{
    if (_textField) {
        [[NSNotificationCenter defaultCenter]removeObserver:self];
    }
}
@end
