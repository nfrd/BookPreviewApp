
#import <Foundation/Foundation.h>

@interface Story : NSObject

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *author;
@property (nonatomic, copy, readonly) NSString *cover;

- (instancetype)initWithTitle:(NSString *)title
                       author:(NSString *)author
                        cover:(NSString *)cover;

@end
