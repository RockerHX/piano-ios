//
//  MIAReportManage.m
//  Piano
//
//  Created by 刘维 on 16/6/8.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAReportManage.h"
#import "MiaAPIHelper.h"
#import "JOBaseSDK.h"

@interface MIAReportManage()<UIActionSheetDelegate>

@property (nonatomic, strong) UIActionSheet *actionSheet;
@property (nonatomic, copy) ReportStateBlock reportStateBlock;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *content;

@end

@implementation MIAReportManage

+ (instancetype)reportManage{

    static MIAReportManage *reportManage;
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        reportManage = [[self alloc] init];
    });
    return reportManage;
}

- (void)reportWithType:(NSString *)type content:(NSString *)content reportHandler:(ReportStateBlock)block{

    self.reportStateBlock = nil;
    self.reportStateBlock = block;
    
    self.type = nil;
    self.type = type;
    
    self.content = nil;
    self.content = content;
    
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    [alertController addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//        
//    }]];
//    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        
//    }]];
//    
//    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alertController animated:YES completion:^{
//        
//    }];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                     destructiveButtonTitle:@"举报"
                                          otherButtonTitles:nil];
    [actionSheet showInView:[[[[UIApplication sharedApplication] keyWindow] subviews] lastObject]];
}

//- (void)reportWithType:(NSString *)type content:(NSString *)content viewController:(UIViewController *)controller reportHandler:(ReportStateBlock)block{
//
//    self.reportStateBlock = nil;
//    self.reportStateBlock = block;
//    
//    self.type = nil;
//    self.type = type;
//    
//    self.content = nil;
//    self.content = content;
//
//    
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    [alertController addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//        
//    }]];
//    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        
//    }]];
//    
//    UIPopoverPresentationController *popover = alertController.popoverPresentationController;
//    if (popover){
//        popover.sourceView = controller.view;
//        popover.sourceRect = controller.view.bounds;
//        popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
//    }
//    
////    [controller presentViewController:alertController animated:YES completion:^{
////        
////    }];
//    
////    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
////                                                             delegate:self
////                                                    cancelButtonTitle:@"取消"
////                                               destructiveButtonTitle:@"举报"
////                                                    otherButtonTitles:nil];
////    [actionSheet showInView:controller.view];
////    [actionSheet showFromRect:CGRectMake(0., 0., 320., 300.) inView:controller.view animated:YES];
//}

#pragma mark - action sheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex == 0) {
        //举报
        [MiaAPIHelper reportWithType:JOConvertStringToNormalString(_type)
                             content:JOConvertStringToNormalString(_content)
                       completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
                           
                           if (success) {
                               if (_reportStateBlock) {
                                   _reportStateBlock(ReportSuccess);
                               }
//                               JOLog(@"举报返回的数据:%@",userInfo);
                               
                           }else{
                           
                               if (_reportStateBlock) {
                                   _reportStateBlock(ReportFaild);
                               }
                           }
                       } timeoutBlock:^(MiaRequestItem *requestItem) {
                       
                           if (_reportStateBlock) {
                               _reportStateBlock(ReportFaild);
                           }
                       }];
        
    }else if (buttonIndex == 1){
        //取消
        if (_reportStateBlock) {
            _reportStateBlock(ReportCancel);
        }
    }
}

@end
