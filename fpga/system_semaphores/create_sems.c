#include <errno.h>
#include <fcntl.h>           /* For O_* constants */
#include <getopt.h>
#include <semaphore.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>          /* For EXIT_SUCCESS/FAILURE */
#include <sys/stat.h>        /* For mode constants */

/*
Author      : Rick Wertenbroek
Date (YMD)  : 2019 07 08

Description : This program will create or delete named semaphores.
              They are meant to be tested with the use_sems program.

Compile with : gcc -o create_sems create_sems.c -std=gnu99 -pthread

Link with -pthread.

Named semaphores :
    A named semaphore is identified by a name of the form /somename; that is, a
    null-terminated string of up to NAME_MAX-4 (i.e., 251) characters consisting
    of an initial slash, followed by one or more characters, none of which are
    slashes. Two processes can operate on the same named semaphore by passing
    the same name to sem_open(3). 
    
    The sem_open(3) function creates a new named semaphore or opens an existing
    named semaphore. After the semaphore has been opened, it can be operated on
    using sem_post(3) and sem_wait(3). When a process has finished using the
    semaphore, it can use sem_close(3) to close the semaphore. When all
    processes have finished using the semaphore, it can be removed from the
    system using sem_unlink(3). 

Persistence :
   POSIX named semaphores have kernel persistence: if not removed by sem_unlink(3),
   a semaphore will exist until the system is shut down.
*/

#include "common_sems.h"

int main(int argc, char **argv) {
    int rc = 0;
    int opt = 0;
    int delete = 0;
    
    sem_t * semaphores[NUMBER_OF_SEMAPHORES];

    while ((opt = getopt(argc, argv, "d")) != -1) {
        switch (opt) {
        case 'd':
            delete = 1;
            break;
        default: /* '?' */
            fprintf(stderr, "Usage: %s [-d]\n-d : Deletes the named semaphores", argv[0]);
            exit(EXIT_FAILURE);
        }
    }

    if (delete) {
        printf("Deleting...\n");
        
        for (int i = 0; i < NUMBER_OF_SEMAPHORES; i++) {
            printf("Deleting semaphore %s\n", SEMAPHORE_NAMES[i]);

            rc = sem_unlink(SEMAPHORE_NAMES[i]);
            if (rc < 0) {
                printf("Failed to delete semaphore %s with error :\n%s\n", SEMAPHORE_NAMES[i], strerror(errno));
            } else {
                printf("OK\n");
            }
        }
        
    } else {
        printf("This program will create the following named semaphores :\n");
        for (int i = 0; i < NUMBER_OF_SEMAPHORES; i++) {
            printf("%s\n", SEMAPHORE_NAMES[i]);

            semaphores[i] = sem_open(
                /* const char *name */ SEMAPHORE_NAMES[i],
                /* int oflag */ O_CREAT | O_EXCL,
                /* mode_t mode */ S_IRWXU | S_IRWXG,
                /* unsigned int value */ 1);
        
            if (semaphores[i] == SEM_FAILED) {
                printf("Failed to create semaphore %s with error :\n%s\n", SEMAPHORE_NAMES[i], strerror(errno));
            } else {
                printf("OK\n");
            }
        }

    }
    
    return EXIT_SUCCESS;
}
