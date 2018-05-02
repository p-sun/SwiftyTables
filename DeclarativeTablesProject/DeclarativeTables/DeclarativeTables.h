//
//  DeclarativeTables.h
//  DeclarativeTables
//
//  Created by TSD064 on 2018-05-01.
//  Copyright © 2018 Paige Sun. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for DeclarativeTables.
FOUNDATION_EXPORT double DeclarativeTablesVersionNumber;

//! Project version string for DeclarativeTables.
FOUNDATION_EXPORT const unsigned char DeclarativeTablesVersionString[];


// In this header, you should import all the public headers of your framework using statements like #import <FunctionalTableData/PublicHeader.h>
NS_ASSUME_NONNULL_BEGIN

__attribute__((visibility("hidden")))
static inline void catchAndRethrowException(__attribute__((noescape)) void (^ __nonnull inBlock)(void), __attribute__((noescape)) void (^ __nonnull rethrow)(NSException *)) {
    @try {
        inBlock();
    } @catch (NSException *exception) {
        rethrow(exception);
        @throw;
    }
}

NS_ASSUME_NONNULL_END
