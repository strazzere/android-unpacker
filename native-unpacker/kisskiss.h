/*
 * kisskiss.h
 *
 * Tim "diff" Strazzere <strazz@gmail.com>
 */

#include <stdlib.h>
#include <stdio.h>
#include <sys/ptrace.h>
#include <dirent.h>
#include <fcntl.h> // open / O_RDONLY
#include <unistd.h> // close
#include <errno.h> // perror
#include <string.h> // strlen

static const char* odex_magic = "dey\n036";
static const char* static_safe_location = "/data/local/tmp/";
static const char* suffix = ".dumped_odex";

typedef struct {
  uint64_t start;
  uint64_t end;
} memory_region;

uint32_t get_clone_pid(uint32_t service_pid);
uint32_t get_process_pid(const char* target_package_name);
char *determine_filter(uint32_t clone_pid, int memory_fd);
int find_magic_memory(uint32_t clone_pid, int memory_fd, memory_region *memory, char* extra_filter);
int peek_memory(int memory_file, uint64_t address);
int dump_memory(int memory_fd, memory_region *memory, const char* file_name);
int attach_get_memory(uint32_t pid);
