//
//  Person.m
//  VOIPDemo
//
//  Created by Oneclick IT Solution on 5/31/14.
//
//

#import "Person.h"

@implementation Person
- (BOOL)getAccessPermission
{
    if(!Contacts)Contacts = [[NSMutableArray alloc] init];
    
    __block BOOL accessGranted = NO;
    if (!addressBook) {
        CFErrorRef error = NULL;
        addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    }
    if (ABAddressBookRequestAccessWithCompletion != NULL) { // we're on iOS 6
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            accessGranted = granted;
            dispatch_semaphore_signal(sema);
        });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        dispatch_release(sema);
    }
    else
    { // we're on iOS 5 or older
        accessGranted = YES;
    }
    return accessGranted;
}
void (^personCallBack)(NSMutableArray *persons, NSError *error);

- (void)getPersonOutOfAddressBook:(MRPerson)callBack
{
    if (callBack) {
        personCallBack = callBack;
    }
    if ([self getAccessPermission]) {
        //1
//        CFErrorRef error = NULL;
//        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
        
        if (addressBook != nil) {
            NSLog(@"Succesful.");
            
            //2
            NSArray *allContacts = ( NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);
            
            //3
            NSUInteger i = 0; for (i = 0; i < [allContacts count]; i++)
            {
                ABRecordRef contactPerson = (__bridge ABRecordRef)allContacts[i];

                //4
                NSString *firstName = ( NSString *)ABRecordCopyValue(contactPerson,
                                                                     kABPersonFirstNameProperty);
                NSString *lastName = ( NSString *)ABRecordCopyValue(contactPerson, kABPersonLastNameProperty);
                
                
                ABMutableMultiValueRef multi;
                int multiCount = 0;
                multi = ABRecordCopyValue(contactPerson, kABPersonPhoneProperty);
                multiCount = ABMultiValueGetCount(multi);
                NSString *phone;
                for (int i = 0; i < multiCount; i++) {
                    //NSLog(@"phone %@",(NSString * ) ABMultiValueCopyValueAtIndex(multi, i));
                    //NSLog(@"----->%@<----- %d",[self fullName:firstName lastName:lastName],i);
                    
                    phone = (NSString * ) ABMultiValueCopyValueAtIndex(multi, i);
                    
                    Person *person = [[Person alloc] init];
                    person.recordId = ABRecordGetRecordID(contactPerson);

                    if (phone != nil) {
                        person.workPhoneNumber = phone;
                        
                        person.fullName = [self fullName:firstName lastName:lastName];
                        
                        UIImage *userImg = [self thumbnailImage:contactPerson];
                        if (userImg) {
                            person.thumbPhoto = userImg;
                        }
                        
                        //email
                        //5
                        ABMultiValueRef emails = ABRecordCopyValue(contactPerson, kABPersonEmailProperty);
                        
                        //6
                        NSUInteger j = 0;
                        for (j = 0; j < ABMultiValueGetCount(emails); j++) {
                            NSString *email = ( NSString *)ABMultiValueCopyValueAtIndex(emails, j);
                            if (j == 0) {
                                person.homeEmail = email;
                            }
                            else if (j==1) person.workEmail = email;
                        }
                        [Contacts addObject:person];
                    }
                }
            }
            
            callBack(Contacts,nil);
            
            //[Contacts release];
            //8
            CFRelease(addressBook);
        } else { 
            //9
            NSLog(@"Error reading Address Book");
            NSError *error = [NSError errorWithDomain:@"Error reading Address Book" code:nil userInfo:nil];
            callBack(nil,error);
        }
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Permission Denied !" message:@"Access denied for retrive contacts from phone book." delegate:nil cancelButtonTitle:@"Got It" otherButtonTitles:nil, nil];
//        [alert show];
//        [alert release];
    }
}

- (UIImage*)imageForContact: (ABRecordRef)contactRef  fromAddressBook:(ABAddressBookRef)addressBookRef{
    UIImage *img = nil;
    
    if (contactRef && addressBookRef) {
        // can't get image from a ABRecordRef copy
        ABRecordID contactID = ABRecordGetRecordID(contactRef);
        
        ABRecordRef origContactRef = ABAddressBookGetPersonWithRecordID(addressBookRef, contactID);
        
        if (ABPersonHasImageData(origContactRef)) {
            NSData *imgData = (NSData*)ABPersonCopyImageDataWithFormat(origContactRef, kABPersonImageFormatOriginalSize);
            img = [UIImage imageWithData: imgData];
            
            [imgData release];
        }
        
        CFRelease(addressBookRef);
        
        return img;
    }else{
        return nil;
    }
}
-(UIImage*)thumbnailImage:(ABRecordRef)contactRef {
    NSData *contactImageData = (__bridge NSData *)(ABPersonCopyImageDataWithFormat(contactRef, kABPersonImageFormatThumbnail));
    
    return [[UIImage alloc] initWithData:contactImageData];
}

- (NSString *)fullName:(NSString*)first lastName:(NSString*)last{
    if(first != nil && last != nil) {
        return [NSString stringWithFormat:@"%@ %@", first, last];
    } else if (first != nil) {
        return first;
    } else if (last != nil) {
        return last;
    } else {
        return @"";
    }
}

@end
