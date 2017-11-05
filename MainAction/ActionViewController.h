//
//  ActionViewController.h
//  MainAction
//
//  Created by 王天民 on 2017/11/5.
//  Copyright © 2017年 AokiW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActionViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *upperText;

-(id)jsonToNSDictionary:(NSString *)jsonPath;

@end
