#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>

@interface LSApplicationProxy : NSObject
+(instancetype)applicationProxyForIdentifier:(NSString *)identifier;
@property (getter=isDeletable,nonatomic,readonly) BOOL deletable;
-(NSString *)applicationIdentifier;
-(NSString *)localizedNameForContext:(id)arg1;
@end

@interface LSApplicationWorkspace : NSObject
+(instancetype)defaultWorkspace;
-(BOOL)uninstallApplication:(id)arg1 withOptions:(id)arg2 ;
-(NSArray *)allInstalledApplications;
@end