// pthreads.pml:
// Task: modify lock, unlock, wait and signal to do the correct thing.

mtype = { unlocked, locked } ;

typedef mutexData {
    mtype mstate;       // Mutex state
    byte mid;           // Mutex Process ID
}

typedef condvarData {
    bool signalled;     // Bool that tells if condition was signalled
}

mutexData mtx;
condvarData cvars[2];

#define PRODCONDVAR 0
#define CONSCONDVAR 1

inline initsync() {
    mtx.mstate = unlocked;          // Set mutex state to unlocked
    mtx.mid = 255;                  // Set mutex process ID to 255 (not used by our processes)
    cvars[0].signalled = false;     // Set cond 0 signalled as false
    cvars[1].signalled = false;     // Set cond 1 signalled as false
}

// pthread_mutex_lock(&m);
inline lock(m) {
    printf("@@@ %d LOCKING : state is %e\n",_pid,m.mstate);
    // Try to lock mutex, atomic block to ensure only one process gets it
    atomic {
        if
        :: (m.mstate == unlocked && m.mid == 255) ->
            m.mstate = locked;
            m.mid = _pid;
        fi;
    }
    // Try to lock mutex while it is locked
    do
        :: (m.mstate == unlocked && m.mid == 255) -> 
            atomic {
                m.mstate = locked;      // Lock mutex
                m.mid = _pid;           // Set Mutex ID to process ID
            }
            break;
        :: else ->
            if
            :: (m.mid == _pid) ->
                break;
            :: else ->
                skip;
            fi;
    od;
    printf("@@@ %d LOCKED : state is %e\n",_pid,m.mstate);
}

// pthread_mutex_unlock(&m);
inline unlock(m) {
    printf("@@@ %d UNLOCKING : state is %e\n",_pid,m.mstate);
    // Unlocks mutex if owned by process
    atomic {
        if
            :: (m.mstate == locked && m.mid == _pid) ->
                m.mstate = unlocked;
                m.mid = 255;
        fi;
    }
    printf("@@@ %d UNLOCKED : state is %e\n",_pid,m.mstate);
}

// pthread_cond_wait(&c,&m);
inline wait(c,m) {
    printf("@@@ %d WAIT for cond[%d]=%d with mutex=%e\n",_pid, c,cvars[c].signalled,m.mstate);
    // Unlock mutex
    unlock(m);
    // When condition is signalled, lock mutex again
    do
        :: (cvars[c].signalled) ->
            atomic {
                cvars[c].signalled = false;
                lock(m);
            }
            break;
        :: else ->
            skip;
    od;
    printf("@@@ %d DONE with cond[%d]=%d with mutex=%e\n",_pid, c,cvars[c].signalled,m.mstate);
}

// pthread_cond_signal(&c);
inline signal(c) {
    printf("@@@ %d SIGNAL cond[%d]=%d\n",_pid,c,cvars[c].signalled);
    // Set condition signalled to true
    atomic {
        cvars[c].signalled = true;
    }
    printf("@@@ %d SIGNALLED cond[%d]=%d\n",_pid,c,cvars[c].signalled);
}