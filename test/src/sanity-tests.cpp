#include <gtest/gtest.h>
#include <mtask/mtask.hpp>

TEST( sanity_tests, sanity_test ) { EXPECT_EQ( 1, 1 ); }

TEST( sanity_tests, link_test ) { EXPECT_EQ( 42, mtask::test() ); }