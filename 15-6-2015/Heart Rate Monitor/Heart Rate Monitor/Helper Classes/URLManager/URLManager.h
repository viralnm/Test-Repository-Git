//
//  URLManager.h
//  MRService
//
//  Created by Oneclick IT Solution on 5/21/14.
//  Copyright (c) 2014 One Click IT Consultancy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSON1.h"

NSString *responseString;

typedef void(^URLManagerCallBack)(NSDictionary *result, NSError *error, NSString *commandName);

//delegate protocol
@protocol URLManagerDelegate
- (void)onResult:(NSDictionary *)result;
- (void)onError:(NSError *)error;
@end


@interface URLManager : NSObject  {
    //object for saving receiving data
	NSMutableData *receivedData;
    
    //delegate object
	//id<URLManagerDelegate> delegate;
    
    //to know from which web service call
	NSString *commandName;
    
    //to know response
	BOOL isString;
    
    //to know progress
    float expectedBytes;
    
    //to assign self object as weak
    __weak URLManager *_weak;
}

//delegate property
@property (nonatomic, weak) id<URLManagerDelegate> delegate;

//to know from which web service call
@property (nonatomic, retain) NSString *commandName;

//to know response
@property (nonatomic, assign) BOOL isString;

//declering call back
@property (nonatomic, strong) URLManagerCallBack callBackResult;

//shared instance
+ (instancetype)sharedInstance;

//for POST method
- (void)urlCall:(NSString*)path withParameters:(NSMutableDictionary*)dictionary;
- (void)urlCall:(NSString*)path withParameters:(NSMutableDictionary*)argments callBack:(URLManagerCallBack)callBack forCommandName:(NSString*)command;
- (NSString *)postStringFromDictionary:(NSMutableDictionary*)dictionary;

//for GET method
- (void)getUrlCall:(NSString*)path withParameters:(NSMutableDictionary*)dictionary;
- (NSString *)getStringFromDictionary:(NSMutableDictionary*)dictionary;
@end
