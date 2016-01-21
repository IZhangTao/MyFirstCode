//
//  ZTMoreController.m
//  生活百事通
//
//  Created by 张涛 on 15/4/19.
//  Copyright (c) 2015年 张涛. All rights reserved.
//

#import "ZTMoreController.h"
#import "RETableViewManager.h"
#import "MBProgressHUD+ZT.h"
#import "ZTWeatherInfo.h"
#import "ZTWeatherViewController.h"
#import "WeatherViewController.h"
#import "ZTAboutController.h"

#import <MessageUI/MessageUI.h>

@interface ZTMoreController ()<RETableViewManagerDelegate,MFMailComposeViewControllerDelegate>
@property (nonatomic, strong) RETableViewManager *manage;
@end

#define SectionHeaderHeight 42
#define SectionFooterHeight 0.5

@implementation ZTMoreController

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.manage = [[RETableViewManager alloc]initWithTableView:self.tableView delegate:self];
    self.manage.style.cellHeight = 36;
    //选中不显示高亮状态
    self.manage.style.defaultCellSelectionStyle = UITableViewCellSelectionStyleNone;
    
    //添加检查更新
    [self addSectionUpdata];
    
    //添加系统设置
    [self addSectionSetting];
    
    //添加反馈意见
    [self addSectionSuggest];
         //添加关于我们
    [self addSectionAbout];
    
}

- (void)addSectionUpdata
{
    RETableViewSection *section = [RETableViewSection section];
    [self.manage addSection:section];
    
    section.headerTitle = @"检查更新";
    section.headerHeight = SectionHeaderHeight;
    section.footerHeight = SectionFooterHeight;
    
    __typeof(self) __weak weakSelf = self;
    
    RETableViewItem *item = [RETableViewItem itemWithTitle:@"检查更新" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
        
        NSLog(@"%@",NSStringFromCGRect(self.view.frame));
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:weakSelf.view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"检查更新中";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            // Do something...
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"没有更新！";
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
                // Do something...
                [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
            });
            
        });    }];
    
    item.image = [UIImage imageNamed:@"plugin_icon_offline"];
    [section addItem:item];
}

- (void)addSectionSetting
{
    RETableViewSection *section = [RETableViewSection section];
    [self.manage addSection: section];
    
    section.headerTitle = @"系统设置";
    section.headerHeight = SectionHeaderHeight;
    section.footerHeight = SectionFooterHeight;
    
    __typeof(self) __weak weakSelf = self;
    
    RETableViewItem *item = [RETableViewItem itemWithTitle:@"清除缓存" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
        
//        NSLog(@"%@",NSStringFromCGRect(self.view.frame));
        // 显示清除缓存
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"清除缓存中...";
        hud.labelFont = [UIFont systemFontOfSize:12];
        [hud setFrame:CGRectMake(0, 0, 375, 50)];
      
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            // 清除缓存
            NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSLog(@"%@",cachPath);
            
            NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
            NSUInteger fileCount = [files count];
            //NSLog(@"files :%ld",[files count]);
            for (NSString *p in files) {
                NSError *error;
                NSString *path = [cachPath stringByAppendingPathComponent:p];
                if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                    [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                }
            }
            
            hud.mode = MBProgressHUDModeText;
            hud.labelText = [NSString stringWithFormat:@"清除缓存文件%ld个!",fileCount];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
                // Do something...
                [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
            });
            
        });
        
    }];
    item.image = [UIImage imageNamed:@"plugin_icon_setting"];
    [section addItem:item];
    
    // 创建第二个条目
    NSString *city = @"北京";
    if (self.weatherInfo) {
        ZTWeatherData *weatherData = self.weatherInfo.weather_data[0];
        city = [NSString stringWithFormat:@"%@    %@",self.weatherInfo.currentCity,weatherData.temperature];
    }
    RETableViewItem *weatherItem = [RETableViewItem itemWithTitle:city accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
        ZTWeatherViewController *weatherCtl = [[ZTWeatherViewController alloc]init];
//        WeatherViewController *weatherCtl = [[WeatherViewController alloc]init];
        weatherCtl.weatherInfo = self.weatherInfo;
        [weakSelf.navigationController pushViewController:weatherCtl animated:YES];
    }];
    
    weatherItem.image = [UIImage imageNamed:@"plugin_icon_weather"];
    [section addItem:weatherItem];
    
    REBoolItem *location = [REBoolItem itemWithTitle:@"定位" value:NO switchValueChangeHandler:^(REBoolItem *item) {
        
    }];
    location.image = [UIImage imageNamed:@"plugin_icon_setting"];
    [section addItem:location];

}

- (void)addSectionSuggest
{
    RETableViewSection *section = [RETableViewSection section];
    [self.manage addSection:section];
    section.headerHeight = SectionHeaderHeight;
    section.footerHeight = SectionFooterHeight;
    section.headerTitle = @"反馈意见";
    
    __typeof(self) __weak weakSelf = self;
    
    RETableViewItem *score = [RETableViewItem itemWithTitle:@"评价打分" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
        
    }];
    score.image = [UIImage imageNamed:@"plugin_icon_star"];
    [section addItem:score];
    
    RETableViewItem *sugguest = [RETableViewItem itemWithTitle:@"问题与建议" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
        
        [weakSelf sendEmail];
        
    }];
    sugguest.image = [UIImage imageNamed:@"plugin_icon_mailbox"];
    [section addItem:sugguest];
}

- (void)sendEmail
{
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    
    if (mailClass != nil){
        if ([mailClass canSendMail]){
            [self displayComposerSheet];
        }else{
            [self launchMailAppOnDevice];
        }
    }else{
        [self launchMailAppOnDevice];
    }
}

//可以发送邮件的话
-(void)displayComposerSheet
{
    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
    
    mailPicker.mailComposeDelegate = self;
    
    //设置主题
    [mailPicker setSubject: @"意见反馈"];
    
    // 添加发送者
    NSArray *toRecipients = [NSArray arrayWithObject: @"1468266626@qq.com"];
//    NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil];
    //NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com", nil];
    [mailPicker setToRecipients: toRecipients];
//    [picker setCcRecipients:ccRecipients];
//    [picker setBccRecipients:bccRecipients];
    
    // 添加图片
    UIImage *addPic = [UIImage imageNamed: @"123.jpg"];
    NSData *imageData = UIImagePNGRepresentation(addPic);            // png
//     NSData *imageData = UIImageJPEGRepresentation(addPic, 1);    // jpeg
    [mailPicker addAttachmentData: imageData mimeType: @"" fileName: @"123.jpg"];
    
    NSString *emailBody = @" 我的建议或者意见是:";
    [mailPicker setMessageBody:emailBody isHTML:NO];
    
    [self presentViewController:mailPicker animated:YES completion:nil];
}

// 转到系统邮件
-(void)launchMailAppOnDevice
{
    NSString *recipients = @"mailto:first@example.com&subject=my email!";
    //@"mailto:first@example.com?cc=second@example.com,third@example.com&subject=my email!";
    NSString *body = @"&body=email body!";
    
    NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
    email = [email stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:email]];
}

// 邮件发送返回
- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    NSString *msg;
    
    switch (result)
    {
        case MFMailComposeResultCancelled:
            msg = @"邮件发送取消";
            break;
        case MFMailComposeResultSaved:
            msg = @"邮件保存成功";
            [self alertWithTitle:nil msg:msg];
            break;
        case MFMailComposeResultSent:
            msg = @"邮件发送成功";
            [self alertWithTitle:nil msg:msg];
            break;
        case MFMailComposeResultFailed:
            msg = @"邮件发送失败";
            [self alertWithTitle:nil msg:msg];
            break;
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) alertWithTitle: (NSString *)_title_ msg: (NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_title_
                                                    message:msg
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)addSectionAbout
{
    // 创建一个组
    RETableViewSection *section = [RETableViewSection section];
    [self.manage addSection:section];
    section.headerHeight = SectionHeaderHeight;
    section.footerHeight = SectionFooterHeight;
    section.headerTitle = @"关于我们";
    
    __typeof (self) __weak weakSelf = self;
    // 创建组中的条目 打分
    RETableViewItem *AboutItem = [RETableViewItem itemWithTitle:@"关于" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
        ZTAboutController *aboutCtr = [[ZTAboutController alloc]init];
        aboutCtr.title = @"关于";
        [weakSelf.navigationController pushViewController:aboutCtr animated:YES];
    }];
    
    AboutItem.image = [UIImage imageNamed:@"plugin_icon_star"];
    [section addItem:AboutItem];

}

@end
