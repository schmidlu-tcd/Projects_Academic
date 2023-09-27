	switch (t->back) {
	default: Uerror("bad return move");
	case  0: goto R999; /* nothing to undo */

		 /* PROC :init: */
;
		
	case 3: // STATE 1
		goto R999;

	case 4: // STATE 3
		;
		now.in = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 6: // STATE 5
		;
		now.buffer[ Index(now.in, 4) ] = trpt->bup.oval;
		;
		goto R999;

	case 7: // STATE 6
		;
		now.in = trpt->bup.oval;
		;
		goto R999;

	case 8: // STATE 8
		;
		now.in = trpt->bup.oval;
		;
		goto R999;

	case 9: // STATE 13
		;
		now.out = trpt->bup.oval;
		;
		goto R999;

	case 10: // STATE 14
		;
		now.bfull = trpt->bup.oval;
		;
		goto R999;

	case 11: // STATE 15
		;
		now.bempty = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 13: // STATE 19
		;
		now.six = trpt->bup.oval;
		;
		goto R999;

	case 14: // STATE 22
		;
		now.six = trpt->bup.oval;
		;
		goto R999;
;
		
	case 15: // STATE 24
		goto R999;

	case 16: // STATE 31
		;
		now.mtx.mstate = trpt->bup.oval;
		;
		goto R999;

	case 17: // STATE 32
		;
		now.mtx.mid = trpt->bup.oval;
		;
		goto R999;

	case 18: // STATE 33
		;
		now.cvars[0].signalled = trpt->bup.oval;
		;
		goto R999;

	case 19: // STATE 34
		;
		now.cvars[1].signalled = trpt->bup.oval;
		;
		goto R999;

	case 20: // STATE 36
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 21: // STATE 37
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 22: // STATE 38
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 23: // STATE 39
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC consumer */
;
		;
		
	case 25: // STATE 4
		;
		now.mtx.mid = trpt->bup.ovals[1];
		now.mtx.mstate = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;
;
		;
		
	case 27: // STATE 10
		;
		now.mtx.mid = trpt->bup.ovals[1];
		now.mtx.mstate = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;
;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		
	case 34: // STATE 33
		;
		now.mtx.mid = trpt->bup.ovals[1];
		now.mtx.mstate = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;
;
		;
		;
		;
		
	case 37: // STATE 40
		;
		now.cvars[1].signalled = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 39: // STATE 44
		;
		now.mtx.mid = trpt->bup.ovals[1];
		now.mtx.mstate = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;
;
		;
		
	case 41: // STATE 50
		;
		now.mtx.mid = trpt->bup.ovals[1];
		now.mtx.mstate = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;
;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		
	case 47: // STATE 79
		;
		now.out = trpt->bup.oval;
		;
		goto R999;

	case 48: // STATE 80
		;
		cout = trpt->bup.oval;
		;
		goto R999;

	case 49: // STATE 81
		;
		now.buffer[ Index(now.out, 4) ] = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 51: // STATE 83
		;
		now.bfull = trpt->bup.oval;
		;
		goto R999;

	case 52: // STATE 84
		;
		now.bempty = trpt->bup.oval;
		;
		goto R999;

	case 53: // STATE 86
		;
		now.six = trpt->bup.oval;
		;
		goto R999;

	case 54: // STATE 89
		;
		now.six = trpt->bup.oval;
		;
		goto R999;
;
		
	case 55: // STATE 91
		goto R999;
;
		;
		
	case 57: // STATE 100
		;
		now.cvars[0].signalled = trpt->bup.oval;
		;
		goto R999;
;
		;
		;
		;
		;
		;
		
	case 61: // STATE 108
		;
		now.mtx.mid = trpt->bup.ovals[1];
		now.mtx.mstate = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;
;
		;
		
	case 63: // STATE 118
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC producer */
;
		;
		
	case 65: // STATE 4
		;
		now.mtx.mid = trpt->bup.ovals[1];
		now.mtx.mstate = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;
;
		;
		
	case 67: // STATE 10
		;
		now.mtx.mid = trpt->bup.ovals[1];
		now.mtx.mstate = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;
;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		
	case 74: // STATE 33
		;
		now.mtx.mid = trpt->bup.ovals[1];
		now.mtx.mstate = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;
;
		;
		;
		;
		
	case 77: // STATE 40
		;
		now.cvars[0].signalled = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 79: // STATE 44
		;
		now.mtx.mid = trpt->bup.ovals[1];
		now.mtx.mstate = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;
;
		;
		
	case 81: // STATE 50
		;
		now.mtx.mid = trpt->bup.ovals[1];
		now.mtx.mstate = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;
;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		
	case 87: // STATE 79
		;
		now.buffer[ Index(now.in, 4) ] = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 89: // STATE 81
		;
		now.bempty = trpt->bup.oval;
		;
		goto R999;

	case 90: // STATE 82
		;
		now.bfull = trpt->bup.oval;
		;
		goto R999;

	case 91: // STATE 83
		;
		now.in = trpt->bup.oval;
		;
		goto R999;

	case 92: // STATE 85
		;
		now.six = trpt->bup.oval;
		;
		goto R999;

	case 93: // STATE 88
		;
		now.six = trpt->bup.oval;
		;
		goto R999;
;
		
	case 94: // STATE 90
		goto R999;
;
		;
		
	case 96: // STATE 99
		;
		now.cvars[1].signalled = trpt->bup.oval;
		;
		goto R999;
;
		;
		;
		;
		;
		;
		
	case 100: // STATE 107
		;
		now.mtx.mid = trpt->bup.ovals[1];
		now.mtx.mstate = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;
;
		;
		
	case 102: // STATE 114
		;
		((P0 *)_this)->p = trpt->bup.oval;
		;
		goto R999;

	case 103: // STATE 118
		;
		p_restor(II);
		;
		;
		goto R999;
	}

