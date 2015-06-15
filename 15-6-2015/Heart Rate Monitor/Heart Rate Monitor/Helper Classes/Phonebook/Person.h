//
//  Person.h
//  VOIPDemo
//
//  Created by Oneclick IT Solution on 5/31/14.
//
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>

typedef  void (^MRPerson)(NSMutableArray *persons, NSError *error);

@interface Person : NSObject
{
    ABAddressBookRef addressBook;
    NSMutableArray *Contacts;
}
- (BOOL)getAccessPermission;
- (void)getPersonOutOfAddressBook:(MRPerson)callBack;

@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, strong) NSString *homeEmail;
@property (nonatomic, strong) NSString *workEmail;
@property (nonatomic, strong) NSString *workPhoneNumber;
@property (nonatomic, strong) NSString *homePhoneNumber;
@property (nonatomic, strong) UIImage  *thumbPhoto;
@property (nonatomic, assign) NSInteger recordId;
@end
