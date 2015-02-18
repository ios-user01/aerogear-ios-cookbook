/*
 * JBoss, Home of Professional Open Source.
 * Copyright Red Hat, Inc., and individual contributors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import <UIKit/UIKit.h>
#import "AGLead.h"
#import "AGLeadViewController.h"

@class AGLeadViewController;

@protocol AGLeadActionDelegate <NSObject>
- (void)didAccept:(AGLeadViewController *)controller lead:(AGLead *)lead;
- (void)didDismiss:(AGLeadViewController *)controller lead:(AGLead *)lead;
@end

@interface AGLeadViewController : UIViewController <UITextFieldDelegate>
@property(strong, nonatomic) AGLead *lead;
@property (weak, nonatomic) id <AGLeadActionDelegate> delegate;
@end

