//
//  DataBaseManager.h
//  RetailConnect
//
//  Created by i-MaC on 12/22/12.
//  Copyright (c) 2012 i-MaC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "AppDelegate.h"
#import "Constant.h"

@interface DataBaseManager : NSObject
{
	NSString* _dataBasePath;
	sqlite3 *_database;
	BOOL copyDb;
    NSString* dbName;
    
    
    NSString *path;
    NSString *pngpath;
    NSString *jpegPath;
    NSString *docFile;
}

+(DataBaseManager*)dataBaseManager;
-(NSString*) getDBPath;
-(void)openDatabase;

-(BOOL)createDatabase;
-(BOOL)execute:(NSString*)sqlQuery resultsArray:(NSMutableArray*)dataTable;
-(BOOL)execute:(NSString*)sqlStatement;

/**********************************ibeacon Store************************************/

-(BOOL )insertAlertDataToDatabase:(NSArray *)dataArray;

-(void)saveDeviceLogInLocalDB:(NSDictionary*)logDict;



/****************************Smart Armor********************************/
-(NSString*)getMainImageUrlByDeviceID:(NSString*)deviceID;

//-(NSString*)getFirstNameFromUserID:(NSString*)userID;



@end


