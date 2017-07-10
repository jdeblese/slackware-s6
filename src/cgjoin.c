/* ISC license. */

#include <string.h>
#include <unistd.h>
#include <skalibs/types.h>
#include <skalibs/strerr2.h>
#include <skalibs/env.h>
#include <skalibs/allreadwrite.h>
#include <skalibs/djbunix.h>

#define USAGE "cgjoin cgroup prog..."
#define PREFIX "/sys/fs/cgroup/"
#define PREFIXLEN 15
#define SUFFIX "/tasks"
#define SUFFIXLEN 6

int main (int argc, char const *const *argv, char const *const *envp)
{
  unsigned int len ;
  int fd;
  PROG = "cgjoin" ;
  if (argc < 3) strerr_dieusage(100, USAGE) ;
  len = strlen(argv[1]) ;
  {
    char path[len + PREFIXLEN + SUFFIXLEN + 1] ;
    char pid[UINT_FMT + 1] ;
    unsigned int k ;
    // format this program's PID as a string
    k = uint_fmt(pid, getpid()) ;
    pid[k++] = 0 ;
    // Build up the path to the cgrup filesystem
    memcpy(path, PREFIX, PREFIXLEN);
    memcpy(path + PREFIXLEN, argv[1], len);
    memcpy(path + PREFIXLEN + len, SUFFIX, SUFFIXLEN);
    path[PREFIXLEN + len + SUFFIXLEN] = 0 ;
    // Write the pid to the cgroup's tasks file
    if ((fd = open_write(path)) < 0) strerr_dief2x(100, "cannot open cgroup tasks file: ", path) ;
    fd_write(fd, pid, k) ;
    close(fd) ;
  }
  pathexec_run(argv[2], argv+2, envp) ;
  strerr_dieexec(111, argv[2]) ;
}
