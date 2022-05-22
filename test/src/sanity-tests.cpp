#include <gtest/gtest.h>
#include <mtask/mtask.hpp>

TEST( SanityTests, SanityTest ) { EXPECT_EQ( 1, 1 ); }

TEST( SanityTests, LinkTest ) { EXPECT_EQ( 42, mtask::test() ); }