//
//  MIASettingContentViewModel.m
//  Piano
//
//  Created by 刘维 on 16/5/26.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIASettingContentViewModel.h"

CGFloat const kSettingContentTopSpaceDistance = 20.;
CGFloat const kSettingContentTextFieldHeight = 50.;
CGFloat const kSettingContentTextViewHeight = 120.;
CGFloat const kSettingContentTableViewCellHeight = 50.;

@interface MIASettingContentViewModel(){

    GenderType gender;
}

@property (nonatomic, strong) RACCommand *genderCommand;
@property (nonatomic, strong) RACCommand *nickCommand;
@property (nonatomic, strong) RACCommand *feedbackCommand;
@property (nonatomic, strong) RACCommand *summayCommand;

@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *feedbackContent;
@property (nonatomic, copy) NSString *contackContent;
@property (nonatomic, copy) NSString *summayContent;

@end

@implementation MIASettingContentViewModel

- (void)initConfigure{

    [self changeGenderCommand];
    [self changeNickCommand];
    [self changeSummayCommand];
    [self sendFeedbackCommand];
}

- (void)changeGenderCommand{

    @weakify(self);
    self.genderCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
    @strongify(self);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
           
            [self sendGenderRequestWithSubscriber:subscriber];
            return nil;
        }];
    }];
}

- (void)changeNickCommand{

    @weakify(self);
    self.nickCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [self sendNickRequestWithSubscriber:subscriber];
            return nil;
        }];
    }];
}

- (void)sendFeedbackCommand{

    @weakify(self);
    self.feedbackCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [self sendFeedbackRequestWithSubscriber:subscriber];
            return nil;
        }];
    }];
}

- (void)changeSummayCommand{

    @weakify(self);
    self.summayCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [self sendSummayRequestWithSubscriber:subscriber];
            return nil;
        }];
    }];
}

#pragma mark - Racsignal 

- (RACSignal *)changeGenderWithGenderType:(GenderType)type{

    gender = type;
    return [_genderCommand execute:nil];
}

- (RACSignal *)changeNickWithName:(NSString *)name{

    self.nickName = nil;
    self.nickName = name;
    
    return [_nickCommand execute:nil];
}

- (RACSignal *)feedbackWithContent:(NSString *)content contact:(NSString *)contact{

    self.feedbackContent = nil;
    self.feedbackContent = content;
    
    self.contackContent = nil;
    self.contackContent = contact;
    
    return [_feedbackCommand execute:nil];
}

- (RACSignal *)changeSummayWithContent:(NSString *)content{

    self.summayContent = nil;
    self.summayContent = content;
    
    return [_summayCommand execute:nil];
}

#pragma mark - data operation

- (void)sendGenderRequestWithSubscriber:(id<RACSubscriber>)subscriber{

    [MiaAPIHelper changeGender:gender
                 completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
                 
                     if (success) {
                         //            NSLog(@"更改性别:%@",userInfo[MiaAPIKey_Values][MiaAPIKey_Data]);
                         [subscriber sendCompleted];
                     }else{
                         
                         [subscriber sendError:[NSError errorWithDomain:userInfo[MiaAPIKey_Values][MiaAPIKey_Error] code:-1 userInfo:nil]];
                     }
                     
                 } timeoutBlock:^(MiaRequestItem *requestItem) {
                     
                     [subscriber sendError:[NSError errorWithDomain:TimtOutPrompt code:-1 userInfo:nil]];
                 }];
}

- (void)sendNickRequestWithSubscriber:(id<RACSubscriber>)subscriber{

    [MiaAPIHelper changeNickName:_nickName
                   completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
                   
                       if (success) {
                           //            NSLog(@"更改昵称:%@",userInfo[MiaAPIKey_Values][MiaAPIKey_Data]);
                           [subscriber sendCompleted];
                       }else{
                           
                           [subscriber sendError:[NSError errorWithDomain:userInfo[MiaAPIKey_Values][MiaAPIKey_Error] code:-1 userInfo:nil]];
                       }
                       
                   } timeoutBlock:^(MiaRequestItem *requestItem) {
                   
                       [subscriber sendError:[NSError errorWithDomain:TimtOutPrompt code:-1 userInfo:nil]];
                   }];
}

- (void)sendSummayRequestWithSubscriber:(id<RACSubscriber>)subscriber{

    [MiaAPIHelper changeBio:_summayContent
              completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
              
                  if (success) {
                      //            NSLog(@"更改昵称:%@",userInfo[MiaAPIKey_Values][MiaAPIKey_Data]);
                      [subscriber sendCompleted];
                  }else{
                      
                      [subscriber sendError:[NSError errorWithDomain:userInfo[MiaAPIKey_Values][MiaAPIKey_Error] code:-1 userInfo:nil]];
                  }
              } timeoutBlock:^(MiaRequestItem *requestItem) {
                  [subscriber sendError:[NSError errorWithDomain:TimtOutPrompt code:-1 userInfo:nil]];
              }];
}

- (void)sendFeedbackRequestWithSubscriber:(id<RACSubscriber>)subscriber{

    [MiaAPIHelper feedbackWithNote:_feedbackContent
                           contact:_contackContent
                     completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
                         
                         if (success) {
                             //            NSLog(@"更改昵称:%@",userInfo[MiaAPIKey_Values][MiaAPIKey_Data]);
                             [subscriber sendCompleted];
                         }else{
                             
                             [subscriber sendError:[NSError errorWithDomain:userInfo[MiaAPIKey_Values][MiaAPIKey_Error] code:-1 userInfo:nil]];
                         }
                     } timeoutBlock:^(MiaRequestItem *requestItem) {
                         
                         [subscriber sendError:[NSError errorWithDomain:TimtOutPrompt code:-1 userInfo:nil]];
                     }];
}

@end
