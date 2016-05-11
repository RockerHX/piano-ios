//
//  JOFFileManage.h
//  JOProjectBaseSDK
//
//  Created by 刘维 on 15/10/26.
//  Copyright © 2015年 刘维. All rights reserved.
//

#import "JOFunctionObject.h"

@interface JOFFileManage : JOFunctionObject

/**
 *  Document的文件的路径.
 *
 *  @return 返回该文件的路径.
 */
+ (nullable NSString *)documentPath;

/**
 *  temp的文件的路径
 *
 *  @return 返回该文件的路径
 */
+ (nullable NSString *)tempPath;

/**
 *  Document文件夹中该文件的路径.
 *
 *  @param fileName 文件的名字.
 *
 *  @return 该文件的路径.
 */
+ (nullable NSString *)filePathAtDocumentWithFileName:(nullable NSString *)fileName;

/**
 *  文件在Document中是否存在.
 *
 *  @param fileName 文件的名字.
 *
 *  @return 是否存在的状态.
 */
+ (BOOL)fileExistAtDocumentWithFileName:(nullable NSString *)fileName;

/**
 *  文件在该路径是否存在.
 *
 *  @param filePath 需要查看文件的路径.
 *
 *  @return 文件是否存在的状态.
 */
+ (BOOL)fileExistAtFilePath:(nullable NSString *)filePath;

/**
 *  在Document中创建一个文件.
 *
 *  @param fileName 文件的状态.
 *  @param yesOrNo  若存在是否需要删除重新创建: yes 需要删除 no 不需要删除.
 *
 *  @return 创建文件成功与否的状态.
 */
+ (BOOL)createFileAtDocumentWithFileName:(nullable NSString *)fileName isRemoveExistFile:(BOOL)yesOrNo;

/**
 *  删除Document中的一个文件.
 *
 *  @param fileName 需要删除文件的名字.
 *
 *  @return 删除文件的成功与否的状态.
 */
+ (BOOL)removeFileAtDocumentWithFileName:(nullable NSString *)fileName;

/**
 *  Document中所有文件的名字.
 *
 *  @return 所有文件名字的数组.
 */
+ (nullable NSArray<NSString *> *)allFileNameAtDocument;

@end
