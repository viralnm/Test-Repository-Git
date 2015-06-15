//
//  DataBaseManager.m
//  RetailConnect
//
//  Created by i-MaC on 12/22/12.
//  Copyright (c) 2012 i-MaC. All rights reserved.
//

#import "DataBaseManager.h"

#define DATABASE_NAME @"SmartArmorDB.sqlite"

static DataBaseManager *dataBaseManager = nil;

@implementation DataBaseManager

#pragma mark -
#pragma mark - DataBaseManager initialization
-(id) init
{
	self = [super init];
	if (self) 
    {
		// get full path of database in documents directory
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		path = [paths objectAtIndex:0];
		_dataBasePath = [path stringByAppendingPathComponent:DATABASE_NAME];
		
		_database = nil;
		[self openDatabase];
    }
	return self;
}

-(void)saveImage
{
    UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@""]]];
    
    NSLog(@"%f,%f",image.size.width,image.size.height);
    
    // Let's save the file into Document folder.**
    
   // NSString *Dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
       pngpath = [NSString stringWithFormat:@"%@/test.png",path];// this path if you want save reference path in sqlite
    NSData *data1 = [NSData dataWithData:UIImagePNGRepresentation(image)];
    NSString *savedInfoImagePath = [path stringByAppendingPathComponent:@"infoImage.png"];
    [data1 writeToFile:savedInfoImagePath atomically:YES];
    
    /*NSLog(@"saving jpeg");
    NSString *jpegPath = [NSString stringWithFormat:@"%@/test.jpeg",path];// this path if you want save reference path in sqlite
    NSData *data2 = [NSData dataWithData:UIImageJPEGRepresentation(image, 1.0f)];//1.0f = 100% quality
    [data2 writeToFile:jpegFilePath atomically:YES];
    */
    NSLog(@"saving image done");
}

/*
 * open database
 * if database doesn't exist, create it
 *
 */
-(void)openDatabase 
{
	BOOL ok;
	NSError *error;
	
	/*
	 * determine if database exists.
	 * create a file manager object to test existence
	 *
	 */
	NSFileManager *fm = [NSFileManager defaultManager]; // file manager
	ok = [fm fileExistsAtPath:_dataBasePath];
    
	// if database not there, copy from resource to path
	if (!ok) 
    {
        // location in resource bundle
        NSString *appPath = [[[NSBundle mainBundle] resourcePath]
        stringByAppendingPathComponent:DATABASE_NAME];
        if ([fm fileExistsAtPath:appPath]) {
            // copy from resource to where it should be
            copyDb = [fm copyItemAtPath:appPath toPath:_dataBasePath error:&error];
            if (error!=nil) {
                copyDb = FALSE;
            }
            ok = copyDb;
        }
    }
    
    
    // open database
    if (sqlite3_open([_dataBasePath UTF8String], &_database) != SQLITE_OK) 
    {
        sqlite3_close(_database); // in case partially opened
        _database = nil; // signal open error
    }
    
    if (!copyDb && !ok) 
    { // first time and database not copied
        ok = [self createDatabase]; // create empty database
        if (ok) 
        {
            // Populating Table first time from the keys.plist
            /*	NSString *pListPath = [[NSBundle mainBundle] pathForResource:@"ads" ofType:@"plist"];
             NSArray *contents = [NSArray arrayWithContentsOfFile:pListPath];
             for (NSDictionary* dictionary in contents) {
             
             NSArray* keys = [dictionary allKeys];
             [self execute:[NSString stringWithFormat:@"insert into ads values('%@','%@','%@')",[dictionary objectForKey:[keys objectAtIndex:0]], [dictionary objectForKey:[keys objectAtIndex:1]],[dictionary objectForKey:[keys objectAtIndex:2]]]];
             }*/
        }
    }
    
    if (!ok) 
    {   
        // problems creating database
        NSAssert1(0, @"Problem creating database [%@]",
                  [error localizedDescription]);
    }
}

-(BOOL)createDatabase
{
    BOOL ret;
    int rc;
    
    // SQL to create new database
    
    NSArray *queries = [NSArray arrayWithObjects:
                        
        @"CREATE TABLE 'ActivityLogTable' ('id' INTEGER PRIMARY KEY  NOT NULL , 'device_id' VARCHAR,  'log_message' VARCHAR, 'log_type' VARCHAR, 'user_id' VARCHAR, 'activity_time' VARCHAR, 'date' VARCHAR, 'latitude' VARCHAR, 'longitude' VARCHAR)",
                        
        @"CREATE TABLE 'User_Created_Device' ('id' INTEGER PRIMARY KEY  NOT NULL , 'server_device_id' VARCHAR, 'device_id' VARCHAR , 'device_name' VARCHAR, 'device_address' VARCHAR, 'device_auth_passkey' VARCHAR, 'device_unlock_passkey' VARCHAR, 'isPrimaryDevice' VARCHAR, 'Peripheral' VARCHAR, 'latitude' VARCHAR, 'longitude' VARCHAR, 'main_image' VARCHAR, 'thumb_image' VARCHAR, 'user_id' VARCHAR, 'lost_status' VARCHAR, 'device_password_saved' VARCHAR, 'server_default_image' VARCHAR)",
                        
        @"CREATE TABLE 'Scanned_Device_History_Table' ('id' INTEGER PRIMARY KEY  NOT NULL , 'device_id' VARCHAR, 'latitude' VARCHAR, 'longitude' VARCHAR, 'date' VARCHAR, 'date_time' VARCHAR, 'device_owner_id' VARCHAR)" ,Nil];
    
    if(queries != NULL)
    {
        for (NSString* sql in queries) 
        {
            sqlite3_stmt *stmt;
            rc = sqlite3_prepare_v2(_database, [sql UTF8String], -1, &stmt, NULL);
            ret = (rc == SQLITE_OK);
//            NSLog(@" create %@",sql);
            if (ret)
            {
                // statement built, execute
                rc = sqlite3_step(stmt);
                ret = (rc == SQLITE_DONE);
                sqlite3_finalize(stmt); // free statement
                //sqlite3_reset(stmt);
            }
        }
    }
    else{
        return NO;//viral
    }
    return ret;
}// createdatabase


/*
-(BOOL)createDatabase
{
    BOOL ret;
    int rc;
    
    // SQL to create new database
    
    
    NSArray *queries = [NSArray arrayWithObjects:
                        @"CREATE TABLE 'ActivityLogTable' ('id' INTEGER PRIMARY KEY  NOT NULL , 'device_id' VARCHAR,  'log_message' VARCHAR, 'log_type' VARCHAR, 'user_id' VARCHAR, 'activity_time' VARCHAR, 'date' VARCHAR, 'latitude' VARCHAR, 'longitude' VARCHAR)",
                        
                        @"CREATE TABLE 'User_Created_Device' ('id' INTEGER PRIMARY KEY  NOT NULL , 'server_device_id' VARCHAR, 'device_id' VARCHAR , 'device_name' VARCHAR, 'device_address' VARCHAR, 'device_auth_passkey' VARCHAR, 'device_unlock_passkey' VARCHAR, 'isPrimaryDevice' VARCHAR, 'Peripheral' VARCHAR, 'latitude' VARCHAR, 'longitude' VARCHAR, 'main_image' VARCHAR, 'thumb_image' VARCHAR, 'user_id' VARCHAR, 'lost_status' VARCHAR)",
                        
                        @"CREATE TABLE 'Scanned_Device_History_Table' ('id' INTEGER PRIMARY KEY  NOT NULL , 'device_id' VARCHAR, 'latitude' VARCHAR, 'longitude' VARCHAR, 'date' VARCHAR, 'date_time' VARCHAR, 'device_owner_id' VARCHAR)" ,Nil];
    
    if(queries != NULL)
    {
        for (NSString* sql in queries)
        {
            sqlite3_stmt *stmt;
            rc = sqlite3_prepare_v2(_database, [sql UTF8String], -1, &stmt, NULL);
            ret = (rc == SQLITE_OK);
            //            NSLog(@" create %@",sql);
            if (ret)
            {
                // statement built, execute
                rc = sqlite3_step(stmt);
                ret = (rc == SQLITE_DONE);
                sqlite3_finalize(stmt); // free statement
                //sqlite3_reset(stmt);
            }
        }
    }
    else{
        return NO;//viral
    }
    return ret;
}// createdatabase*/

-(BOOL)insertAlertDataToDatabase:(NSArray *)dataArray
{
    @try
	{
        
		// insert all other data
		sqlite3_stmt *statement=nil;
        sqlite3_stmt *init_statement =nil;
        NSString  *sqlQuery=nil;
        
        NSString* statemt;
        
        statemt = @"BEGIN EXCLUSIVE TRANSACTION";
        
        if (sqlite3_prepare_v2(_database, [statemt UTF8String], -1, &init_statement, NULL) != SQLITE_OK) {
            return NO;
        }
        if (sqlite3_step(init_statement) != SQLITE_DONE) {
            sqlite3_finalize(init_statement);
            return NO;
        }
        
        //CREATE TABLE 'wp_user_device'(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL , 'device_name' TEXT NOT NULL,'Device_photo' TEXT NOT NULL,'latitude' varchar(255) NOT NULL,'longitude' varchar(255) NOT NULL,'ieee' TEXT NOT NULL,'user_id' TEXT NOT NULL,'role' TEXT NOT NULL,'Lost_found' varchar(255) NOT NULL,'user_device_created' TEXT NOT NULL,'user_device_updated' TEXT NOT NULL) "
		sqlQuery=[NSString stringWithFormat:@"INSERT INTO AlertDetail ('time','name','msg') values(?,?,?)"];
        //const char *sql = (const char*)[sqlQuery UTF8String];
		if(sqlite3_prepare_v2(_database, [sqlQuery  UTF8String], -1, &statement, NULL)!=SQLITE_OK)
		{
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(_database));
		}
        
        NSDate *date = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *dateStr = [dateFormatter stringFromDate:date];
        NSLog(@"date==%@",dateStr);
        
        //  NSLog(@"date==%@",dateStr);
        
        NSString *emptyString = @"";
        // NSLog(@"dataArray %@",dataArray);
        
        //[args setObject:userField.text forKey:@"username"];
        //        [args setObject:passField.text forKey:@"password"];
        //        [args setObject:emailField.text forKey:@"email_id"];
        //        [args setObject:numbField.text forKey:@"phone_number"];
        
        
        for (NSDictionary *dicInfo in dataArray) {
            //[self cacheImage:[dicInfo  objectForKey:@"image"]];
            //=================Dictionary Data inserting===============
            
            NSString *row1 = [NSString stringWithFormat:@"%@", [dicInfo valueForKey:@"title"]];
            if (row1 && [row1 length] > 0) {
                sqlite3_bind_text(statement, 1,[row1 UTF8String] , -1, SQLITE_TRANSIENT);
            }
            else
            {
                sqlite3_bind_text(statement, 1, [emptyString UTF8String], -1, SQLITE_TRANSIENT);
            }
            NSString *row2 = [dicInfo valueForKey:@"geofenceName"];
            if (row2 && [row2 length] > 0) {
                sqlite3_bind_text(statement, 2,[row2 UTF8String] , -1, SQLITE_TRANSIENT);
            }
            else
            {
                sqlite3_bind_text(statement, 2, [emptyString UTF8String], -1, SQLITE_TRANSIENT);
            }
            
            NSString *row3 = [NSString stringWithFormat:@"%@",[dicInfo valueForKey:@"alertBody"]];
            if (row3 && [row3 length] > 0) {
                sqlite3_bind_text(statement, 3,[row3 UTF8String] , -1, SQLITE_TRANSIENT);
            }
            else
            {
                sqlite3_bind_text(statement, 3, [emptyString UTF8String], -1, SQLITE_TRANSIENT);
            }
            
            //[self insertLeadsTagsToDatabase:[dicInfo valueForKey:@"tags"] withLeadId:row1];
            // [self insertLeadImagesToDatabase:[dicInfo valueForKey:@"photos"] withLead:row1];
            while(YES){
                NSInteger result = sqlite3_step(statement);
                if(result == SQLITE_DONE){
					break;
                }
                else if(result != SQLITE_BUSY){
                    printf("db error: %s\n", sqlite3_errmsg(_database));
                    break;
                }
            }
            sqlite3_reset(statement);
            
        }
        
        statemt = @"COMMIT TRANSACTION";
        sqlite3_stmt *commitStatement;
        if (sqlite3_prepare_v2(_database, [statemt UTF8String], -1, &commitStatement, NULL) != SQLITE_OK) {
            printf("db error: %s\n", sqlite3_errmsg(_database));
            return NO;
        }
        if (sqlite3_step(commitStatement) != SQLITE_DONE) {
			printf("db error: %s\n", sqlite3_errmsg(_database));
            return NO;
        }
		
		sqlite3_finalize(statement);
        sqlite3_finalize(commitStatement);
	}
	@catch (NSException *e)
	{
		NSLog(@":::: Exception : %@",e);
	}
	return NO;
    
}






/*-(BOOL)createDatabase 
 {
 BOOL ret;
 int rc;
 
 // SQL to create new database
 
 const char *createItemsSQL = "CREATE TABLE 'Magazine' ('magazines' TEXT PRIMARY KEY  NOT NULL , 'MagazineName' TEXT)";
 
 sqlite3_stmt *stmt;
 rc = sqlite3_prepare_v2(_database, createItemsSQL, -1, &stmt, NULL);
 
 ret = (rc == SQLITE_OK);
 if (ret)
 { // statement built, execute
 rc = sqlite3_step(stmt);
 ret = (rc == SQLITE_DONE);
 }
 
 sqlite3_finalize(stmt); // free statement
 
 return ret;
 }*/
+(DataBaseManager*)dataBaseManager 
{
	if(dataBaseManager==nil) 
    {
		dataBaseManager = [[DataBaseManager alloc]init];		
	}
	return dataBaseManager;
}
- (NSString *) getDBPath 
{
	
	//Search for standard documents using NSSearchPathForDirectoriesInDomains
	//First Param = Searching the documents directory
	//Second Param = Searching the Users directory and not the System
	//Expand any tildes and identify home directories.
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	return [documentsDir stringByAppendingPathComponent:DATABASE_NAME];
}
#pragma mark -
#pragma mark - Insert Query
/*
 * Method to execute the simple queries
 */
-(BOOL)execute:(NSString*)sqlStatement 
{
	sqlite3_stmt *statement = nil;
    BOOL status = FALSE;
	NSLog(@"%@",sqlStatement);
	const char *sql = (const char*)[sqlStatement UTF8String];
    
	
	if(sqlite3_prepare_v2(_database, sql, -1, &statement, NULL) != SQLITE_OK) {	
        //   NSAssert1(0, @"Error while preparing  statement. '%s'", sqlite3_errmsg(_database));
        status = FALSE; 
    } else {
        status = TRUE;
    }
	if (sqlite3_step(statement)!=SQLITE_DONE) {
        //	NSAssert1(0, @"Error while deleting. '%s'", sqlite3_errmsg(_database));
        status = FALSE;
	} else {
        status = TRUE;
	}
	
	sqlite3_finalize(statement);
    return status;
}

#pragma mark -
#pragma mark - SQL query methods
/*
 * Method to get the data table from the database
 */
-(BOOL) execute:(NSString*)sqlQuery resultsArray:(NSMutableArray*)dataTable 
{
    
    char** azResult = NULL;
    int nRows = 0;
    int nColumns = 0;
    BOOL status = FALSE;
    char* errorMsg; //= malloc(255); // this is not required as sqlite do it itself
    const char* sql = [sqlQuery UTF8String];
    sqlite3_get_table(
                      _database,  /* An open database */
                      sql,        /* SQL to be evaluated */
                      &azResult,  /* Results of the query */
                      &nRows,     /* Number of result rows written here */
                      &nColumns,  /* Number of result columns written here */
                      &errorMsg   /* Error msg written here */
                      );
	
    if(azResult != NULL) 
    {
        nRows++; //because the header row is not account for in nRows
		
        for (int i = 1; i < nRows; i++)
        {
            NSMutableDictionary* row = [[NSMutableDictionary alloc]initWithCapacity:nColumns];
            for(int j = 0; j < nColumns; j++)
            {
                NSString*  value = nil;
                NSString* key = [NSString stringWithUTF8String:azResult[j]];
                if (azResult[(i*nColumns)+j]==NULL) 
                {
                    value = [NSString stringWithUTF8String:[[NSString string] UTF8String]];
                }
                else
                {
                    value = [NSString stringWithUTF8String:azResult[(i*nColumns)+j]];
                }
				
                [row setValue:value forKey:key];
            }
            [dataTable addObject:row];
        }
        status = TRUE;
        sqlite3_free_table(azResult);
    } 
    else
    {
        NSAssert1(0,@"Failed to execute query with message '%s'.",errorMsg);
        status = FALSE;
    }
    
    return 0;
}


/*
 * Method to get the integer value from the database
 */
-(NSInteger)getScalar:(NSString*)sqlStatement
{
	NSInteger count = -1;
	
	const char* sql= (const char *)[sqlStatement UTF8String];
	sqlite3_stmt *selectstmt;
	if(sqlite3_prepare_v2(_database, sql, -1, &selectstmt, NULL) == SQLITE_OK) 
    {
		while(sqlite3_step(selectstmt) == SQLITE_ROW) 
        {
			count = sqlite3_column_int(selectstmt, 0);
		}
	}
	sqlite3_finalize(selectstmt);
	
	return count;
}

/*
 * Method to get the string from the database
 */
-(NSString*)getValue:(NSString*)sqlStatement 
{
	
	NSString* value = nil;
	const char* sql= (const char *)[sqlStatement UTF8String];
	sqlite3_stmt *selectstmt;
	if(sqlite3_prepare_v2(_database, sql, -1, &selectstmt, NULL) == SQLITE_OK) 
    {
		while(sqlite3_step(selectstmt) == SQLITE_ROW) 
        {
			if ((char *)sqlite3_column_text(selectstmt, 0)!=nil)
            {
				value = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 0)];
			}
		}
	}
	return value;
}
#pragma mark -
#pragma mark - Dealloc
-(void)dealloc 
{
	sqlite3_close(_database);
    dataBaseManager = nil;
}
/*
- (void) cacheImage: (NSString *) ImageURLString
{
    NSURL *ImageURL = [NSURL URLWithString: ImageURLString];
    
    // Generate a unique path to a resource representing the image you want
    //NSString *filename = [[something unique, perhaps the image name]];
    //NSString *uniquePath = [TMP stringByAppendingPathComponent: filename];
    
    // Check for file existence
    if(![[NSFileManager defaultManager] fileExistsAtPath: path])
    {
        // The file doesn't exist, we should get a copy of it
        
        // Fetch image
        NSData *data = [[NSData alloc] initWithContentsOfURL: ImageURL];
        UIImage *image = [[UIImage alloc] initWithData: data];
        
        // Do we want to round the corners?
        // image = [self roundCorners: image];
        
        // Is it PNG or JPG/JPEG?
        // Running the image representation function writes the data from the image to a file
        if([ImageURLString rangeOfString:@".png" options: NSCaseInsensitiveSearch].location != NSNotFound)
        {
            [UIImagePNGRepresentation(image) writeToFile: path atomically: YES];
        }
        else if(
                [ImageURLString rangeOfString: @".jpg" options: NSCaseInsensitiveSearch].location != NSNotFound ||
                [ImageURLString rangeOfString: @".jpeg" options: NSCaseInsensitiveSearch].location != NSNotFound)
        {
            [UIImageJPEGRepresentation(image, 100) writeToFile: path atomically: YES];
            
        }
    }
} */

- (NSString *) cacheImage: (NSString *) ImageURLString
{
    NSURL *ImageURL = [NSURL URLWithString: ImageURLString];
   
   // NSLog(@"image url %@",ImageURL);
    // Generate a unique path to a resource representing the image you want
    
    //NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //NSString *docDir = [paths objectAtIndex: 0];
    //docFile = [docDir stringByAppendingPathComponent:@"raja" ];
    
    NSArray *coorArray1 = [ImageURLString   componentsSeparatedByString:@"/"];
    //NSLog(@" imageurlstring %@",ImageURLString);
    NSString *imageName=[coorArray1 lastObject];
//    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    //[appdelegate.arrSaveImagesFromCameraNLibrary addObject:imageName];
    docFile = [NSString stringWithFormat:@"%@/%@",path,imageName];
       // docFile = [NSString stringWithFormat:@"%@/%lf.png",path,[[NSDate date] timeIntervalSince1970]];
    // Check for file existence
    //NSLog(@"doc file %@",docFile);

    if(![[NSFileManager defaultManager] fileExistsAtPath: docFile])
    {
        // The file doesn't exist, we should get a copy of it
        // Fetch image
        NSData *data = [[NSData alloc] initWithContentsOfURL: ImageURL];
        
        UIImage *image = [[UIImage alloc] initWithData: data];
        
        // Is it PNG or JPG/JPEG?
        // Running the image representation function writes the data from the image to a file
        if([ImageURLString rangeOfString: @".png" options: NSCaseInsensitiveSearch].location != NSNotFound)
        {
            [UIImagePNGRepresentation(image) writeToFile: docFile atomically: YES];
        }
        else if ( [ImageURLString rangeOfString: @".jpg" options: NSCaseInsensitiveSearch].location != NSNotFound ||  [ImageURLString rangeOfString: @".jpeg" options: NSCaseInsensitiveSearch].location != NSNotFound )
        {
            [UIImageJPEGRepresentation(image, 100) writeToFile: docFile atomically: YES];
        }
    }
    return docFile;
}
/*
 
 // Retrieve a cached file:
 
 - (UIImage *) getCachedImage: (NSString *) ImageURLString
 {
 NSString *filename = [[something unique, perhaps the image name]];
 NSString *uniquePath = [TMP stringByAppendingPathComponent: filename];
 
 UIImage *image;
 
 // Check for a cached version
 if([[NSFileManager defaultManager] fileExistsAtPath: uniquePath])
 {
 image = [UIImage imageWithContentsOfFile: uniquePath]; // this is the cached image
 }
 else
 {
 // get a new one
 [self cacheImage: ImageURLString];
 image = [UIImage imageWithContentsOfFile: uniquePath];
 }
 
 return image;
 }
 */

#pragma mark Smart Armor mathods
//-(NSString*)getFirstNameFromUserID:(NSString*)userID
//{
//    NSString * firstname = [[NSString alloc] init];
//    NSString * queryStr = [NSString stringWithFormat:@"select * from UserDetailTable Where user_id = '%@'",userID];
//    
//      return firstname;
//}

-(void)saveDeviceLogInLocalDB:(NSDictionary*)logDict
{
    NSString * currentDateTime = [self getCurrentTimeAndDate];
    NSString * currentDateOnly = [self getCurrentDateOnly];
    
    NSString *queryStr = [NSString stringWithFormat:@"INSERT INTO ActivityLogTable (device_id,log_message,log_type,user_id,activity_time,date,latitude,longitude) values ('%@','%@','%@','%@','%@','%@','%@','%@')",[logDict valueForKey:@"device_id"],[logDict valueForKey:@"log_message"],[logDict valueForKey:@"log_type"],CURRENT_USER_ID,currentDateTime,currentDateOnly,appLatitude,appLongitude];
    
    NSLog(@"queryStr--%@",queryStr);
    [[DataBaseManager dataBaseManager] execute:queryStr];
}

-(NSString*)getMainImageUrlByDeviceID:(NSString*)deviceID
{
    NSMutableArray * arrDevice = [[NSMutableArray alloc] init];
    NSString * queryStr = [NSString stringWithFormat:@"Select * from Server_Devices_Table where device_id = '%@'",deviceID];
    [self execute:queryStr resultsArray:arrDevice];
    
    NSString * strImageUrl = @"";
    if ([arrDevice count]>0)
    {
        strImageUrl = [[arrDevice objectAtIndex:0] valueForKey:@"main_image"];
    }
    return strImageUrl;
}

-(NSString*)getCurrentTimeAndDate
{
    NSDate* date = [NSDate date];
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * currentdate = [df stringFromDate:date];
    return currentdate;
}

-(NSString*)getCurrentDateOnly
{
    NSDate* date = [NSDate date];
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString * currentdate = [df stringFromDate:date];
    return currentdate;
}

@end
