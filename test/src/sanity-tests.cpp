#include <mtask/mtask.hpp>
#include <gtest/gtest.h>

TEST(sanity_test, sanity_tests){
    EXPECT_EQ(1, 1);
}

TEST(link_test, sanity_tests){
    EXPECT_EQ(42, mtask::test());
}