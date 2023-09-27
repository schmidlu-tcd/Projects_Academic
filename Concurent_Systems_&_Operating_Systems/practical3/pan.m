#define rand	pan_rand
#define pthread_equal(a,b)	((a)==(b))
#if defined(HAS_CODE) && defined(VERBOSE)
	#ifdef BFS_PAR
		bfs_printf("Pr: %d Tr: %d\n", II, t->forw);
	#else
		cpu_printf("Pr: %d Tr: %d\n", II, t->forw);
	#endif
#endif
	switch (t->forw) {
	default: Uerror("bad forward move");
	case 0:	/* if without executable clauses */
		continue;
	case 1: /* generic 'goto' or 'skip' */
		IfNotBlocked
		_m = 3; goto P999;
	case 2: /* generic 'else' */
		IfNotBlocked
		if (trpt->o_pm&1) continue;
		_m = 3; goto P999;

		 /* PROC :init: */
	case 3: // STATE 1 - writers-and-reader.pml:120 - [printf('A Model of pthreads\\n')] (0:17:0 - 1)
		IfNotBlocked
		reached[2][1] = 1;
		Printf("A Model of pthreads\n");
		/* merge: printf('\\n Producer-Consumer example\\n')(17, 2, 17) */
		reached[2][2] = 1;
		Printf("\n Producer-Consumer example\n");
		_m = 3; goto P999; /* 1 */
	case 4: // STATE 3 - writers-and-reader.pml:16 - [in = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[2][3] = 1;
		(trpt+1)->bup.oval = ((int)now.in);
		now.in = 0;
#ifdef VAR_RANGES
		logval("in", ((int)now.in));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 5: // STATE 4 - writers-and-reader.pml:18 - [((in<4))] (0:0:0 - 1)
		IfNotBlocked
		reached[2][4] = 1;
		if (!((((int)now.in)<4)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 6: // STATE 5 - writers-and-reader.pml:18 - [buffer[in] = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[2][5] = 1;
		(trpt+1)->bup.oval = ((int)now.buffer[ Index(((int)now.in), 4) ]);
		now.buffer[ Index(now.in, 4) ] = 0;
#ifdef VAR_RANGES
		logval("buffer[in]", ((int)now.buffer[ Index(((int)now.in), 4) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 7: // STATE 6 - writers-and-reader.pml:18 - [in = (in+1)] (0:0:1 - 1)
		IfNotBlocked
		reached[2][6] = 1;
		(trpt+1)->bup.oval = ((int)now.in);
		now.in = (((int)now.in)+1);
#ifdef VAR_RANGES
		logval("in", ((int)now.in));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 8: // STATE 8 - writers-and-reader.pml:19 - [in = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[2][8] = 1;
		(trpt+1)->bup.oval = ((int)now.in);
		now.in = 0;
#ifdef VAR_RANGES
		logval("in", ((int)now.in));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 9: // STATE 13 - writers-and-reader.pml:21 - [out = (4-1)] (0:0:1 - 3)
		IfNotBlocked
		reached[2][13] = 1;
		(trpt+1)->bup.oval = ((int)now.out);
		now.out = (4-1);
#ifdef VAR_RANGES
		logval("out", ((int)now.out));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 10: // STATE 14 - writers-and-reader.pml:22 - [bfull = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[2][14] = 1;
		(trpt+1)->bup.oval = ((int)now.bfull);
		now.bfull = 0;
#ifdef VAR_RANGES
		logval("bfull", ((int)now.bfull));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 11: // STATE 15 - writers-and-reader.pml:22 - [bempty = 1] (0:0:1 - 1)
		IfNotBlocked
		reached[2][15] = 1;
		(trpt+1)->bup.oval = ((int)now.bempty);
		now.bempty = 1;
#ifdef VAR_RANGES
		logval("bempty", ((int)now.bempty));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 12: // STATE 16 - writers-and-reader.pml:23 - [printf('buffer zeroed\\n')] (0:0:0 - 1)
		IfNotBlocked
		reached[2][16] = 1;
		Printf("buffer zeroed\n");
		_m = 3; goto P999; /* 0 */
	case 13: // STATE 18 - writers-and-reader.pml:30 - [printf('@@@ %d BUFFER in:%d, out:%d, empty:%d, full:%d [|',_pid,in,out,bempty,bfull)] (0:26:1 - 1)
		IfNotBlocked
		reached[2][18] = 1;
		Printf("@@@ %d BUFFER in:%d, out:%d, empty:%d, full:%d [|", ((int)((P2 *)_this)->_pid), ((int)now.in), ((int)now.out), ((int)now.bempty), ((int)now.bfull));
		/* merge: six = 0(26, 19, 26) */
		reached[2][19] = 1;
		(trpt+1)->bup.oval = ((int)now.six);
		now.six = 0;
#ifdef VAR_RANGES
		logval("six", ((int)now.six));
#endif
		;
		/* merge: .(goto)(0, 27, 26) */
		reached[2][27] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 14: // STATE 20 - writers-and-reader.pml:33 - [((six<4))] (26:0:1 - 1)
		IfNotBlocked
		reached[2][20] = 1;
		if (!((((int)now.six)<4)))
			continue;
		/* merge: printf(' %d |',buffer[six])(26, 21, 26) */
		reached[2][21] = 1;
		Printf(" %d |", ((int)now.buffer[ Index(((int)now.six), 4) ]));
		/* merge: six = (six+1)(26, 22, 26) */
		reached[2][22] = 1;
		(trpt+1)->bup.oval = ((int)now.six);
		now.six = (((int)now.six)+1);
#ifdef VAR_RANGES
		logval("six", ((int)now.six));
#endif
		;
		/* merge: .(goto)(0, 27, 26) */
		reached[2][27] = 1;
		;
		_m = 3; goto P999; /* 3 */
	case 15: // STATE 24 - writers-and-reader.pml:34 - [printf(']\\n')] (0:28:0 - 1)
		IfNotBlocked
		reached[2][24] = 1;
		Printf("]\n");
		/* merge: goto :b13(28, 25, 28) */
		reached[2][25] = 1;
		;
		_m = 3; goto P999; /* 1 */
	case 16: // STATE 31 - pthreads.pml:24 - [mtx.mstate = unlocked] (0:0:1 - 1)
		IfNotBlocked
		reached[2][31] = 1;
		(trpt+1)->bup.oval = now.mtx.mstate;
		now.mtx.mstate = 2;
#ifdef VAR_RANGES
		logval("mtx.mstate", now.mtx.mstate);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 17: // STATE 32 - pthreads.pml:25 - [mtx.mid = 255] (0:0:1 - 1)
		IfNotBlocked
		reached[2][32] = 1;
		(trpt+1)->bup.oval = ((int)now.mtx.mid);
		now.mtx.mid = 255;
#ifdef VAR_RANGES
		logval("mtx.mid", ((int)now.mtx.mid));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 18: // STATE 33 - pthreads.pml:26 - [cvars[0].signalled = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[2][33] = 1;
		(trpt+1)->bup.oval = ((int)now.cvars[0].signalled);
		now.cvars[0].signalled = 0;
#ifdef VAR_RANGES
		logval("cvars[0].signalled", ((int)now.cvars[0].signalled));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 19: // STATE 34 - pthreads.pml:27 - [cvars[1].signalled = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[2][34] = 1;
		(trpt+1)->bup.oval = ((int)now.cvars[1].signalled);
		now.cvars[1].signalled = 0;
#ifdef VAR_RANGES
		logval("cvars[1].signalled", ((int)now.cvars[1].signalled));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 20: // STATE 36 - writers-and-reader.pml:125 - [(run producer(1))] (0:0:0 - 1)
		IfNotBlocked
		reached[2][36] = 1;
		if (!(addproc(II, 1, 0, 1)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 21: // STATE 37 - writers-and-reader.pml:126 - [(run producer(2))] (0:0:0 - 1)
		IfNotBlocked
		reached[2][37] = 1;
		if (!(addproc(II, 1, 0, 2)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 22: // STATE 38 - writers-and-reader.pml:127 - [(run consumer())] (0:0:0 - 1)
		IfNotBlocked
		reached[2][38] = 1;
		if (!(addproc(II, 1, 1, 0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 23: // STATE 39 - writers-and-reader.pml:128 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[2][39] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC consumer */
	case 24: // STATE 1 - pthreads.pml:33 - [printf('@@@ %d LOCKING : state is %e\\n',_pid,mtx.mstate)] (0:0:0 - 1)
		IfNotBlocked
		reached[1][1] = 1;
		Printf("@@@ %d LOCKING : state is %e\n", ((int)((P1 *)_this)->_pid), now.mtx.mstate);
		_m = 3; goto P999; /* 0 */
	case 25: // STATE 2 - pthreads.pml:37 - [(((mtx.mstate==unlocked)&&(mtx.mid==255)))] (20:0:2 - 1)
		IfNotBlocked
		reached[1][2] = 1;
		if (!(((now.mtx.mstate==2)&&(((int)now.mtx.mid)==255))))
			continue;
		/* merge: mtx.mstate = locked(20, 3, 20) */
		reached[1][3] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = now.mtx.mstate;
		now.mtx.mstate = 1;
#ifdef VAR_RANGES
		logval("mtx.mstate", now.mtx.mstate);
#endif
		;
		/* merge: mtx.mid = _pid(20, 4, 20) */
		reached[1][4] = 1;
		(trpt+1)->bup.ovals[1] = ((int)now.mtx.mid);
		now.mtx.mid = ((int)((P1 *)_this)->_pid);
#ifdef VAR_RANGES
		logval("mtx.mid", ((int)now.mtx.mid));
#endif
		;
		/* merge: .(goto)(20, 6, 20) */
		reached[1][6] = 1;
		;
		/* merge: .(goto)(0, 21, 20) */
		reached[1][21] = 1;
		;
		_m = 3; goto P999; /* 4 */
	case 26: // STATE 8 - pthreads.pml:43 - [(((mtx.mstate==unlocked)&&(mtx.mid==255)))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][8] = 1;
		if (!(((now.mtx.mstate==2)&&(((int)now.mtx.mid)==255))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 27: // STATE 9 - pthreads.pml:45 - [mtx.mstate = locked] (0:23:2 - 1)
		IfNotBlocked
		reached[1][9] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = now.mtx.mstate;
		now.mtx.mstate = 1;
#ifdef VAR_RANGES
		logval("mtx.mstate", now.mtx.mstate);
#endif
		;
		/* merge: mtx.mid = _pid(23, 10, 23) */
		reached[1][10] = 1;
		(trpt+1)->bup.ovals[1] = ((int)now.mtx.mid);
		now.mtx.mid = ((int)((P1 *)_this)->_pid);
#ifdef VAR_RANGES
		logval("mtx.mid", ((int)now.mtx.mid));
#endif
		;
		/* merge: goto :b7(0, 12, 23) */
		reached[1][12] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 28: // STATE 14 - pthreads.pml:51 - [((mtx.mid==_pid))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][14] = 1;
		if (!((((int)now.mtx.mid)==((int)((P1 *)_this)->_pid))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 29: // STATE 23 - pthreads.pml:58 - [printf('@@@ %d LOCKED : state is %e\\n',_pid,mtx.mstate)] (0:0:0 - 5)
		IfNotBlocked
		reached[1][23] = 1;
		Printf("@@@ %d LOCKED : state is %e\n", ((int)((P1 *)_this)->_pid), now.mtx.mstate);
		_m = 3; goto P999; /* 0 */
	case 30: // STATE 25 - writers-and-reader.pml:96 - [assert((mtx.mid==_pid))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][25] = 1;
		spin_assert((((int)now.mtx.mid)==((int)((P1 *)_this)->_pid)), "(mtx.mid==_pid)", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 31: // STATE 26 - writers-and-reader.pml:98 - [(!(bempty))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][26] = 1;
		if (!( !(((int)now.bempty))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 32: // STATE 29 - pthreads.pml:78 - [printf('@@@ %d WAIT for cond[%d]=%d with mutex=%e\\n',_pid,1,cvars[1].signalled,mtx.mstate)] (0:0:0 - 1)
		IfNotBlocked
		reached[1][29] = 1;
		Printf("@@@ %d WAIT for cond[%d]=%d with mutex=%e\n", ((int)((P1 *)_this)->_pid), 1, ((int)now.cvars[1].signalled), now.mtx.mstate);
		_m = 3; goto P999; /* 0 */
	case 33: // STATE 30 - pthreads.pml:63 - [printf('@@@ %d UNLOCKING : state is %e\\n',_pid,mtx.mstate)] (0:0:0 - 1)
		IfNotBlocked
		reached[1][30] = 1;
		Printf("@@@ %d UNLOCKING : state is %e\n", ((int)((P1 *)_this)->_pid), now.mtx.mstate);
		_m = 3; goto P999; /* 0 */
	case 34: // STATE 31 - pthreads.pml:67 - [(((mtx.mstate==locked)&&(mtx.mid==_pid)))] (37:0:2 - 1)
		IfNotBlocked
		reached[1][31] = 1;
		if (!(((now.mtx.mstate==1)&&(((int)now.mtx.mid)==((int)((P1 *)_this)->_pid)))))
			continue;
		/* merge: mtx.mstate = unlocked(37, 32, 37) */
		reached[1][32] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = now.mtx.mstate;
		now.mtx.mstate = 2;
#ifdef VAR_RANGES
		logval("mtx.mstate", now.mtx.mstate);
#endif
		;
		/* merge: mtx.mid = 255(37, 33, 37) */
		reached[1][33] = 1;
		(trpt+1)->bup.ovals[1] = ((int)now.mtx.mid);
		now.mtx.mid = 255;
#ifdef VAR_RANGES
		logval("mtx.mid", ((int)now.mtx.mid));
#endif
		;
		/* merge: .(goto)(37, 35, 37) */
		reached[1][35] = 1;
		;
		_m = 3; goto P999; /* 3 */
	case 35: // STATE 37 - pthreads.pml:73 - [printf('@@@ %d UNLOCKED : state is %e\\n',_pid,mtx.mstate)] (0:0:0 - 1)
		IfNotBlocked
		reached[1][37] = 1;
		Printf("@@@ %d UNLOCKED : state is %e\n", ((int)((P1 *)_this)->_pid), now.mtx.mstate);
		_m = 3; goto P999; /* 0 */
	case 36: // STATE 39 - pthreads.pml:83 - [(cvars[1].signalled)] (0:0:0 - 1)
		IfNotBlocked
		reached[1][39] = 1;
		if (!(((int)now.cvars[1].signalled)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 37: // STATE 40 - pthreads.pml:85 - [cvars[1].signalled = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[1][40] = 1;
		(trpt+1)->bup.oval = ((int)now.cvars[1].signalled);
		now.cvars[1].signalled = 0;
#ifdef VAR_RANGES
		logval("cvars[1].signalled", ((int)now.cvars[1].signalled));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 38: // STATE 41 - pthreads.pml:33 - [printf('@@@ %d LOCKING : state is %e\\n',_pid,mtx.mstate)] (0:0:0 - 1)
		IfNotBlocked
		reached[1][41] = 1;
		Printf("@@@ %d LOCKING : state is %e\n", ((int)((P1 *)_this)->_pid), now.mtx.mstate);
		_m = 3; goto P999; /* 0 */
	case 39: // STATE 42 - pthreads.pml:37 - [(((mtx.mstate==unlocked)&&(mtx.mid==255)))] (60:0:2 - 1)
		IfNotBlocked
		reached[1][42] = 1;
		if (!(((now.mtx.mstate==2)&&(((int)now.mtx.mid)==255))))
			continue;
		/* merge: mtx.mstate = locked(60, 43, 60) */
		reached[1][43] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = now.mtx.mstate;
		now.mtx.mstate = 1;
#ifdef VAR_RANGES
		logval("mtx.mstate", now.mtx.mstate);
#endif
		;
		/* merge: mtx.mid = _pid(60, 44, 60) */
		reached[1][44] = 1;
		(trpt+1)->bup.ovals[1] = ((int)now.mtx.mid);
		now.mtx.mid = ((int)((P1 *)_this)->_pid);
#ifdef VAR_RANGES
		logval("mtx.mid", ((int)now.mtx.mid));
#endif
		;
		/* merge: .(goto)(0, 46, 60) */
		reached[1][46] = 1;
		;
		/* merge: .(goto)(0, 61, 60) */
		reached[1][61] = 1;
		;
		_m = 3; goto P999; /* 4 */
	case 40: // STATE 48 - pthreads.pml:43 - [(((mtx.mstate==unlocked)&&(mtx.mid==255)))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][48] = 1;
		if (!(((now.mtx.mstate==2)&&(((int)now.mtx.mid)==255))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 41: // STATE 49 - pthreads.pml:45 - [mtx.mstate = locked] (0:62:2 - 1)
		IfNotBlocked
		reached[1][49] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = now.mtx.mstate;
		now.mtx.mstate = 1;
#ifdef VAR_RANGES
		logval("mtx.mstate", now.mtx.mstate);
#endif
		;
		/* merge: mtx.mid = _pid(62, 50, 62) */
		reached[1][50] = 1;
		(trpt+1)->bup.ovals[1] = ((int)now.mtx.mid);
		now.mtx.mid = ((int)((P1 *)_this)->_pid);
#ifdef VAR_RANGES
		logval("mtx.mid", ((int)now.mtx.mid));
#endif
		;
		/* merge: goto :b10(0, 52, 62) */
		reached[1][52] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 42: // STATE 54 - pthreads.pml:51 - [((mtx.mid==_pid))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][54] = 1;
		if (!((((int)now.mtx.mid)==((int)((P1 *)_this)->_pid))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 43: // STATE 63 - pthreads.pml:58 - [printf('@@@ %d LOCKED : state is %e\\n',_pid,mtx.mstate)] (0:0:0 - 1)
		IfNotBlocked
		reached[1][63] = 1;
		Printf("@@@ %d LOCKED : state is %e\n", ((int)((P1 *)_this)->_pid), now.mtx.mstate);
		_m = 3; goto P999; /* 0 */
	case 44: // STATE 72 - pthreads.pml:94 - [printf('@@@ %d DONE with cond[%d]=%d with mutex=%e\\n',_pid,1,cvars[1].signalled,mtx.mstate)] (0:0:0 - 3)
		IfNotBlocked
		reached[1][72] = 1;
		Printf("@@@ %d DONE with cond[%d]=%d with mutex=%e\n", ((int)((P1 *)_this)->_pid), 1, ((int)now.cvars[1].signalled), now.mtx.mstate);
		_m = 3; goto P999; /* 0 */
	case 45: // STATE 77 - writers-and-reader.pml:101 - [assert((mtx.mid==_pid))] (0:0:0 - 3)
		IfNotBlocked
		reached[1][77] = 1;
		spin_assert((((int)now.mtx.mid)==((int)((P1 *)_this)->_pid)), "(mtx.mid==_pid)", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 46: // STATE 78 - writers-and-reader.pml:54 - [assert(!(bempty))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][78] = 1;
		spin_assert( !(((int)now.bempty)), " !(bempty)", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 47: // STATE 79 - writers-and-reader.pml:55 - [out = ((out+1)%4)] (0:0:1 - 1)
		IfNotBlocked
		reached[1][79] = 1;
		(trpt+1)->bup.oval = ((int)now.out);
		now.out = ((((int)now.out)+1)%4);
#ifdef VAR_RANGES
		logval("out", ((int)now.out));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 48: // STATE 80 - writers-and-reader.pml:56 - [cout = buffer[out]] (0:0:1 - 1)
		IfNotBlocked
		reached[1][80] = 1;
		(trpt+1)->bup.oval = ((int)cout);
		cout = ((int)now.buffer[ Index(((int)now.out), 4) ]);
#ifdef VAR_RANGES
		logval("cout", ((int)cout));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 49: // STATE 81 - writers-and-reader.pml:56 - [buffer[out] = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[1][81] = 1;
		(trpt+1)->bup.oval = ((int)now.buffer[ Index(((int)now.out), 4) ]);
		now.buffer[ Index(now.out, 4) ] = 0;
#ifdef VAR_RANGES
		logval("buffer[out]", ((int)now.buffer[ Index(((int)now.out), 4) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 50: // STATE 82 - writers-and-reader.pml:57 - [printf('@@@ %d **** EXTRACT cout := buf[%d] is %d\\n',_pid,out,cout)] (0:0:0 - 1)
		IfNotBlocked
		reached[1][82] = 1;
		Printf("@@@ %d **** EXTRACT cout := buf[%d] is %d\n", ((int)((P1 *)_this)->_pid), ((int)now.out), ((int)cout));
		_m = 3; goto P999; /* 0 */
	case 51: // STATE 83 - writers-and-reader.pml:58 - [bfull = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[1][83] = 1;
		(trpt+1)->bup.oval = ((int)now.bfull);
		now.bfull = 0;
#ifdef VAR_RANGES
		logval("bfull", ((int)now.bfull));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 52: // STATE 84 - writers-and-reader.pml:59 - [bempty = (((out+1)%4)==in)] (0:0:1 - 1)
		IfNotBlocked
		reached[1][84] = 1;
		(trpt+1)->bup.oval = ((int)now.bempty);
		now.bempty = (((((int)now.out)+1)%4)==((int)now.in));
#ifdef VAR_RANGES
		logval("bempty", ((int)now.bempty));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 53: // STATE 85 - writers-and-reader.pml:30 - [printf('@@@ %d BUFFER in:%d, out:%d, empty:%d, full:%d [|',_pid,in,out,bempty,bfull)] (0:93:1 - 1)
		IfNotBlocked
		reached[1][85] = 1;
		Printf("@@@ %d BUFFER in:%d, out:%d, empty:%d, full:%d [|", ((int)((P1 *)_this)->_pid), ((int)now.in), ((int)now.out), ((int)now.bempty), ((int)now.bfull));
		/* merge: six = 0(93, 86, 93) */
		reached[1][86] = 1;
		(trpt+1)->bup.oval = ((int)now.six);
		now.six = 0;
#ifdef VAR_RANGES
		logval("six", ((int)now.six));
#endif
		;
		/* merge: .(goto)(0, 94, 93) */
		reached[1][94] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 54: // STATE 87 - writers-and-reader.pml:33 - [((six<4))] (93:0:1 - 1)
		IfNotBlocked
		reached[1][87] = 1;
		if (!((((int)now.six)<4)))
			continue;
		/* merge: printf(' %d |',buffer[six])(93, 88, 93) */
		reached[1][88] = 1;
		Printf(" %d |", ((int)now.buffer[ Index(((int)now.six), 4) ]));
		/* merge: six = (six+1)(93, 89, 93) */
		reached[1][89] = 1;
		(trpt+1)->bup.oval = ((int)now.six);
		now.six = (((int)now.six)+1);
#ifdef VAR_RANGES
		logval("six", ((int)now.six));
#endif
		;
		/* merge: .(goto)(0, 94, 93) */
		reached[1][94] = 1;
		;
		_m = 3; goto P999; /* 3 */
	case 55: // STATE 91 - writers-and-reader.pml:34 - [printf(']\\n')] (0:95:0 - 1)
		IfNotBlocked
		reached[1][91] = 1;
		Printf("]\n");
		/* merge: goto :b11(95, 92, 95) */
		reached[1][92] = 1;
		;
		_m = 3; goto P999; /* 1 */
	case 56: // STATE 99 - pthreads.pml:99 - [printf('@@@ %d SIGNAL cond[%d]=%d\\n',_pid,0,cvars[0].signalled)] (0:0:0 - 1)
		IfNotBlocked
		reached[1][99] = 1;
		Printf("@@@ %d SIGNAL cond[%d]=%d\n", ((int)((P1 *)_this)->_pid), 0, ((int)now.cvars[0].signalled));
		_m = 3; goto P999; /* 0 */
	case 57: // STATE 100 - pthreads.pml:102 - [cvars[0].signalled = 1] (0:0:1 - 1)
		IfNotBlocked
		reached[1][100] = 1;
		(trpt+1)->bup.oval = ((int)now.cvars[0].signalled);
		now.cvars[0].signalled = 1;
#ifdef VAR_RANGES
		logval("cvars[0].signalled", ((int)now.cvars[0].signalled));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 58: // STATE 102 - pthreads.pml:105 - [printf('@@@ %d SIGNALLED cond[%d]=%d\\n',_pid,0,cvars[0].signalled)] (0:0:0 - 1)
		IfNotBlocked
		reached[1][102] = 1;
		Printf("@@@ %d SIGNALLED cond[%d]=%d\n", ((int)((P1 *)_this)->_pid), 0, ((int)now.cvars[0].signalled));
		_m = 3; goto P999; /* 0 */
	case 59: // STATE 104 - writers-and-reader.pml:105 - [assert((mtx.mid==_pid))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][104] = 1;
		spin_assert((((int)now.mtx.mid)==((int)((P1 *)_this)->_pid)), "(mtx.mid==_pid)", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 60: // STATE 105 - pthreads.pml:63 - [printf('@@@ %d UNLOCKING : state is %e\\n',_pid,mtx.mstate)] (0:0:0 - 1)
		IfNotBlocked
		reached[1][105] = 1;
		Printf("@@@ %d UNLOCKING : state is %e\n", ((int)((P1 *)_this)->_pid), now.mtx.mstate);
		_m = 3; goto P999; /* 0 */
	case 61: // STATE 106 - pthreads.pml:67 - [(((mtx.mstate==locked)&&(mtx.mid==_pid)))] (112:0:2 - 1)
		IfNotBlocked
		reached[1][106] = 1;
		if (!(((now.mtx.mstate==1)&&(((int)now.mtx.mid)==((int)((P1 *)_this)->_pid)))))
			continue;
		/* merge: mtx.mstate = unlocked(112, 107, 112) */
		reached[1][107] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = now.mtx.mstate;
		now.mtx.mstate = 2;
#ifdef VAR_RANGES
		logval("mtx.mstate", now.mtx.mstate);
#endif
		;
		/* merge: mtx.mid = 255(112, 108, 112) */
		reached[1][108] = 1;
		(trpt+1)->bup.ovals[1] = ((int)now.mtx.mid);
		now.mtx.mid = 255;
#ifdef VAR_RANGES
		logval("mtx.mid", ((int)now.mtx.mid));
#endif
		;
		/* merge: .(goto)(112, 110, 112) */
		reached[1][110] = 1;
		;
		_m = 3; goto P999; /* 3 */
	case 62: // STATE 112 - pthreads.pml:73 - [printf('@@@ %d UNLOCKED : state is %e\\n',_pid,mtx.mstate)] (0:0:0 - 1)
		IfNotBlocked
		reached[1][112] = 1;
		Printf("@@@ %d UNLOCKED : state is %e\n", ((int)((P1 *)_this)->_pid), now.mtx.mstate);
		_m = 3; goto P999; /* 0 */
	case 63: // STATE 118 - writers-and-reader.pml:113 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[1][118] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC producer */
	case 64: // STATE 1 - pthreads.pml:33 - [printf('@@@ %d LOCKING : state is %e\\n',_pid,mtx.mstate)] (0:0:0 - 1)
		IfNotBlocked
		reached[0][1] = 1;
		Printf("@@@ %d LOCKING : state is %e\n", ((int)((P0 *)_this)->_pid), now.mtx.mstate);
		_m = 3; goto P999; /* 0 */
	case 65: // STATE 2 - pthreads.pml:37 - [(((mtx.mstate==unlocked)&&(mtx.mid==255)))] (20:0:2 - 1)
		IfNotBlocked
		reached[0][2] = 1;
		if (!(((now.mtx.mstate==2)&&(((int)now.mtx.mid)==255))))
			continue;
		/* merge: mtx.mstate = locked(20, 3, 20) */
		reached[0][3] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = now.mtx.mstate;
		now.mtx.mstate = 1;
#ifdef VAR_RANGES
		logval("mtx.mstate", now.mtx.mstate);
#endif
		;
		/* merge: mtx.mid = _pid(20, 4, 20) */
		reached[0][4] = 1;
		(trpt+1)->bup.ovals[1] = ((int)now.mtx.mid);
		now.mtx.mid = ((int)((P0 *)_this)->_pid);
#ifdef VAR_RANGES
		logval("mtx.mid", ((int)now.mtx.mid));
#endif
		;
		/* merge: .(goto)(20, 6, 20) */
		reached[0][6] = 1;
		;
		/* merge: .(goto)(0, 21, 20) */
		reached[0][21] = 1;
		;
		_m = 3; goto P999; /* 4 */
	case 66: // STATE 8 - pthreads.pml:43 - [(((mtx.mstate==unlocked)&&(mtx.mid==255)))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][8] = 1;
		if (!(((now.mtx.mstate==2)&&(((int)now.mtx.mid)==255))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 67: // STATE 9 - pthreads.pml:45 - [mtx.mstate = locked] (0:23:2 - 1)
		IfNotBlocked
		reached[0][9] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = now.mtx.mstate;
		now.mtx.mstate = 1;
#ifdef VAR_RANGES
		logval("mtx.mstate", now.mtx.mstate);
#endif
		;
		/* merge: mtx.mid = _pid(23, 10, 23) */
		reached[0][10] = 1;
		(trpt+1)->bup.ovals[1] = ((int)now.mtx.mid);
		now.mtx.mid = ((int)((P0 *)_this)->_pid);
#ifdef VAR_RANGES
		logval("mtx.mid", ((int)now.mtx.mid));
#endif
		;
		/* merge: goto :b1(0, 12, 23) */
		reached[0][12] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 68: // STATE 14 - pthreads.pml:51 - [((mtx.mid==_pid))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][14] = 1;
		if (!((((int)now.mtx.mid)==((int)((P0 *)_this)->_pid))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 69: // STATE 23 - pthreads.pml:58 - [printf('@@@ %d LOCKED : state is %e\\n',_pid,mtx.mstate)] (0:0:0 - 5)
		IfNotBlocked
		reached[0][23] = 1;
		Printf("@@@ %d LOCKED : state is %e\n", ((int)((P0 *)_this)->_pid), now.mtx.mstate);
		_m = 3; goto P999; /* 0 */
	case 70: // STATE 25 - writers-and-reader.pml:68 - [assert((mtx.mid==_pid))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][25] = 1;
		spin_assert((((int)now.mtx.mid)==((int)((P0 *)_this)->_pid)), "(mtx.mid==_pid)", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 71: // STATE 26 - writers-and-reader.pml:70 - [(!(bfull))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][26] = 1;
		if (!( !(((int)now.bfull))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 72: // STATE 29 - pthreads.pml:78 - [printf('@@@ %d WAIT for cond[%d]=%d with mutex=%e\\n',_pid,0,cvars[0].signalled,mtx.mstate)] (0:0:0 - 1)
		IfNotBlocked
		reached[0][29] = 1;
		Printf("@@@ %d WAIT for cond[%d]=%d with mutex=%e\n", ((int)((P0 *)_this)->_pid), 0, ((int)now.cvars[0].signalled), now.mtx.mstate);
		_m = 3; goto P999; /* 0 */
	case 73: // STATE 30 - pthreads.pml:63 - [printf('@@@ %d UNLOCKING : state is %e\\n',_pid,mtx.mstate)] (0:0:0 - 1)
		IfNotBlocked
		reached[0][30] = 1;
		Printf("@@@ %d UNLOCKING : state is %e\n", ((int)((P0 *)_this)->_pid), now.mtx.mstate);
		_m = 3; goto P999; /* 0 */
	case 74: // STATE 31 - pthreads.pml:67 - [(((mtx.mstate==locked)&&(mtx.mid==_pid)))] (37:0:2 - 1)
		IfNotBlocked
		reached[0][31] = 1;
		if (!(((now.mtx.mstate==1)&&(((int)now.mtx.mid)==((int)((P0 *)_this)->_pid)))))
			continue;
		/* merge: mtx.mstate = unlocked(37, 32, 37) */
		reached[0][32] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = now.mtx.mstate;
		now.mtx.mstate = 2;
#ifdef VAR_RANGES
		logval("mtx.mstate", now.mtx.mstate);
#endif
		;
		/* merge: mtx.mid = 255(37, 33, 37) */
		reached[0][33] = 1;
		(trpt+1)->bup.ovals[1] = ((int)now.mtx.mid);
		now.mtx.mid = 255;
#ifdef VAR_RANGES
		logval("mtx.mid", ((int)now.mtx.mid));
#endif
		;
		/* merge: .(goto)(37, 35, 37) */
		reached[0][35] = 1;
		;
		_m = 3; goto P999; /* 3 */
	case 75: // STATE 37 - pthreads.pml:73 - [printf('@@@ %d UNLOCKED : state is %e\\n',_pid,mtx.mstate)] (0:0:0 - 1)
		IfNotBlocked
		reached[0][37] = 1;
		Printf("@@@ %d UNLOCKED : state is %e\n", ((int)((P0 *)_this)->_pid), now.mtx.mstate);
		_m = 3; goto P999; /* 0 */
	case 76: // STATE 39 - pthreads.pml:83 - [(cvars[0].signalled)] (0:0:0 - 1)
		IfNotBlocked
		reached[0][39] = 1;
		if (!(((int)now.cvars[0].signalled)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 77: // STATE 40 - pthreads.pml:85 - [cvars[0].signalled = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[0][40] = 1;
		(trpt+1)->bup.oval = ((int)now.cvars[0].signalled);
		now.cvars[0].signalled = 0;
#ifdef VAR_RANGES
		logval("cvars[0].signalled", ((int)now.cvars[0].signalled));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 78: // STATE 41 - pthreads.pml:33 - [printf('@@@ %d LOCKING : state is %e\\n',_pid,mtx.mstate)] (0:0:0 - 1)
		IfNotBlocked
		reached[0][41] = 1;
		Printf("@@@ %d LOCKING : state is %e\n", ((int)((P0 *)_this)->_pid), now.mtx.mstate);
		_m = 3; goto P999; /* 0 */
	case 79: // STATE 42 - pthreads.pml:37 - [(((mtx.mstate==unlocked)&&(mtx.mid==255)))] (60:0:2 - 1)
		IfNotBlocked
		reached[0][42] = 1;
		if (!(((now.mtx.mstate==2)&&(((int)now.mtx.mid)==255))))
			continue;
		/* merge: mtx.mstate = locked(60, 43, 60) */
		reached[0][43] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = now.mtx.mstate;
		now.mtx.mstate = 1;
#ifdef VAR_RANGES
		logval("mtx.mstate", now.mtx.mstate);
#endif
		;
		/* merge: mtx.mid = _pid(60, 44, 60) */
		reached[0][44] = 1;
		(trpt+1)->bup.ovals[1] = ((int)now.mtx.mid);
		now.mtx.mid = ((int)((P0 *)_this)->_pid);
#ifdef VAR_RANGES
		logval("mtx.mid", ((int)now.mtx.mid));
#endif
		;
		/* merge: .(goto)(0, 46, 60) */
		reached[0][46] = 1;
		;
		/* merge: .(goto)(0, 61, 60) */
		reached[0][61] = 1;
		;
		_m = 3; goto P999; /* 4 */
	case 80: // STATE 48 - pthreads.pml:43 - [(((mtx.mstate==unlocked)&&(mtx.mid==255)))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][48] = 1;
		if (!(((now.mtx.mstate==2)&&(((int)now.mtx.mid)==255))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 81: // STATE 49 - pthreads.pml:45 - [mtx.mstate = locked] (0:62:2 - 1)
		IfNotBlocked
		reached[0][49] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = now.mtx.mstate;
		now.mtx.mstate = 1;
#ifdef VAR_RANGES
		logval("mtx.mstate", now.mtx.mstate);
#endif
		;
		/* merge: mtx.mid = _pid(62, 50, 62) */
		reached[0][50] = 1;
		(trpt+1)->bup.ovals[1] = ((int)now.mtx.mid);
		now.mtx.mid = ((int)((P0 *)_this)->_pid);
#ifdef VAR_RANGES
		logval("mtx.mid", ((int)now.mtx.mid));
#endif
		;
		/* merge: goto :b4(0, 52, 62) */
		reached[0][52] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 82: // STATE 54 - pthreads.pml:51 - [((mtx.mid==_pid))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][54] = 1;
		if (!((((int)now.mtx.mid)==((int)((P0 *)_this)->_pid))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 83: // STATE 63 - pthreads.pml:58 - [printf('@@@ %d LOCKED : state is %e\\n',_pid,mtx.mstate)] (0:0:0 - 1)
		IfNotBlocked
		reached[0][63] = 1;
		Printf("@@@ %d LOCKED : state is %e\n", ((int)((P0 *)_this)->_pid), now.mtx.mstate);
		_m = 3; goto P999; /* 0 */
	case 84: // STATE 72 - pthreads.pml:94 - [printf('@@@ %d DONE with cond[%d]=%d with mutex=%e\\n',_pid,0,cvars[0].signalled,mtx.mstate)] (0:0:0 - 3)
		IfNotBlocked
		reached[0][72] = 1;
		Printf("@@@ %d DONE with cond[%d]=%d with mutex=%e\n", ((int)((P0 *)_this)->_pid), 0, ((int)now.cvars[0].signalled), now.mtx.mstate);
		_m = 3; goto P999; /* 0 */
	case 85: // STATE 77 - writers-and-reader.pml:73 - [assert((mtx.mid==_pid))] (0:0:0 - 3)
		IfNotBlocked
		reached[0][77] = 1;
		spin_assert((((int)now.mtx.mid)==((int)((P0 *)_this)->_pid)), "(mtx.mid==_pid)", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 86: // STATE 78 - writers-and-reader.pml:42 - [assert(!(bfull))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][78] = 1;
		spin_assert( !(((int)now.bfull)), " !(bfull)", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 87: // STATE 79 - writers-and-reader.pml:43 - [buffer[in] = (p+pno)] (0:0:1 - 1)
		IfNotBlocked
		reached[0][79] = 1;
		(trpt+1)->bup.oval = ((int)now.buffer[ Index(((int)now.in), 4) ]);
		now.buffer[ Index(now.in, 4) ] = (((P0 *)_this)->p+((P0 *)_this)->pno);
#ifdef VAR_RANGES
		logval("buffer[in]", ((int)now.buffer[ Index(((int)now.in), 4) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 88: // STATE 80 - writers-and-reader.pml:44 - [printf('@@@ %d INSERT buf[%d] := %d\\n',_pid,in,(p+pno))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][80] = 1;
		Printf("@@@ %d INSERT buf[%d] := %d\n", ((int)((P0 *)_this)->_pid), ((int)now.in), (((P0 *)_this)->p+((P0 *)_this)->pno));
		_m = 3; goto P999; /* 0 */
	case 89: // STATE 81 - writers-and-reader.pml:45 - [bempty = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[0][81] = 1;
		(trpt+1)->bup.oval = ((int)now.bempty);
		now.bempty = 0;
#ifdef VAR_RANGES
		logval("bempty", ((int)now.bempty));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 90: // STATE 82 - writers-and-reader.pml:46 - [bfull = (in==out)] (0:0:1 - 1)
		IfNotBlocked
		reached[0][82] = 1;
		(trpt+1)->bup.oval = ((int)now.bfull);
		now.bfull = (((int)now.in)==((int)now.out));
#ifdef VAR_RANGES
		logval("bfull", ((int)now.bfull));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 91: // STATE 83 - writers-and-reader.pml:47 - [in = ((in+1)%4)] (0:0:1 - 1)
		IfNotBlocked
		reached[0][83] = 1;
		(trpt+1)->bup.oval = ((int)now.in);
		now.in = ((((int)now.in)+1)%4);
#ifdef VAR_RANGES
		logval("in", ((int)now.in));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 92: // STATE 84 - writers-and-reader.pml:30 - [printf('@@@ %d BUFFER in:%d, out:%d, empty:%d, full:%d [|',_pid,in,out,bempty,bfull)] (0:92:1 - 1)
		IfNotBlocked
		reached[0][84] = 1;
		Printf("@@@ %d BUFFER in:%d, out:%d, empty:%d, full:%d [|", ((int)((P0 *)_this)->_pid), ((int)now.in), ((int)now.out), ((int)now.bempty), ((int)now.bfull));
		/* merge: six = 0(92, 85, 92) */
		reached[0][85] = 1;
		(trpt+1)->bup.oval = ((int)now.six);
		now.six = 0;
#ifdef VAR_RANGES
		logval("six", ((int)now.six));
#endif
		;
		/* merge: .(goto)(0, 93, 92) */
		reached[0][93] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 93: // STATE 86 - writers-and-reader.pml:33 - [((six<4))] (92:0:1 - 1)
		IfNotBlocked
		reached[0][86] = 1;
		if (!((((int)now.six)<4)))
			continue;
		/* merge: printf(' %d |',buffer[six])(92, 87, 92) */
		reached[0][87] = 1;
		Printf(" %d |", ((int)now.buffer[ Index(((int)now.six), 4) ]));
		/* merge: six = (six+1)(92, 88, 92) */
		reached[0][88] = 1;
		(trpt+1)->bup.oval = ((int)now.six);
		now.six = (((int)now.six)+1);
#ifdef VAR_RANGES
		logval("six", ((int)now.six));
#endif
		;
		/* merge: .(goto)(0, 93, 92) */
		reached[0][93] = 1;
		;
		_m = 3; goto P999; /* 3 */
	case 94: // STATE 90 - writers-and-reader.pml:34 - [printf(']\\n')] (0:94:0 - 1)
		IfNotBlocked
		reached[0][90] = 1;
		Printf("]\n");
		/* merge: goto :b5(94, 91, 94) */
		reached[0][91] = 1;
		;
		_m = 3; goto P999; /* 1 */
	case 95: // STATE 98 - pthreads.pml:99 - [printf('@@@ %d SIGNAL cond[%d]=%d\\n',_pid,1,cvars[1].signalled)] (0:0:0 - 1)
		IfNotBlocked
		reached[0][98] = 1;
		Printf("@@@ %d SIGNAL cond[%d]=%d\n", ((int)((P0 *)_this)->_pid), 1, ((int)now.cvars[1].signalled));
		_m = 3; goto P999; /* 0 */
	case 96: // STATE 99 - pthreads.pml:102 - [cvars[1].signalled = 1] (0:0:1 - 1)
		IfNotBlocked
		reached[0][99] = 1;
		(trpt+1)->bup.oval = ((int)now.cvars[1].signalled);
		now.cvars[1].signalled = 1;
#ifdef VAR_RANGES
		logval("cvars[1].signalled", ((int)now.cvars[1].signalled));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 97: // STATE 101 - pthreads.pml:105 - [printf('@@@ %d SIGNALLED cond[%d]=%d\\n',_pid,1,cvars[1].signalled)] (0:0:0 - 1)
		IfNotBlocked
		reached[0][101] = 1;
		Printf("@@@ %d SIGNALLED cond[%d]=%d\n", ((int)((P0 *)_this)->_pid), 1, ((int)now.cvars[1].signalled));
		_m = 3; goto P999; /* 0 */
	case 98: // STATE 103 - writers-and-reader.pml:77 - [assert((mtx.mid==_pid))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][103] = 1;
		spin_assert((((int)now.mtx.mid)==((int)((P0 *)_this)->_pid)), "(mtx.mid==_pid)", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 99: // STATE 104 - pthreads.pml:63 - [printf('@@@ %d UNLOCKING : state is %e\\n',_pid,mtx.mstate)] (0:0:0 - 1)
		IfNotBlocked
		reached[0][104] = 1;
		Printf("@@@ %d UNLOCKING : state is %e\n", ((int)((P0 *)_this)->_pid), now.mtx.mstate);
		_m = 3; goto P999; /* 0 */
	case 100: // STATE 105 - pthreads.pml:67 - [(((mtx.mstate==locked)&&(mtx.mid==_pid)))] (111:0:2 - 1)
		IfNotBlocked
		reached[0][105] = 1;
		if (!(((now.mtx.mstate==1)&&(((int)now.mtx.mid)==((int)((P0 *)_this)->_pid)))))
			continue;
		/* merge: mtx.mstate = unlocked(111, 106, 111) */
		reached[0][106] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = now.mtx.mstate;
		now.mtx.mstate = 2;
#ifdef VAR_RANGES
		logval("mtx.mstate", now.mtx.mstate);
#endif
		;
		/* merge: mtx.mid = 255(111, 107, 111) */
		reached[0][107] = 1;
		(trpt+1)->bup.ovals[1] = ((int)now.mtx.mid);
		now.mtx.mid = 255;
#ifdef VAR_RANGES
		logval("mtx.mid", ((int)now.mtx.mid));
#endif
		;
		/* merge: .(goto)(111, 109, 111) */
		reached[0][109] = 1;
		;
		_m = 3; goto P999; /* 3 */
	case 101: // STATE 111 - pthreads.pml:73 - [printf('@@@ %d UNLOCKED : state is %e\\n',_pid,mtx.mstate)] (0:0:0 - 1)
		IfNotBlocked
		reached[0][111] = 1;
		Printf("@@@ %d UNLOCKED : state is %e\n", ((int)((P0 *)_this)->_pid), now.mtx.mstate);
		_m = 3; goto P999; /* 0 */
	case 102: // STATE 114 - writers-and-reader.pml:86 - [p = ((p+2)%8)] (0:0:1 - 1)
		IfNotBlocked
		reached[0][114] = 1;
		(trpt+1)->bup.oval = ((P0 *)_this)->p;
		((P0 *)_this)->p = ((((P0 *)_this)->p+2)%8);
#ifdef VAR_RANGES
		logval("producer:p", ((P0 *)_this)->p);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 103: // STATE 118 - writers-and-reader.pml:90 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[0][118] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */
	case  _T5:	/* np_ */
		if (!((!(trpt->o_pm&4) && !(trpt->tau&128))))
			continue;
		/* else fall through */
	case  _T2:	/* true */
		_m = 3; goto P999;
#undef rand
	}

