//
//  NSObject+JOExtend.m
//  JOProjectBaseSDK
//
//  Created by 刘维 on 16/3/18.
//  Copyright © 2016年 刘维. All rights reserved.
//

#import "NSObject+JOExtend.h"
#import <objc/objc.h>
#import <objc/runtime.h>

#if OBJC_API_VERSION >= 2
#define JOGetClass(obj)	object_getClass(obj)
#else
#define JOGetClass(obj)	(obj ? obj->isa : Nil)
#endif

#define JOInvocation_Init \
NSMethodSignature * sig = [self methodSignatureForSelector:selector]; \
if (!sig) { \
    [self doesNotRecognizeSelector:selector]; \
    return nil; \
} \
NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sig]; \
if (!invocation) { \
    [self doesNotRecognizeSelector:selector]; \
    return nil; \
} \
[invocation  setTarget:self]; \
[invocation setSelector:selector]; \

#define JOVa_List \
va_list args; \
va_start(args, parameter); \
[invocation setArgument:&parameter atIndex:2];\
[NSObject setInvocation:invocation withSig:sig andArgs:args]; \
va_end(args); \

//JO_DUMMY_CLASS(NSObject_ThreadPerformExtend)

@implementation NSObject(JOThreadPerformExtend)

- (id)JOPerformSelector:(SEL)selector arguments:(id)parameter,...{

    JOInvocation_Init;
    JOVa_List;
    [invocation invoke];
    return [NSObject returnFromInv:invocation withSig:sig];
}

- (id)JOPerformSelector:(SEL)selector afterDelay:(NSTimeInterval)delay arguments:(id)parameter,...{

    JOInvocation_Init;
    JOVa_List;
    [invocation retainArguments];
    [invocation performSelector:@selector(invoke) withObject:nil afterDelay:delay];
    return [NSObject returnFromInv:invocation withSig:sig];
}

- (id)JOPerformSelectorOnMainThread:(SEL)selector waitUntilDone:(BOOL)wait arguments:(id)parameter,...{

    JOInvocation_Init;
    JOVa_List;
    
    if (!wait){
        [invocation retainArguments];
    }
    [invocation performSelectorOnMainThread:@selector(invoke) withObject:nil waitUntilDone:wait];
    
    //wait 为YES :经测试得出,会阻塞当前需要执行的方法,等到主线程把执行完才会就绪执行该方法.
    //wait 为NO: 则不需要等待当前线程执行完主线程立刻执行该方法.异步执行.
    //所以YES的时候，才能有返回值, NO的话 是异步执行的,可能你返回的时候 该方法已经走完。
    return wait ? [NSObject returnFromInv:invocation withSig:sig] : nil;
}

- (id)JOPerformSelector:(SEL)selector onThread:(NSThread *)thr  waitUntilDone:(BOOL)wait arguments:(id)parameter,...{

    JOInvocation_Init;
    JOVa_List;
    
    if (!wait){
        [invocation retainArguments];
    }
    [invocation performSelector:@selector(invoke) onThread:thr withObject:nil waitUntilDone:wait];
    return wait ? [NSObject returnFromInv:invocation withSig:sig] : nil;
}

- (id)JOPerformSelectorInBackground:(SEL)selector arguments:(id)parameter,...{

    JOInvocation_Init;
    JOVa_List;

    [invocation retainArguments];
    [invocation performSelectorInBackground:@selector(invoke) withObject:nil];
    
    return [NSObject returnFromInv:invocation withSig:sig];
}


#pragma mark - 下面两个方法来源于 YYKit 
    
+ (id)returnFromInv:(NSInvocation *)inv withSig:(NSMethodSignature *)sig {
        NSUInteger length = [sig methodReturnLength];
        if (length == 0) return nil;
        
        char *type = (char *)[sig methodReturnType];
        while (*type == 'r' || // const
               *type == 'n' || // in
               *type == 'N' || // inout
               *type == 'o' || // out
               *type == 'O' || // bycopy
               *type == 'R' || // byref
               *type == 'V') { // oneway
            type++; // cutoff useless prefix
        }
        
#define return_with_number(_type_) \
do { \
_type_ ret; \
[inv getReturnValue:&ret]; \
return @(ret); \
} while (0)
        
        switch (*type) {
            case 'v': return nil; // void
            case 'B': return_with_number(bool);
            case 'c': return_with_number(char);
            case 'C': return_with_number(unsigned char);
            case 's': return_with_number(short);
            case 'S': return_with_number(unsigned short);
            case 'i': return_with_number(int);
            case 'I': return_with_number(unsigned int);
            case 'l': return_with_number(int);
            case 'L': return_with_number(unsigned int);
            case 'q': return_with_number(long long);
            case 'Q': return_with_number(unsigned long long);
            case 'f': return_with_number(float);
            case 'd': return_with_number(double);
            case 'D': { // long double
                long double ret;
                [inv getReturnValue:&ret];
                return [NSNumber numberWithDouble:ret];
            };
                
            case '@': { // id
                id ret = nil;
                [inv getReturnValue:&ret];
                return ret;
            };
                
            case '#': { // Class
                Class ret = nil;
                [inv getReturnValue:&ret];
                return ret;
            };
                
            default: { // struct / union / SEL / void* / unknown
                const char *objCType = [sig methodReturnType];
                char *buf = calloc(1, length);
                if (!buf) return nil;
                [inv getReturnValue:buf];
                NSValue *value = [NSValue valueWithBytes:buf objCType:objCType];
                free(buf);
                return value;
            };
        }
#undef return_with_number
}
    
+ (void)setInvocation:(NSInvocation *)inv withSig:(NSMethodSignature *)sig andArgs:(va_list)args {
        NSUInteger count = [sig numberOfArguments];
    
        //根据sig里面去的该位置的参数类型 然后在去va_list根据参数类型取具体的参数,va_list去参数若给定的参数类型不匹配则会carsh.
        for (int index = 3; index < count; index++) {
            
            //获取Sig索引位置的参数的类型,如果有前缀属性的话需要去掉该属性再去具体的类型
            char *type = ({
                type = (char *)[sig getArgumentTypeAtIndex:index];
                while (*type == 'r' || // const
                       *type == 'n' || // in
                       *type == 'N' || // inout
                       *type == 'o' || // out
                       *type == 'O' || // bycopy
                       *type == 'R' || // byref
                       *type == 'V') { // oneway
                    type++; // cutoff useless prefix
                }
                type;
            });
            
            BOOL unsupportedType = NO;
            switch (*type) {
                case 'v': // 1: void
                case 'B': // 1: bool
                case 'c': // 1: char / BOOL
                case 'C': // 1: unsigned char
                case 's': // 2: short
                case 'S': // 2: unsigned short
                case 'i': // 4: int / NSInteger(32bit)
                case 'I': // 4: unsigned int / NSUInteger(32bit)
                case 'l': // 4: long(32bit)
                case 'L': // 4: unsigned long(32bit)
                { // 'char' and 'short' will be promoted to 'int'.
                    int arg = va_arg(args, int);
                    [inv setArgument:&arg atIndex:index];
                } break;
                    
                case 'q': // 8: long long / long(64bit) / NSInteger(64bit)
                case 'Q': // 8: unsigned long long / unsigned long(64bit) / NSUInteger(64bit)
                {
                    long long arg = va_arg(args, long long);
                    [inv setArgument:&arg atIndex:index];
                } break;
                    
                case 'f': // 4: float / CGFloat(32bit)
                { // 'float' will be promoted to 'double'.
                    double arg = va_arg(args, double);
                    float argf = arg;
                    [inv setArgument:&argf atIndex:index];
                }
                    
                case 'd': // 8: double / CGFloat(64bit)
                {
                    double arg = va_arg(args, double);
                    [inv setArgument:&arg atIndex:index];
                } break;
                    
                case 'D': // 16: long double
                {
                    long double arg = va_arg(args, long double);
                    [inv setArgument:&arg atIndex:index];
                } break;
                    
                case '*': // char *
                case '^': // pointer
                {
                    void *arg = va_arg(args, void *);
                    [inv setArgument:&arg atIndex:index];
                } break;
                    
                case ':': // SEL
                {
                    SEL arg = va_arg(args, SEL);
                    [inv setArgument:&arg atIndex:index];
                } break;
                    
                case '#': // Class
                {
                    Class arg = va_arg(args, Class);
                    [inv setArgument:&arg atIndex:index];
                } break;
                    
                case '@': // id
                {
                    id arg = va_arg(args, id);
                    [inv setArgument:&arg atIndex:index];
                } break;
                    
                case '{': // struct
                {
                    if (strcmp(type, @encode(CGPoint)) == 0) {
                        CGPoint arg = va_arg(args, CGPoint);
                        [inv setArgument:&arg atIndex:index];
                    } else if (strcmp(type, @encode(CGSize)) == 0) {
                        CGSize arg = va_arg(args, CGSize);
                        [inv setArgument:&arg atIndex:index];
                    } else if (strcmp(type, @encode(CGRect)) == 0) {
                        CGRect arg = va_arg(args, CGRect);
                        [inv setArgument:&arg atIndex:index];
                    } else if (strcmp(type, @encode(CGVector)) == 0) {
                        CGVector arg = va_arg(args, CGVector);
                        [inv setArgument:&arg atIndex:index];
                    } else if (strcmp(type, @encode(CGAffineTransform)) == 0) {
                        CGAffineTransform arg = va_arg(args, CGAffineTransform);
                        [inv setArgument:&arg atIndex:index];
                    } else if (strcmp(type, @encode(CATransform3D)) == 0) {
                        CATransform3D arg = va_arg(args, CATransform3D);
                        [inv setArgument:&arg atIndex:index];
                    } else if (strcmp(type, @encode(NSRange)) == 0) {
                        NSRange arg = va_arg(args, NSRange);
                        [inv setArgument:&arg atIndex:index];
                    } else if (strcmp(type, @encode(UIOffset)) == 0) {
                        UIOffset arg = va_arg(args, UIOffset);
                        [inv setArgument:&arg atIndex:index];
                    } else if (strcmp(type, @encode(UIEdgeInsets)) == 0) {
                        UIEdgeInsets arg = va_arg(args, UIEdgeInsets);
                        [inv setArgument:&arg atIndex:index];
                    } else {
                        unsupportedType = YES;
                    }
                } break;
                    
                case '(': // union
                {
                    unsupportedType = YES;
                } break;
                    
                case '[': // array
                {
                    unsupportedType = YES;
                } break;
                    
                default: // what?!
                {
                    unsupportedType = YES;
                } break;
            }
            
            if (unsupportedType) {
                // Try with some dummy type...
                
                NSUInteger size = 0;
                NSGetSizeAndAlignment(type, &size, NULL);
                
#define case_size(_size_) \
else if (size <= 4 * _size_ ) { \
struct dummy { char tmp[4 * _size_]; }; \
struct dummy arg = va_arg(args, struct dummy); \
[inv setArgument:&arg atIndex:index]; \
}
                if (size == 0) { }
                case_size( 1) case_size( 2) case_size( 3) case_size( 4)
                case_size( 5) case_size( 6) case_size( 7) case_size( 8)
                case_size( 9) case_size(10) case_size(11) case_size(12)
                case_size(13) case_size(14) case_size(15) case_size(16)
                case_size(17) case_size(18) case_size(19) case_size(20)
                case_size(21) case_size(22) case_size(23) case_size(24)
                case_size(25) case_size(26) case_size(27) case_size(28)
                case_size(29) case_size(30) case_size(31) case_size(32)
                case_size(33) case_size(34) case_size(35) case_size(36)
                case_size(37) case_size(38) case_size(39) case_size(40)
                case_size(41) case_size(42) case_size(43) case_size(44)
                case_size(45) case_size(46) case_size(47) case_size(48)
                case_size(49) case_size(50) case_size(51) case_size(52)
                case_size(53) case_size(54) case_size(55) case_size(56)
                case_size(57) case_size(58) case_size(59) case_size(60)
                case_size(61) case_size(62) case_size(63) case_size(64)
                else {
                    /*
                     Larger than 256 byte?! I don't want to deal with this stuff up...
                     Ignore this argument.
                     */
                    struct dummy {char tmp;};
                    for (int i = 0; i < size; i++) va_arg(args, struct dummy);
                    NSLog(@"不支持类型:%s (%lu bytes)",
                          [sig getArgumentTypeAtIndex:index],(unsigned long)size);
                }
#undef case_size
                
            }
        }
}

@end

@implementation NSObject(JOSwizzle)

+ (BOOL)JOSwizzleInstanceMethod:(SEL)sel withMehtod:(SEL)newSel{

    Method method = class_getInstanceMethod(self, sel);
    Method newMethod = class_getInstanceMethod(self, newSel);
    
    //确保两个method都存在.
    if (!method || !newMethod) {
        return NO;
    }
    
    //将两个method添加到对象的方法列表中去(如果不存在则添加,存在就不添加)
    class_addMethod(self, sel, class_getMethodImplementation(self, sel), method_getTypeEncoding(method));
    class_addMethod(self, newSel, class_getMethodImplementation(self, newSel), method_getTypeEncoding(newMethod));
    //交换两个方法的的IMP
    method_exchangeImplementations(method, newMethod);
    
    return YES;
}

+ (BOOL)JOSwizzleClassMethod:(SEL)sel withMehtod:(SEL)newSel{
    
    return [JOGetClass(self) JOSwizzleInstanceMethod:sel withMehtod:newSel];
}

@end

@implementation NSObject(JORuntimeExtend)

+ (NSArray *)JOGetAllSelector{

    NSMutableArray *selectorArray = [NSMutableArray array];
    u_int count;
    
    Method *methods = class_copyMethodList(self, &count);
    
    for (int i = 0; i < count; i++) {
        [selectorArray addObject:NSStringFromSelector(method_getName(methods[i]))];
    }
    free(methods);
    return selectorArray;
}

+ (NSArray *)JOGetAllProperty{

    NSMutableArray *propertyArray = [NSMutableArray array];
    u_int count;
    
    Class tempClass = self;
    
    do{
    
        objc_property_t *properties = class_copyPropertyList(tempClass, &count);
        for (int i = 0; i < count; i++) {
            [propertyArray addObject:[NSString stringWithCString:property_getName(properties[i]) encoding:NSUTF8StringEncoding]];
        }
        free(properties);
        tempClass = [tempClass superclass];
        
    }while (![tempClass isEqual:[NSObject class]]);
    
    return propertyArray;
}

- (NSDictionary *)JOGetAllPropertyDictionary{

    NSMutableDictionary *propertyDictionary = [NSMutableDictionary dictionary];
    
    for (NSString *property in [[self class] JOGetAllProperty]) {
        if ([self valueForKey:property]) {
            [propertyDictionary setObject:[self valueForKey:property] forKey:property];
        }
    }
    return propertyDictionary;
}

+ (NSArray *)JOGetProperty{

    NSMutableArray *propertyArray = [NSMutableArray array];
    u_int count;
    
    objc_property_t *properties = class_copyPropertyList(self, &count);
    for (int i = 0; i < count; i++) {
        [propertyArray addObject:[NSString stringWithCString:property_getName(properties[i]) encoding:NSUTF8StringEncoding]];
    }
    free(properties);
    return propertyArray;
}

- (NSDictionary *)JOGetProjectDictionary{

    NSMutableDictionary *propertyDictionary = [NSMutableDictionary dictionary];
    for (NSString *property in [[self class] JOGetProperty]) {
        
        if ([self valueForKey:property]) {
            [propertyDictionary setObject:[self valueForKey:property] forKey:property];
        }
    }
    return propertyDictionary;
    
}

+ (NSArray *)JOGetAllIvar{

    NSMutableArray *ivarArray = [NSMutableArray array];
    u_int count;
    Ivar *ivars = class_copyIvarList(self, &count);
    for ( int i = 0; i < count; i++) {
        [ivarArray addObject:[NSString stringWithCString:ivar_getName(ivars[i]) encoding:NSUTF8StringEncoding]];
    }
    return ivarArray;
}

+ (NSArray *)JOGetAllProtocol{

    NSMutableArray *protocolArray = [NSMutableArray array];
    u_int count;
    Protocol * __unsafe_unretained *protocols = class_copyProtocolList(self, &count);
    for (int i = 0; i < count; i++) {
        [protocolArray addObject:[NSString stringWithCString:protocol_getName(protocols[i]) encoding:NSUTF8StringEncoding]];
    }
    free(protocols);
    return protocolArray;
}

@end


