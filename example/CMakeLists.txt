

add_executable(mtask-example src/example.cpp)
target_link_libraries(mtask-example
	PRIVATE
		mtask::mtask
)