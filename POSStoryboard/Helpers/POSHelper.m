//
//  POSHelper.m
//  POSStoryboard
//
//  Created by kobernik.u on 12/23/13.
//  Copyright (c) 2013 kobernik.u. All rights reserved.
//
#import "POSHelper.h"

@implementation POSHelper

#pragma mark - Singleton

+ (POSHelper *)getInstance {
    
    static POSHelper *sharedInstance = nil;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        
        sharedInstance = [[POSHelper alloc] init];
    });
    
    return sharedInstance;
}


#pragma mark - Settings

- (NSDictionary *)SETTING_LANGUAGES_DICT {
    
    return [[NSDictionary alloc] initWithObjectsAndKeys:
            @"Russian", @"Russian",
            @"English", @"English",
            nil];
}

- (NSDictionary *)SETTING_MONEY_DICT {
    
    return [[NSDictionary alloc] initWithObjectsAndKeys:
            @"$ USD", @"$",
            @"P RUB", @"P",
            @"₴ UAH", @"₴",
            @"€ EUR", @"€",
            nil];
}

- (NSString *)SETTING_REMEMBERME_CHECKED_ICON {
    
    return @"setting_rememberme_checked_icon.png";
}

- (NSString *)SETTING_REMEMBERME_UNCHECKED_ICON {
    
    return @"setting_rememberme_unchecked_icon.png";
}

- (NSString *)SETTING_EMAIL_ICON {
    
    return @"setting_email_icon.png";
}

- (NSString *)SETTING_LANGUAGE_ICON {
    
    return @"setting_language_icon.png";
}

- (NSString *)SETTING_MONEY_ICON {
    
    return @"setting_money_icon.png";
}

- (NSString *)SETTING_WIFI_ICON {
    
    return @"setting_wifi_icon.png";
}

- (NSString *)SETTING_VAT_ICON {
    
    return @"setting_vat_icon.png";
}

- (NSString *)SETTING_EMAIL {
    
    return @"email";
}

- (NSString *)SETTING_LANGUAGE {
    
    return @"language";
}

- (NSString *)SETTING_MONEY {
    
    return @"money";
}

- (NSString *)SETTING_WIFI {
    
    return @"wifi";
}

- (NSString *)SETTING_VAT {
    
    return @"vat";
}

- (NSString *)SETTING_REMEMBERME {
    
    return @"rememberme";
}

- (NSString *)SETTING_REMEMBERME_LOGIN {
    
    return @"rememberme_login";
}

- (NSString *)SETTING_REMEMBERME_PASS {
    
    return @"rememberme_pass";
}

- (NSString *)SETTING_BUTTON_BACKGROUND_COLOR {
    
    return @"button_color";
}

- (NSString *)SETTING_BUTTON_FONT_COLOR {
    
    return @"button_font_color";
}

- (NSString *)SETTING_TEXTFIELD_BORDER_COLOR {
    
    return @"textfield_border_color";
}

- (NSString *)SETTING_TEXTFIELD_FONT_COLOR {
    
    return @"textfield_font_color";
}

- (NSString *)SETTING_CATEGORY_MODE {
    
    return @"category_mode";
}


#pragma mark - Sizes

- (CGFloat)ITEM_EDIT_WIDTH {
    
    return  180;
}


- (CGFloat)ITEM_EDIT_HEIGHT {
    
    return  180;
}


- (CGFloat)ITEM_VIEW_WIDTH {
    
    return  295;
}


- (CGFloat)ITEM_VIEW_HEIGHT
{
    
    return  285;
}


- (CGFloat)ITEM_LIST_WIDTH {
    
    return  160;
}


- (CGFloat)ITEM_LIST_HEIGHT {
    
    return  160;
}


- (CGFloat)CATEGORY_LIST_WIDTH {
    
    return  180;
}


- (CGFloat)CATEGORY_LIST_HEIGHT {
    
    return  200;
}

- (int)BUTTON_CORNER_RADIUS {
    
    return 15;
}



#pragma mark - Other 

- (id)getDictionaryFirstValue:(NSDictionary *)dict {
    
    return [dict valueForKey:[[dict allKeys] objectAtIndex:0]];
}

- (id)getDictionaryFirstKey:(NSDictionary *)dict {
    
    return [[dict allKeys] objectAtIndex:0];
}

- (NSString *)convertBoolToString:(BOOL)value {
    
    return value ? @"YES" : @"NO";
}

- (BOOL)isValidEmail:(NSString *)email {
    
    BOOL stricterFilter = YES; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[_A-Za-z0-9-+]+(\\.[_A-Za-z0-9-+]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z‌​]{2,4})$";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];

    return [emailTest evaluateWithObject:email];
}


- (NSObject *)getObject:(NSMutableArray *)objects withID:(int)id {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ID = %d", id];
    NSArray *arr = [objects filteredArrayUsingPredicate:predicate];
    NSObject *value;
    
    if ([arr count] > 0) {
        
        value = ((NSObject *)[arr objectAtIndex:0]);
    }
    
    return value;
}

- (NSObject *)getObject:(NSMutableArray *)objects withPredicate:(NSPredicate *)predicate {
    
    NSArray *arr = [objects filteredArrayUsingPredicate:predicate];
    NSObject *value;
    
    if ([arr count] > 0) {
        
        value = ((NSObject *)[arr objectAtIndex:0]);
    }
    
    return value;
}


#pragma mark - GUI

- (id)getUIViewController:(NSString *)storyboardName {

    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName: @"Main"
                                                             bundle: nil];

    return [mainStoryboard instantiateViewControllerWithIdentifier:storyboardName];

}

- (void)setButtonShadow:(UIButton *)button withCornerRadius:(int)cornerRadius{

    button.layer.shadowRadius = 3.0f;
    button.layer.shadowColor = [UIColor blackColor].CGColor;
    button.layer.shadowOffset = CGSizeMake(2, 2);
    button.layer.shadowOpacity = 0.5f;
    button.layer.masksToBounds = NO;
    button.layer.cornerRadius = cornerRadius;
}


- (void)loadTextFieldBorderColorSetting:(UIColor *)color {
    
    POSSetting *setting = [POSSetting getSetting: objectsHelperInstance.dataSet.settings
                                        withName: helperInstance.SETTING_TEXTFIELD_BORDER_COLOR];
    
    [objectsHelperInstance.dataSet settingsUpdate: setting
                                        withValue: [CIColor colorWithCGColor:color.CGColor].stringRepresentation];
}

- (void)setTextFieldBorderColorBySetting:(UITextField *)textField {
    
    POSSetting *setting = [POSSetting getSetting: objectsHelperInstance.dataSet.settings
                                        withName: helperInstance.SETTING_TEXTFIELD_BORDER_COLOR];

    textField.layer.borderWidth = 1.0;
    textField.layer.borderColor = [UIColor colorWithCIColor:[CIColor colorWithString:setting.value]].CGColor;
}

- (void)loadTextFieldFontColorSetting:(UIColor *)color {
    
    POSSetting *setting = [POSSetting getSetting: objectsHelperInstance.dataSet.settings
                                        withName: helperInstance.SETTING_TEXTFIELD_FONT_COLOR];
    [objectsHelperInstance.dataSet settingsUpdate: setting
                                        withValue: [CIColor colorWithCGColor:color.CGColor].stringRepresentation];
}

- (void)setTextFieldFontColorBySetting:(UITextField *)textField {
    
    POSSetting *setting = [POSSetting getSetting: objectsHelperInstance.dataSet.settings
                                        withName: helperInstance.SETTING_TEXTFIELD_FONT_COLOR];
    
    UIColor *color = [UIColor colorWithCIColor:[CIColor colorWithString:setting.value]];
    color = [UIColor colorWithCGColor:color.CGColor];
    [textField setTextColor:color];
}

- (void)loadButtonBackgroundColorSetting:(UIColor *)color {
    
    POSSetting *setting = [POSSetting getSetting: objectsHelperInstance.dataSet.settings
                                        withName: helperInstance.SETTING_BUTTON_BACKGROUND_COLOR];
    
    [objectsHelperInstance.dataSet settingsUpdate: setting
                                        withValue: [CIColor colorWithCGColor:color.CGColor].stringRepresentation];
}

- (void)setButtonBackgroundColorBySetting:(UIButton *)button {
    
    POSSetting *setting = [POSSetting getSetting: objectsHelperInstance.dataSet.settings
                                        withName: helperInstance.SETTING_BUTTON_BACKGROUND_COLOR];
    
    button.layer.backgroundColor = [UIColor colorWithCIColor:[CIColor colorWithString:setting.value]].CGColor;
}

- (void)loadButtonFontColorSetting:(UIColor *)color {
    
    POSSetting *setting = [POSSetting getSetting: objectsHelperInstance.dataSet.settings
                                        withName: helperInstance.SETTING_BUTTON_FONT_COLOR];
    [objectsHelperInstance.dataSet settingsUpdate: setting
                                        withValue: [CIColor colorWithCGColor:color.CGColor].stringRepresentation];
    
}

- (void)setButtonFontColorBySetting:(UIButton *)button {
    
    POSSetting *setting = [POSSetting getSetting: objectsHelperInstance.dataSet.settings
                                        withName: helperInstance.SETTING_BUTTON_FONT_COLOR];
    
    [self setButtonFontColor:button withSetting:setting];
}

- (void)setButtonFontColor:(UIButton *)button withSetting:(POSSetting *)setting {
    
    UIColor *color = [UIColor colorWithCIColor:[CIColor colorWithString:setting.value]];
    color = [UIColor colorWithCGColor:color.CGColor];
    [button setTintColor:color];
    [button setTitleColor:color forState:UIControlStateNormal];
}


@end
