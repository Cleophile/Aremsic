//
//  ActionViewController.m
//  MainAction
//
//  Created by 王天民 on 2017/11/5.
//  Copyright © 2017年 AokiW. All rights reserved.
//

#import "ActionViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface ActionViewController ()

@property(strong,nonatomic) IBOutlet UIImageView *imageView;

@property (strong,nonatomic) NSMutableString *stringToBeHandled;
@property (strong,nonatomic) NSString *urlText;
@property (strong,nonatomic) NSString *urlString;

@end

@implementation ActionViewController

-(void)loadView
{
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Get the item[s] we're handling from the extension context.
    
    // For example, look for an image and place it into an image view.
    // Replace this with something appropriate for the type[s] your extension supports.
    BOOL imageFound = NO;
    for (NSExtensionItem *item in self.extensionContext.inputItems) {
        for (NSItemProvider *itemProvider in item.attachments) {
            if ([itemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypeImage]) {
                // This is an image. We'll load it, then place it in our image view.
                __weak UIImageView *imageView = self.imageView;
                [itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeImage options:nil completionHandler:^(UIImage *image, NSError *error) {
                    if(image) {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            [imageView setImage:image];
                        }];
                    }
                }];
                
                imageFound = YES;
                break;
            }
        }
        
        
        
        if (imageFound) {
            // We only handle one image, so stop looking for more.
            break;
        }
    }
    
    _stringToBeHandled=[[NSMutableString alloc] init];
    
    NSLog(@"Doing text grabbing.");
    BOOL textFound=NO;
    for (NSExtensionItem *item in self.extensionContext.inputItems)
    {
        for (NSItemProvider *itemProvider in item.attachments) {
            if ([itemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypeText]) {
                [itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeText options:nil completionHandler:^(NSMutableString *string, NSError *error)
                 {
                     if(string)
                     {
                         [[NSOperationQueue mainQueue]
                          addOperationWithBlock:^{
                              [_stringToBeHandled appendString:string];
                          }];
                         [_stringToBeHandled appendString:string];
                         NSLog(@"Inside String:%@",_stringToBeHandled);
                         
                         //正在把文件写入json
                         NSString *homePath=[NSString stringWithFormat:@"%@",NSHomeDirectory()];
                         NSString *stringPath=[homePath stringByAppendingString:@"/String.txt"];
                         NSString *jsonPath=[homePath stringByAppendingString:@"/text.json"];
                         NSString *cleanedString=[_stringToBeHandled stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                         NSString *jsonString=[[NSString alloc] initWithFormat:@"{\n\"Text\": \"%@\"\n}",cleanedString];
                         [jsonString writeToFile:jsonPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
                         [cleanedString writeToFile:stringPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
                         NSLog(@"HomePath:%@",homePath);
                     }
                 }];
                textFound=YES;
                break;
            }
        }
        
        if(textFound)
        {
            //Only one text.
            break;
        }
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(id) jsonToNSDictionary:(NSString *)jsonPath
{
    NSError *error=nil;
    NSData *jsonData=[NSData dataWithContentsOfFile:jsonPath];
    id jsonObject=[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    if(jsonObject!=nil && error==nil)
    {
        return jsonObject;
    }
    else
    {
        return nil;
    }
}

- (IBAction)done {
    // Return any edited content to the host app.
    // This template doesn't do anything, so we just echo the passed in items.
    [self.extensionContext completeRequestReturningItems:self.extensionContext.inputItems completionHandler:nil];
}

@end
