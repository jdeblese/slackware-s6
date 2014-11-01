/* ISC license. */

#include "fmtscan.h"
#include "strerr2.h"
#include "djbunix.h"

#define USAGE "cgmove cgroup prog..."
#define PREFIX "/sys/fs/cgroup/"
#define PREFIXLEN 15
#define SUFFIX "/tasks"
#define SUFFIXLEN 6

int main (int argc, char const *const *argv, char const *const *envp)
{
  unsigned int len ;
  int fd;
  PROG = "cgmove" ;
  if (argc < 4) strerr_dieusage(100, USAGE) ;
  len = str_len(argv[1]) ;
  {
    char path[len + PREFIXLEN + SUFFIXLEN + 1] ;
    char pid[UINT_FMT + 1] ;
    unsigned int k ;
    // format this program's PID as a string
    k = uint_fmt(pid, getpid()) ;
    pid[k++] = 0 ;
    // Build up the path to the cgrup filesystem
    byte_copy(path, PREFIXLEN, PREFIX) ;
    byte_copy(path + PREFIXLEN, len, argv[1]) ;
    byte_copy(path + PREFIXLEN + len, SUFFIXLEN, SUFFIX) ;
    path[PREFIXLEN + len + SUFFIXLEN] = 0 ;
    // Write the pid to the cgroup's tasks file
    if ((fd = open_write(path)) < 0) strerr_dief2x(100, "cannot open cgroup tasks file: ", path) ;
    fd_write(fd, pid, k) ;
    close(fd) ;
  }
  pathexec_run(argv[2], argv+2, envp) ;
  strerr_dieexec(111, argv[2]) ;
}
