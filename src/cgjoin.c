/* ISC license. */

#include <string.h>
#include <unistd.h>
#include <sys/stat.h>
#include <errno.h>
#include <skalibs/types.h>
#include <skalibs/strerr2.h>
#include <skalibs/env.h>
#include <skalibs/allreadwrite.h>
#include <skalibs/djbunix.h>

#define USAGE "cgjoin cgroup prog..."
#define PREFIX "/sys/fs/cgroup/"
#define PREFIXLEN 15
#define SUFFIX "/cgroup.procs"
#define SUFFIXLEN 13

static int doit (char const *s)
{
  if (mkdir(s, 0755) == -1)
  {
    if (errno != EEXIST)
    {
      strerr_warnwu2sys("mkdir ", s) ;
      return 111 ;
    }
  }
  return 0 ;
}

static int doparents (char const *s)
{
  size_t n = strlen(s), i = 0 ;
  char tmp[n+1] ;
  for (; i < n ; i++)
  {
    if ((s[i] == '/') && i)
    {
      int e ;
      tmp[i] = 0 ;
      e = doit(tmp);
      if (e) return e ;
    }
    tmp[i] = s[i] ;
  }
  return doit(s);
}

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
    doparents(path);
    // Write the pid to the cgroup's tasks file
    if ((fd = open_write(path)) < 0) strerr_dief2x(100, "cannot open cgroup tasks file: ", path) ;
    fd_write(fd, pid, k) ;
    close(fd) ;
  }
  pathexec_run(argv[2], argv+2, envp) ;
  strerr_dieexec(111, argv[2]) ;
}
