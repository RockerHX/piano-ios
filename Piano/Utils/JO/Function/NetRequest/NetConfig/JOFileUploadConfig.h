//
//  JOURLFileUploadConfig.h
//  JOProjectBaseSDK
//
//  Created by 刘维 on 15/11/26.
//  Copyright © 2015年 刘维. All rights reserved.
//

#import "JOConfig.h"

//MARK: 这两个handler用来处理文件以文件流的形式作为http body体里面的一个参数传给服务器的时候
/**
 *  组装文件放在body体里面的流形式上传的NSURLRequest.
 *
 *  @param method    post 或者 get 等方法 ： @"POST" 或 @"Get"
 *  @param URLString 上传的地址.
 *  @param postData  需要传的参数.
 */
typedef void(^FileStreamUploadRequestHanlder)(NSString *method, NSString *URLString, NSDictionary *postData);

/**
 *  将你需要传的文件组装到Body体里面上传.
 *
 *  @param fileData 文件的NSData类型.
 *  @param name     对应的这个文件的参数名.(根据服务器那边的定义)
 *  @param fileName 服务器那边接收到需要的完整文件的名(根据服务器那边的定义).
 *  @param mimeType MIME类型. 比如:图片 则传入@"image/jpeg"
 *  具体的查看地址:http://www.w3school.com.cn/media/media_mimeref.asp
 *
 *  常见的MIME类型
 *  超文本标记语言文本 .html,.html   -> text/html
 *  普通文本 .txt                  ->  text/plain
 *  RTF文本 .rtf                   ->  application/rtf
 *  GIF图形 .gif                  ->  image/gif
 *  JPEG图形 .ipeg,.jpg           -> image/jpeg
 *  au声音文件 .au                  -> audio/basic
 *  MIDI音乐文件 mid,.midi          -> audio/midi,audio/x-midi
 *  RealAudio音乐文件 .ra, .ram     ->  audio/x-pn-realaudio
 *  MPEG文件 .mpg,.mpeg            ->  video/mpeg
 *  AVI文件 .avi                  ->  video/x-msvideo
 *  GZIP文件 .gz                  -> application/x-gzip
 *  TAR文件 .tar                  -> application/x-tar
 *  WAV文件 .wav                  -> audio/x-wav
 */
typedef void(^FileStreamSynthHandler) (NSData *fileData, NSString *name, NSString *fileName, NSString *mimeType);

/**
 *  将需要的两个Handler合二为一.
 *
 *  @param requestHandler  FileStreamUploadRequestHanlder
 *  @param fileDataHandler FileStreamSynthHandler
 */
typedef void(^FileStreamURLRequestHandler) (FileStreamUploadRequestHanlder requestHandler, FileStreamSynthHandler fileDataHandler);

@interface JOFileUploadConfig : JOConfig

//要上传的文件的路径. PS:会优先取该值,若该值为空的时候,然后才会取fileData的值.
//若同时设置了这两个值,则filaData则不会被用来作为文件的数据.
@property (nonatomic, copy) NSString *filePath;
//要上传的文件的数据.
@property (nonatomic, copy) NSData *fileData;
//上传的Request.
@property (nonatomic, copy) NSURLRequest *request;
//是否是文件流的请求. 默认为NO
@property (nonatomic, assign) BOOL isStreameRequest;
//文件流上传的URLRequest的组装
@property (nonatomic, copy) FileStreamURLRequestHandler fileStreamURLRequestHandler;

/**
 *  @see JOHttpsRequestDataConfig的文件中的解释
 */
@property (nonatomic, strong) NSURLSessionConfiguration *urlSessionConfiguration;


/*对于文件作为Body体的参数的形式上传的情况:
 
 这是一个上传头像文件(jpg图片)的Coifig的配置示例：
 JOURLFileUploadConfig *fileUploadConfig = [JOURLFileUploadConfig new];
 fileUploadConfig.isStreameRequest = YES;
 UIImage *headImage = [UIImage imageNamed:@"111.jpg"];
 [fileUploadConfig synthFileStreamURLRequestHandler:^(FileStreamUploadRequestHanlder requestHandler, FileStreamSynthHandler fileDataHandler) {
 requestHandler(@"POST",@"上传的URL地址",@{@"KEY":@"Value",@"Key":@"Value"}); //PS:这里的参数不包括文件的对应的参数,文件的对应的参数应在下面去写
 fileDataHandler(UIImageJPEGRepresentation(headImage,0.8),@"avatar",@"avatar.jpg",@"image/jpeg"); //这里才是文件对应的参数的设置.
 }];
 
 PS:avatar为服务器要求的参数名,对应的参数就为文件的Data类型.
 avatar.jpg为服务器需要保存的文件名.若不知道请询问服务器的设置.
 image/jpeg为MimeType,如果不知道自己上传的文件为何种Type,请看上面给出的对应表.
 */
/**
 *  使用的方式如上面示例
 *
 *  @param handler FileStreamURLRequestHandler
 */
- (void)synthFileStreamURLRequestHandler:(FileStreamURLRequestHandler )handler;

/*
 post为传的参数
 NSData *httpBody = nil;
 if ([NSJSONSerialization isValidJSONObject:postData]) {
 NSError *error;
 NSData *registerData = [NSJSONSerialization dataWithJSONObject:postData options:kNilOptions error:&error];
 NSString *postString = [[NSString alloc] initWithData:registerData encoding:NSUTF8StringEncoding];
 httpBody = [postString dataUsingEncoding:NSUTF8StringEncoding];
 }
 
 NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
 [request setHTTPBody:httpBody];
 
 */
/**
 *  设置上传的信息.这个上传方式不同于上面FileStream的方式.具体使用哪一种方式上传请询问服务器那边的设置.
 *
 *  @param file     上传的文件数据. 可以为一个文件的地址或者文件的data. 二选一
 *  @param request  请求的request.
 */
- (void)setUploadFile:(id)file request:(NSURLRequest *)reqeust;


@end
