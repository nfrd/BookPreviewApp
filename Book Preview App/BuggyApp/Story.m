

#import "Story.h"

@implementation Story

- (instancetype)initWithTitle:(NSString *)title
                       author:(NSString *)author
                        cover:(NSString *)cover {
    self = [super init];
    if (self) {
        _title = title;
        _author = author;
        _cover = cover;
    }
    return self;
}

@end
