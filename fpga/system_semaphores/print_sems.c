#include <errno.h>
#include <fcntl.h>           /* For O_* constants */
#include <semaphore.h>
#include <stdio.h>
#include <stdlib.h>          /* For EXIT_SUCCESS/FAILURE */
#include <string.h>
#include <unistd.h>
#include <sys/types.h>

/*
Author      : Rick Wertenbroek
Date (YMD)  : 2019 07 08

Description : This programm will show the values of the semaphores

Compile with : gcc -o print_sems print_sems.c -pthread

*/

#include "common_sems.h"

int main(int argc, char **argv) {
    int rc = 0;
    pid_t my_pid = getpid();

    sem_t * semaphores[NUMBER_OF_SEMAPHORES];
    int sem_values[NUMBER_OF_SEMAPHORES] = {0};

    srand(my_pid);
    
    printf("Opening semaphores : \n");
    for (int i = 0; i < NUMBER_OF_SEMAPHORES; i++) {
        printf("%s\n", SEMAPHORE_NAMES[i]);

        semaphores[i] = sem_open(
            /* const char *name */ SEMAPHORE_NAMES[i],
            /* int oflag */ O_RDWR);
        
        if (semaphores[i] == SEM_FAILED) {
            printf("Failed to open semaphore %s with error :\n%s\n", SEMAPHORE_NAMES[i], strerror(errno));
        } else {
            printf("OK\n");
        }
    }

    for(;;) {
        printf("\rSemaphore status : ");
        for (int i = 0; i < NUMBER_OF_SEMAPHORES; i++) {
            if (semaphores[i]) {
                rc = sem_getvalue(/* sem_t *sem */ semaphores[i], /* int *sval */ &(sem_values[i]));
            }
            printf("%d", sem_values[i]);
        }
        printf(" (100Hz refresh rate)");
        fflush(stdout);
        usleep(10000);
    }
}
