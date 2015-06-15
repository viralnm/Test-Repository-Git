//
//  URLManager.m
//  MRService
//
//  Created by Oneclick IT Solution on 5/21/14.
//  Copyright (c) 2014 One Click IT Consultancy. All rights reserved.
//

#import "URLManager.h"

@implementation URLManager
@synthesize delegate;
@synthesize commandName;
@synthesize isString;

#pragma mark -
#pragma mark Network Call Methods
#pragma mark -

-(id)init{
    if(self = [super init]){
        _weak = self;
    }
    return self;
}

+ (instancetype)sharedInstance
{
	static id instance_ = nil;
	static dispatch_once_t onceToken;
	
	dispatch_once(&onceToken, ^{
		instance_ = [[self alloc] init];
	});
	
	return instance_;
}
- (void)urlCall:(NSString*)path withParameters:(NSMutableDictionary*)argments callBack:(URLManagerCallBack)callBack forCommandName:(NSString*)command
{
    _weak.callBackResult = callBack;
    _weak.commandName = command;
    [self urlCall:path withParameters:argments];
}
- (void)urlCall:(NSString*)path withParameters:(NSMutableDictionary*)dictionary {
    NSString * urlStr = [NSString stringWithFormat:@"%@",path];
	NSMutableURLRequest *theRequest = [[NSMutableURLRequest alloc] init] ;
    NSURL *url=[NSURL URLWithString:urlStr];
	[theRequest setURL:url];//viral
    
    NSLog(@"urlStr========%@",urlStr);
    
//    NSURL *url=[NSURL URLWithString:urlStr];
//    NSMutableURLRequest *theRequest = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:120];

	if (dictionary!=nil)
    {
//		NSString * requestStr = [self postStringFromDictionary:dictionary];
        NSString * requestStr = [dictionary JSONRepresentation];
        
        NSLog(@"requestStr====%@",requestStr);

		NSData *requestData = [requestStr dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
		NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]];
		[theRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
		[theRequest setHTTPBody:requestData];
	}
//	[theRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [theRequest setValue:@"json/application" forHTTPHeaderField:@"Content-Type"];

	[theRequest setHTTPMethod:@"POST"];
	[theRequest setHTTPShouldHandleCookies:NO];
//	[theRequest setTimeoutInterval:30];
    [theRequest setTimeoutInterval:120];

    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:_weak];

	if (theConnection)
		receivedData = [NSMutableData data];
}


- (void)getUrlCall:(NSString*)path withParameters:(NSMutableDictionary*)dictionary {
	NSString * urlStr = [NSString stringWithFormat:@"%@",path];
	NSMutableURLRequest *theRequest = [[NSMutableURLRequest alloc] init];
	
	if (dictionary!=nil) {
        
		NSString *requestStr = [self getStringFromDictionary:dictionary];
        urlStr = [NSString stringWithFormat:@"%@?%@",path,requestStr];
        urlStr = [urlStr stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
	}
    
	[theRequest setURL:[NSURL URLWithString:urlStr]];
	[theRequest setHTTPMethod:@"GET"];
	[theRequest setHTTPShouldHandleCookies:NO];
//	[theRequest setTimeoutInterval:30];
    [theRequest setTimeoutInterval:120];

	NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:_weak];
	if (theConnection)
		receivedData = [NSMutableData data];
}


- (NSString *)getStringFromDictionary:(NSMutableDictionary*)dictionary {
	NSString *argumentStr = @"";
	
	NSArray *myKeys = [dictionary allKeys];
	NSArray *sortedKeys = [myKeys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
	
	for (int i=0 ; i<[sortedKeys count]; i++)  {
		if ( i != 0)
			argumentStr = [argumentStr stringByAppendingString:@"&"];
        
		NSString *key = [sortedKeys objectAtIndex:i];
		NSString *value = [dictionary objectForKey:key];
		
		NSString *formateStr = [NSString stringWithFormat:@"%@=%@",key,value];
		argumentStr = [argumentStr stringByAppendingString:formateStr];
	}
	return argumentStr;
}

- (NSString *)postStringFromDictionary:(NSMutableDictionary*)dictionary {
	NSString *argumentStr = @"";
	
	NSArray *myKeys = [dictionary allKeys];
	NSArray *sortedKeys = [myKeys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
	
	for (int i=0 ; i<[sortedKeys count]; i++)  {
		if ( i != 0)
			argumentStr = [argumentStr stringByAppendingString:@"&"];
        
		NSString *key = [sortedKeys objectAtIndex:i];
		NSString *value = [dictionary objectForKey:key];
		
		if ([value isKindOfClass:[NSString class]]) {
			value = [value stringByReplacingOccurrencesOfString:@"$" withString:@"%24"];
			value = [value stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
			value = [value stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
			value = [value stringByReplacingOccurrencesOfString:@"," withString:@"%2C"];
			value = [value stringByReplacingOccurrencesOfString:@"/" withString:@"%2F"];
			value = [value stringByReplacingOccurrencesOfString:@":" withString:@"%3A"];
			value = [value stringByReplacingOccurrencesOfString:@";" withString:@"%3B"];
			value = [value stringByReplacingOccurrencesOfString:@"=" withString:@"%3D"];
			value = [value stringByReplacingOccurrencesOfString:@"?" withString:@"%3F"];
			value = [value stringByReplacingOccurrencesOfString:@"@" withString:@"%40"];
            
		}
		
		NSString *formateStr = [NSString stringWithFormat:@"%@=%@",key,value];
		argumentStr = [argumentStr stringByAppendingString:formateStr];
	}
	return argumentStr;
}

#pragma mark -
#pragma mark NSURLConnection Methods
#pragma mark -

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [receivedData setLength:0];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [receivedData appendData:data];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	[delegate onError:error];
    
//    NSInteger ancode = [error code];
//    [APP_DELEGATE ShowNoNetworkConnectionPopUpWithErrorCode:ancode];

    
//    if (_weak.callBackResult) {
//        _weak.callBackResult(nil,error,_weak.commandName);
//    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	NSString *responseString = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    NSLog(@"responseString====%@",responseString);
	if (self.isString) {
        if (_weak.commandName!=nil && _weak.commandName!=NULL) {
            NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
            [result setObject:responseString forKey:@"result"];
            [result setObject:_weak.commandName forKey:@"commandName"];
            
            if (delegate)
                [_weak.delegate onResult:result];
//            if (_weak.callBackResult) {
//                _weak.callBackResult(result,nil,_weak.commandName);
//            }
        }
        else {
            if (delegate)
                [_weak.delegate onResult:(NSDictionary*)responseString];
//            if (_weak.callBackResult) {
//                _weak.callBackResult((NSDictionary*)responseString,nil,nil);
//            }
        }
	}
	else
    {
		NSError *error;
		SBJSON *json = [SBJSON new];
//		NSLog(@"responseString:::%@",responseString);
		NSDictionary *response = [json objectWithString:responseString error:&error];
		if (response == nil ) {
			NSLog(@"response is nil");
            
            [delegate onError:error];
            NSLog(@"error==%@",error);
            
//            NSInteger ancode = [error code];
//            [APP_DELEGATE ShowNoNetworkConnectionPopUpWithErrorCode:ancode];
		}
		else
        {
			if (_weak.commandName!=nil && _weak.commandName!=NULL) {
				NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
				[result setObject:response forKey:@"result"];
				[result setObject:_weak.commandName forKey:@"commandName"];
				if (delegate)
					[_weak.delegate onResult:result];
//                if (_weak.callBackResult) {
//                    _weak.callBackResult((NSDictionary*)result,nil,_weak.commandName);
//                }
			}
			else {
				if (delegate)
					[_weak.delegate onResult:response];
//                if (_weak.callBackResult) {
//                    _weak.callBackResult(response,nil,nil);
//                }
			}
		}
	}
}

@end

