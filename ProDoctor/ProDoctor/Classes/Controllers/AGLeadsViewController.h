//  AGViewController.h
//
//  Generated by the the JBoss AeroGear Xcode Project Template on 6/17/13.
//  See Project's web site for more details http://www.aerogear.org
//

#import <UIKit/UIKit.h>
#import "AGLeadViewController.h"

@interface AGLeadsViewController : UITableViewController <AGLeadActionDelegate>
@property(nonatomic, strong) NSMutableArray *leads;
- (void) displayLeads;
- (void) displayLeadsWithPush:(NSString *)pushedId;
@end
