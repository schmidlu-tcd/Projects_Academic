#ifdef PEG
struct T_SRC {
	char *fl; int ln;
} T_SRC[NTRANS];

void
tr_2_src(int m, char *file, int ln)
{	T_SRC[m].fl = file;
	T_SRC[m].ln = ln;
}

void
putpeg(int n, int m)
{	printf("%5d	trans %4d ", m, n);
	printf("%s:%d\n",
		T_SRC[n].fl, T_SRC[n].ln);
}
#endif

void
settable(void)
{	Trans *T;
	Trans *settr(int, int, int, int, int, char *, int, int, int);

	trans = (Trans ***) emalloc(4*sizeof(Trans **));

	/* proctype 2: :init: */

	trans[2] = (Trans **) emalloc(40*sizeof(Trans *));

	trans[2][1]	= settr(236,0,17,3,3,"printf('A Model of pthreads\\n')", 0, 2, 0); /* m: 2 -> 0,17 */
	reached2[2] = 1;
	trans[2][2]	= settr(0,0,0,0,0,"printf('\\n Producer-Consumer example\\n')",0,0,0);
	T = trans[ 2][17] = settr(252,0,0,0,0,"sub-sequence", 0, 2, 0);
	T->nxt	= settr(252,0,3,0,0,"sub-sequence", 0, 2, 0);
	trans[2][3]	= settr(238,0,10,4,4,"in = 0", 1, 2, 0);
	trans[2][11]	= settr(246,0,10,1,0,".(goto)", 0, 2, 0);
	T = trans[2][10] = settr(245,0,0,0,0,"DO", 0, 2, 0);
	T = T->nxt	= settr(245,0,4,0,0,"DO", 0, 2, 0);
	    T->nxt	= settr(245,0,7,0,0,"DO", 0, 2, 0);
	trans[2][4]	= settr(239,0,5,5,0,"((in<4))", 1, 2, 0);
	trans[2][5]	= settr(240,0,6,6,6,"buffer[in] = 0", 1, 2, 0);
	trans[2][6]	= settr(241,0,10,7,7,"in = (in+1)", 1, 2, 0);
	trans[2][7]	= settr(242,0,8,2,0,"else", 0, 2, 0);
	trans[2][8]	= settr(243,0,13,8,8,"in = 0", 1, 2, 0);
	trans[2][9]	= settr(244,0,13,1,0,"goto :b12", 0, 2, 0);
	trans[2][12]	= settr(247,0,13,1,0,"break", 0, 2, 0);
	trans[2][13]	= settr(248,0,14,9,9,"out = (4-1)", 1, 2, 0);
	trans[2][14]	= settr(249,0,15,10,10,"bfull = 0", 1, 2, 0);
	trans[2][15]	= settr(250,0,16,11,11,"bempty = 1", 1, 2, 0);
	trans[2][16]	= settr(251,0,30,12,0,"printf('buffer zeroed\\n')", 0, 2, 0);
	T = trans[ 2][30] = settr(265,0,0,0,0,"sub-sequence", 0, 2, 0);
	T->nxt	= settr(265,0,29,0,0,"sub-sequence", 0, 2, 0);
	T = trans[ 2][29] = settr(264,2,0,0,0,"ATOMIC", 1, 2, 0);
	T->nxt	= settr(264,2,18,0,0,"ATOMIC", 1, 2, 0);
	trans[2][18]	= settr(253,2,26,13,13,"printf('@@@ %d BUFFER in:%d, out:%d, empty:%d, full:%d [|',_pid,in,out,bempty,bfull)", 1, 2, 0); /* m: 19 -> 0,26 */
	reached2[19] = 1;
	trans[2][19]	= settr(0,0,0,0,0,"six = 0",0,0,0);
	trans[2][27]	= settr(262,2,26,1,0,".(goto)", 1, 2, 0);
	T = trans[2][26] = settr(261,2,0,0,0,"DO", 1, 2, 0);
	T = T->nxt	= settr(261,2,20,0,0,"DO", 1, 2, 0);
	    T->nxt	= settr(261,2,23,0,0,"DO", 1, 2, 0);
	trans[2][20]	= settr(255,2,26,14,14,"((six<4))", 1, 2, 0); /* m: 21 -> 26,0 */
	reached2[21] = 1;
	trans[2][21]	= settr(0,0,0,0,0,"printf(' %d |',buffer[six])",0,0,0);
	trans[2][22]	= settr(0,0,0,0,0,"six = (six+1)",0,0,0);
	trans[2][23]	= settr(258,2,24,2,0,"else", 1, 2, 0);
	trans[2][24]	= settr(259,2,28,15,15,"printf(']\\n')", 1, 2, 0); /* m: 25 -> 0,28 */
	reached2[25] = 1;
	trans[2][25]	= settr(260,2,28,1,0,"goto :b13", 1, 2, 0);
	trans[2][28]	= settr(263,0,35,1,0,"break", 1, 2, 0);
	T = trans[ 2][35] = settr(270,0,0,0,0,"sub-sequence", 0, 2, 0);
	T->nxt	= settr(270,0,31,0,0,"sub-sequence", 0, 2, 0);
	trans[2][31]	= settr(266,0,32,16,16,"mtx.mstate = unlocked", 1, 2, 0);
	trans[2][32]	= settr(267,0,33,17,17,"mtx.mid = 255", 1, 2, 0);
	trans[2][33]	= settr(268,0,34,18,18,"cvars[0].signalled = 0", 1, 2, 0);
	trans[2][34]	= settr(269,0,36,19,19,"cvars[1].signalled = 0", 1, 2, 0);
	trans[2][36]	= settr(271,0,37,20,20,"(run producer(1))", 0, 2, 0);
	trans[2][37]	= settr(272,0,38,21,21,"(run producer(2))", 0, 2, 0);
	trans[2][38]	= settr(273,0,39,22,22,"(run consumer())", 0, 2, 0);
	trans[2][39]	= settr(274,0,0,23,23,"-end-", 0, 3500, 0);

	/* proctype 1: consumer */

	trans[1] = (Trans **) emalloc(119*sizeof(Trans *));

	trans[1][116]	= settr(233,0,115,1,0,".(goto)", 0, 2, 0);
	T = trans[1][115] = settr(232,0,0,0,0,"DO", 0, 2, 0);
	    T->nxt	= settr(232,0,114,0,0,"DO", 0, 2, 0);
	T = trans[ 1][114] = settr(231,0,0,0,0,"sub-sequence", 0, 2, 0);
	T->nxt	= settr(231,0,24,0,0,"sub-sequence", 0, 2, 0);
	T = trans[ 1][24] = settr(141,0,0,0,0,"sub-sequence", 0, 2, 0);
	T->nxt	= settr(141,0,1,0,0,"sub-sequence", 0, 2, 0);
	trans[1][1]	= settr(118,0,7,24,0,"printf('@@@ %d LOCKING : state is %e\\n',_pid,mtx.mstate)", 1, 2, 0);
	T = trans[ 1][7] = settr(124,2,0,0,0,"ATOMIC", 1, 2, 0);
	T->nxt	= settr(124,2,5,0,0,"ATOMIC", 1, 2, 0);
	T = trans[1][5] = settr(122,2,0,0,0,"IF", 1, 2, 0);
	    T->nxt	= settr(122,2,2,0,0,"IF", 1, 2, 0);
	trans[1][2]	= settr(119,0,20,25,25,"(((mtx.mstate==unlocked)&&(mtx.mid==255)))", 1, 2, 0); /* m: 3 -> 20,0 */
	reached1[3] = 1;
	trans[1][3]	= settr(0,0,0,0,0,"mtx.mstate = locked",0,0,0);
	trans[1][4]	= settr(0,0,0,0,0,"mtx.mid = _pid",0,0,0);
	trans[1][6]	= settr(123,0,20,1,0,".(goto)", 1, 2, 0);
	trans[1][21]	= settr(138,0,20,1,0,".(goto)", 0, 2, 0);
	T = trans[1][20] = settr(137,0,0,0,0,"DO", 0, 2, 0);
	T = T->nxt	= settr(137,0,8,0,0,"DO", 0, 2, 0);
	    T->nxt	= settr(137,0,13,0,0,"DO", 0, 2, 0);
	trans[1][8]	= settr(125,0,11,26,0,"(((mtx.mstate==unlocked)&&(mtx.mid==255)))", 1, 2, 0);
	T = trans[ 1][11] = settr(128,2,0,0,0,"ATOMIC", 1, 2, 0);
	T->nxt	= settr(128,2,9,0,0,"ATOMIC", 1, 2, 0);
	trans[1][9]	= settr(126,0,23,27,27,"mtx.mstate = locked", 1, 2, 0); /* m: 10 -> 0,23 */
	reached1[10] = 1;
	trans[1][10]	= settr(0,0,0,0,0,"mtx.mid = _pid",0,0,0);
	trans[1][12]	= settr(129,0,23,1,0,"goto :b7", 0, 2, 0);
	trans[1][13]	= settr(130,0,18,2,0,"else", 0, 2, 0);
	T = trans[1][18] = settr(135,0,0,0,0,"IF", 0, 2, 0);
	T = T->nxt	= settr(135,0,14,0,0,"IF", 0, 2, 0);
	    T->nxt	= settr(135,0,16,0,0,"IF", 0, 2, 0);
	trans[1][14]	= settr(131,0,23,28,0,"((mtx.mid==_pid))", 1, 2, 0);
	trans[1][15]	= settr(132,0,23,1,0,"goto :b7", 0, 2, 0);
	trans[1][19]	= settr(136,0,20,1,0,".(goto)", 0, 2, 0);
	trans[1][16]	= settr(133,0,17,2,0,"else", 0, 2, 0);
	trans[1][17]	= settr(134,0,20,1,0,"(1)", 0, 2, 0);
	trans[1][22]	= settr(139,0,23,1,0,"break", 0, 2, 0);
	trans[1][23]	= settr(140,0,25,29,0,"printf('@@@ %d LOCKED : state is %e\\n',_pid,mtx.mstate)", 1, 2, 0);
	trans[1][25]	= settr(142,0,74,30,0,"assert((mtx.mid==_pid))", 1, 2, 0);
	trans[1][75]	= settr(192,0,74,1,0,".(goto)", 0, 2, 0);
	T = trans[1][74] = settr(191,0,0,0,0,"DO", 0, 2, 0);
	T = T->nxt	= settr(191,0,26,0,0,"DO", 0, 2, 0);
	    T->nxt	= settr(191,0,28,0,0,"DO", 0, 2, 0);
	trans[1][26]	= settr(143,0,77,31,0,"(!(bempty))", 1, 2, 0);
	trans[1][27]	= settr(144,0,77,1,0,"goto :b8", 0, 2, 0);
	trans[1][28]	= settr(145,0,73,2,0,"else", 0, 2, 0);
	T = trans[ 1][73] = settr(190,0,0,0,0,"sub-sequence", 0, 2, 0);
	T->nxt	= settr(190,0,29,0,0,"sub-sequence", 0, 2, 0);
	trans[1][29]	= settr(146,0,38,32,0,"printf('@@@ %d WAIT for cond[%d]=%d with mutex=%e\\n',_pid,1,cvars[1].signalled,mtx.mstate)", 1, 2, 0);
	T = trans[ 1][38] = settr(155,0,0,0,0,"sub-sequence", 0, 2, 0);
	T->nxt	= settr(155,0,30,0,0,"sub-sequence", 0, 2, 0);
	trans[1][30]	= settr(147,0,36,33,0,"printf('@@@ %d UNLOCKING : state is %e\\n',_pid,mtx.mstate)", 1, 2, 0);
	T = trans[ 1][36] = settr(153,2,0,0,0,"ATOMIC", 1, 2, 0);
	T->nxt	= settr(153,2,34,0,0,"ATOMIC", 1, 2, 0);
	T = trans[1][34] = settr(151,2,0,0,0,"IF", 1, 2, 0);
	    T->nxt	= settr(151,2,31,0,0,"IF", 1, 2, 0);
	trans[1][31]	= settr(148,4,37,34,34,"(((mtx.mstate==locked)&&(mtx.mid==_pid)))", 1, 2, 0); /* m: 32 -> 37,0 */
	reached1[32] = 1;
	trans[1][32]	= settr(0,0,0,0,0,"mtx.mstate = unlocked",0,0,0);
	trans[1][33]	= settr(0,0,0,0,0,"mtx.mid = 255",0,0,0);
	trans[1][35]	= settr(152,0,37,1,0,".(goto)", 1, 2, 0);
	trans[1][37]	= settr(154,0,69,35,0,"printf('@@@ %d UNLOCKED : state is %e\\n',_pid,mtx.mstate)", 1, 2, 0);
	trans[1][70]	= settr(187,0,69,1,0,".(goto)", 0, 2, 0);
	T = trans[1][69] = settr(186,0,0,0,0,"DO", 0, 2, 0);
	T = T->nxt	= settr(186,0,39,0,0,"DO", 0, 2, 0);
	    T->nxt	= settr(186,0,67,0,0,"DO", 0, 2, 0);
	trans[1][39]	= settr(156,0,65,36,0,"(cvars[1].signalled)", 1, 2, 0);
	T = trans[ 1][65] = settr(182,2,0,0,0,"ATOMIC", 1, 2, 0);
	T->nxt	= settr(182,2,40,0,0,"ATOMIC", 1, 2, 0);
	trans[1][40]	= settr(157,2,64,37,37,"cvars[1].signalled = 0", 1, 2, 0);
	T = trans[ 1][64] = settr(181,0,0,0,0,"sub-sequence", 1, 2, 0);
	T->nxt	= settr(181,0,41,0,0,"sub-sequence", 1, 2, 0);
	trans[1][41]	= settr(158,2,47,38,0,"printf('@@@ %d LOCKING : state is %e\\n',_pid,mtx.mstate)", 1, 2, 0);
	T = trans[ 1][47] = settr(164,0,0,0,0,"sub-sequence", 1, 2, 0);
	T->nxt	= settr(164,0,45,0,0,"sub-sequence", 1, 2, 0);
	T = trans[1][45] = settr(162,2,0,0,0,"IF", 1, 2, 0);
	    T->nxt	= settr(162,2,42,0,0,"IF", 1, 2, 0);
	trans[1][42]	= settr(159,2,60,39,39,"(((mtx.mstate==unlocked)&&(mtx.mid==255)))", 1, 2, 0); /* m: 43 -> 60,0 */
	reached1[43] = 1;
	trans[1][43]	= settr(0,0,0,0,0,"mtx.mstate = locked",0,0,0);
	trans[1][44]	= settr(0,0,0,0,0,"mtx.mid = _pid",0,0,0);
	trans[1][46]	= settr(163,2,60,1,0,".(goto)", 1, 2, 0);
	trans[1][61]	= settr(178,2,60,1,0,".(goto)", 1, 2, 0);
	T = trans[1][60] = settr(177,2,0,0,0,"DO", 1, 2, 0);
	T = T->nxt	= settr(177,2,48,0,0,"DO", 1, 2, 0);
	    T->nxt	= settr(177,2,53,0,0,"DO", 1, 2, 0);
	trans[1][48]	= settr(165,2,51,40,0,"(((mtx.mstate==unlocked)&&(mtx.mid==255)))", 1, 2, 0);
	T = trans[ 1][51] = settr(168,0,0,0,0,"sub-sequence", 1, 2, 0);
	T->nxt	= settr(168,0,49,0,0,"sub-sequence", 1, 2, 0);
	trans[1][49]	= settr(166,2,62,41,41,"mtx.mstate = locked", 1, 2, 0); /* m: 50 -> 0,62 */
	reached1[50] = 1;
	trans[1][50]	= settr(0,0,0,0,0,"mtx.mid = _pid",0,0,0);
	trans[1][52]	= settr(169,2,62,1,0,"goto :b10", 1, 2, 0);
	trans[1][53]	= settr(170,2,58,2,0,"else", 1, 2, 0);
	T = trans[1][58] = settr(175,2,0,0,0,"IF", 1, 2, 0);
	T = T->nxt	= settr(175,2,54,0,0,"IF", 1, 2, 0);
	    T->nxt	= settr(175,2,56,0,0,"IF", 1, 2, 0);
	trans[1][54]	= settr(171,2,62,42,0,"((mtx.mid==_pid))", 1, 2, 0);
	trans[1][55]	= settr(172,2,62,1,0,"goto :b10", 1, 2, 0);
	trans[1][59]	= settr(176,2,60,1,0,".(goto)", 1, 2, 0);
	trans[1][56]	= settr(173,2,57,2,0,"else", 1, 2, 0);
	trans[1][57]	= settr(174,2,60,1,0,"(1)", 1, 2, 0);
	trans[1][62]	= settr(179,2,63,1,0,"break", 1, 2, 0);
	trans[1][63]	= settr(180,0,72,43,0,"printf('@@@ %d LOCKED : state is %e\\n',_pid,mtx.mstate)", 1, 2, 0);
	trans[1][66]	= settr(183,0,72,1,0,"goto :b9", 0, 2, 0);
	trans[1][67]	= settr(184,0,68,2,0,"else", 0, 2, 0);
	trans[1][68]	= settr(185,0,69,1,0,"(1)", 0, 2, 0);
	trans[1][71]	= settr(188,0,72,1,0,"break", 0, 2, 0);
	trans[1][72]	= settr(189,0,74,44,0,"printf('@@@ %d DONE with cond[%d]=%d with mutex=%e\\n',_pid,1,cvars[1].signalled,mtx.mstate)", 1, 2, 0);
	trans[1][76]	= settr(193,0,77,1,0,"break", 0, 2, 0);
	trans[1][77]	= settr(194,0,98,45,0,"assert((mtx.mid==_pid))", 1, 2, 0);
	T = trans[ 1][98] = settr(215,0,0,0,0,"sub-sequence", 0, 2, 0);
	T->nxt	= settr(215,0,78,0,0,"sub-sequence", 0, 2, 0);
	trans[1][78]	= settr(195,0,79,46,0,"assert(!(bempty))", 1, 2, 0);
	trans[1][79]	= settr(196,0,80,47,47,"out = ((out+1)%4)", 1, 2, 0);
	trans[1][80]	= settr(197,0,81,48,48,"cout = buffer[out]", 1, 2, 0);
	trans[1][81]	= settr(198,0,82,49,49,"buffer[out] = 0", 1, 2, 0);
	trans[1][82]	= settr(199,0,83,50,0,"printf('@@@ %d **** EXTRACT cout := buf[%d] is %d\\n',_pid,out,cout)", 1, 2, 0);
	trans[1][83]	= settr(200,0,84,51,51,"bfull = 0", 1, 2, 0);
	trans[1][84]	= settr(201,0,97,52,52,"bempty = (((out+1)%4)==in)", 1, 2, 0);
	T = trans[ 1][97] = settr(214,0,0,0,0,"sub-sequence", 0, 2, 0);
	T->nxt	= settr(214,0,96,0,0,"sub-sequence", 0, 2, 0);
	T = trans[ 1][96] = settr(213,2,0,0,0,"ATOMIC", 1, 2, 0);
	T->nxt	= settr(213,2,85,0,0,"ATOMIC", 1, 2, 0);
	trans[1][85]	= settr(202,2,93,53,53,"printf('@@@ %d BUFFER in:%d, out:%d, empty:%d, full:%d [|',_pid,in,out,bempty,bfull)", 1, 2, 0); /* m: 86 -> 0,93 */
	reached1[86] = 1;
	trans[1][86]	= settr(0,0,0,0,0,"six = 0",0,0,0);
	trans[1][94]	= settr(211,2,93,1,0,".(goto)", 1, 2, 0);
	T = trans[1][93] = settr(210,2,0,0,0,"DO", 1, 2, 0);
	T = T->nxt	= settr(210,2,87,0,0,"DO", 1, 2, 0);
	    T->nxt	= settr(210,2,90,0,0,"DO", 1, 2, 0);
	trans[1][87]	= settr(204,2,93,54,54,"((six<4))", 1, 2, 0); /* m: 88 -> 93,0 */
	reached1[88] = 1;
	trans[1][88]	= settr(0,0,0,0,0,"printf(' %d |',buffer[six])",0,0,0);
	trans[1][89]	= settr(0,0,0,0,0,"six = (six+1)",0,0,0);
	trans[1][90]	= settr(207,2,91,2,0,"else", 1, 2, 0);
	trans[1][91]	= settr(208,2,95,55,55,"printf(']\\n')", 1, 2, 0); /* m: 92 -> 0,95 */
	reached1[92] = 1;
	trans[1][92]	= settr(209,2,95,1,0,"goto :b11", 1, 2, 0);
	trans[1][95]	= settr(212,0,103,1,0,"break", 1, 2, 0);
	T = trans[ 1][103] = settr(220,0,0,0,0,"sub-sequence", 0, 2, 0);
	T->nxt	= settr(220,0,99,0,0,"sub-sequence", 0, 2, 0);
	trans[1][99]	= settr(216,0,101,56,0,"printf('@@@ %d SIGNAL cond[%d]=%d\\n',_pid,0,cvars[0].signalled)", 1, 2, 0);
	T = trans[ 1][101] = settr(218,2,0,0,0,"ATOMIC", 1, 2, 0);
	T->nxt	= settr(218,2,100,0,0,"ATOMIC", 1, 2, 0);
	trans[1][100]	= settr(217,0,102,57,57,"cvars[0].signalled = 1", 1, 2, 0);
	trans[1][102]	= settr(219,0,104,58,0,"printf('@@@ %d SIGNALLED cond[%d]=%d\\n',_pid,0,cvars[0].signalled)", 1, 2, 0);
	trans[1][104]	= settr(221,0,113,59,0,"assert((mtx.mid==_pid))", 1, 2, 0);
	T = trans[ 1][113] = settr(230,0,0,0,0,"sub-sequence", 0, 2, 0);
	T->nxt	= settr(230,0,105,0,0,"sub-sequence", 0, 2, 0);
	trans[1][105]	= settr(222,0,111,60,0,"printf('@@@ %d UNLOCKING : state is %e\\n',_pid,mtx.mstate)", 1, 2, 0);
	T = trans[ 1][111] = settr(228,2,0,0,0,"ATOMIC", 1, 2, 0);
	T->nxt	= settr(228,2,109,0,0,"ATOMIC", 1, 2, 0);
	T = trans[1][109] = settr(226,2,0,0,0,"IF", 1, 2, 0);
	    T->nxt	= settr(226,2,106,0,0,"IF", 1, 2, 0);
	trans[1][106]	= settr(223,4,112,61,61,"(((mtx.mstate==locked)&&(mtx.mid==_pid)))", 1, 2, 0); /* m: 107 -> 112,0 */
	reached1[107] = 1;
	trans[1][107]	= settr(0,0,0,0,0,"mtx.mstate = unlocked",0,0,0);
	trans[1][108]	= settr(0,0,0,0,0,"mtx.mid = 255",0,0,0);
	trans[1][110]	= settr(227,0,112,1,0,".(goto)", 1, 2, 0);
	trans[1][112]	= settr(229,0,115,62,0,"printf('@@@ %d UNLOCKED : state is %e\\n',_pid,mtx.mstate)", 1, 2, 0);
	trans[1][117]	= settr(234,0,118,1,0,"break", 0, 2, 0);
	trans[1][118]	= settr(235,0,0,63,63,"-end-", 0, 3500, 0);

	/* proctype 0: producer */

	trans[0] = (Trans **) emalloc(119*sizeof(Trans *));

	trans[0][116]	= settr(115,0,115,1,0,".(goto)", 0, 2, 0);
	T = trans[0][115] = settr(114,0,0,0,0,"DO", 0, 2, 0);
	    T->nxt	= settr(114,0,113,0,0,"DO", 0, 2, 0);
	T = trans[ 0][113] = settr(112,0,0,0,0,"sub-sequence", 0, 2, 0);
	T->nxt	= settr(112,0,24,0,0,"sub-sequence", 0, 2, 0);
	T = trans[ 0][24] = settr(23,0,0,0,0,"sub-sequence", 0, 2, 0);
	T->nxt	= settr(23,0,1,0,0,"sub-sequence", 0, 2, 0);
	trans[0][1]	= settr(0,0,7,64,0,"printf('@@@ %d LOCKING : state is %e\\n',_pid,mtx.mstate)", 1, 2, 0);
	T = trans[ 0][7] = settr(6,2,0,0,0,"ATOMIC", 1, 2, 0);
	T->nxt	= settr(6,2,5,0,0,"ATOMIC", 1, 2, 0);
	T = trans[0][5] = settr(4,2,0,0,0,"IF", 1, 2, 0);
	    T->nxt	= settr(4,2,2,0,0,"IF", 1, 2, 0);
	trans[0][2]	= settr(1,0,20,65,65,"(((mtx.mstate==unlocked)&&(mtx.mid==255)))", 1, 2, 0); /* m: 3 -> 20,0 */
	reached0[3] = 1;
	trans[0][3]	= settr(0,0,0,0,0,"mtx.mstate = locked",0,0,0);
	trans[0][4]	= settr(0,0,0,0,0,"mtx.mid = _pid",0,0,0);
	trans[0][6]	= settr(5,0,20,1,0,".(goto)", 1, 2, 0);
	trans[0][21]	= settr(20,0,20,1,0,".(goto)", 0, 2, 0);
	T = trans[0][20] = settr(19,0,0,0,0,"DO", 0, 2, 0);
	T = T->nxt	= settr(19,0,8,0,0,"DO", 0, 2, 0);
	    T->nxt	= settr(19,0,13,0,0,"DO", 0, 2, 0);
	trans[0][8]	= settr(7,0,11,66,0,"(((mtx.mstate==unlocked)&&(mtx.mid==255)))", 1, 2, 0);
	T = trans[ 0][11] = settr(10,2,0,0,0,"ATOMIC", 1, 2, 0);
	T->nxt	= settr(10,2,9,0,0,"ATOMIC", 1, 2, 0);
	trans[0][9]	= settr(8,0,23,67,67,"mtx.mstate = locked", 1, 2, 0); /* m: 10 -> 0,23 */
	reached0[10] = 1;
	trans[0][10]	= settr(0,0,0,0,0,"mtx.mid = _pid",0,0,0);
	trans[0][12]	= settr(11,0,23,1,0,"goto :b1", 0, 2, 0);
	trans[0][13]	= settr(12,0,18,2,0,"else", 0, 2, 0);
	T = trans[0][18] = settr(17,0,0,0,0,"IF", 0, 2, 0);
	T = T->nxt	= settr(17,0,14,0,0,"IF", 0, 2, 0);
	    T->nxt	= settr(17,0,16,0,0,"IF", 0, 2, 0);
	trans[0][14]	= settr(13,0,23,68,0,"((mtx.mid==_pid))", 1, 2, 0);
	trans[0][15]	= settr(14,0,23,1,0,"goto :b1", 0, 2, 0);
	trans[0][19]	= settr(18,0,20,1,0,".(goto)", 0, 2, 0);
	trans[0][16]	= settr(15,0,17,2,0,"else", 0, 2, 0);
	trans[0][17]	= settr(16,0,20,1,0,"(1)", 0, 2, 0);
	trans[0][22]	= settr(21,0,23,1,0,"break", 0, 2, 0);
	trans[0][23]	= settr(22,0,25,69,0,"printf('@@@ %d LOCKED : state is %e\\n',_pid,mtx.mstate)", 1, 2, 0);
	trans[0][25]	= settr(24,0,74,70,0,"assert((mtx.mid==_pid))", 1, 2, 0);
	trans[0][75]	= settr(74,0,74,1,0,".(goto)", 0, 2, 0);
	T = trans[0][74] = settr(73,0,0,0,0,"DO", 0, 2, 0);
	T = T->nxt	= settr(73,0,26,0,0,"DO", 0, 2, 0);
	    T->nxt	= settr(73,0,28,0,0,"DO", 0, 2, 0);
	trans[0][26]	= settr(25,0,77,71,0,"(!(bfull))", 1, 2, 0);
	trans[0][27]	= settr(26,0,77,1,0,"goto :b2", 0, 2, 0);
	trans[0][28]	= settr(27,0,73,2,0,"else", 0, 2, 0);
	T = trans[ 0][73] = settr(72,0,0,0,0,"sub-sequence", 0, 2, 0);
	T->nxt	= settr(72,0,29,0,0,"sub-sequence", 0, 2, 0);
	trans[0][29]	= settr(28,0,38,72,0,"printf('@@@ %d WAIT for cond[%d]=%d with mutex=%e\\n',_pid,0,cvars[0].signalled,mtx.mstate)", 1, 2, 0);
	T = trans[ 0][38] = settr(37,0,0,0,0,"sub-sequence", 0, 2, 0);
	T->nxt	= settr(37,0,30,0,0,"sub-sequence", 0, 2, 0);
	trans[0][30]	= settr(29,0,36,73,0,"printf('@@@ %d UNLOCKING : state is %e\\n',_pid,mtx.mstate)", 1, 2, 0);
	T = trans[ 0][36] = settr(35,2,0,0,0,"ATOMIC", 1, 2, 0);
	T->nxt	= settr(35,2,34,0,0,"ATOMIC", 1, 2, 0);
	T = trans[0][34] = settr(33,2,0,0,0,"IF", 1, 2, 0);
	    T->nxt	= settr(33,2,31,0,0,"IF", 1, 2, 0);
	trans[0][31]	= settr(30,4,37,74,74,"(((mtx.mstate==locked)&&(mtx.mid==_pid)))", 1, 2, 0); /* m: 32 -> 37,0 */
	reached0[32] = 1;
	trans[0][32]	= settr(0,0,0,0,0,"mtx.mstate = unlocked",0,0,0);
	trans[0][33]	= settr(0,0,0,0,0,"mtx.mid = 255",0,0,0);
	trans[0][35]	= settr(34,0,37,1,0,".(goto)", 1, 2, 0);
	trans[0][37]	= settr(36,0,69,75,0,"printf('@@@ %d UNLOCKED : state is %e\\n',_pid,mtx.mstate)", 1, 2, 0);
	trans[0][70]	= settr(69,0,69,1,0,".(goto)", 0, 2, 0);
	T = trans[0][69] = settr(68,0,0,0,0,"DO", 0, 2, 0);
	T = T->nxt	= settr(68,0,39,0,0,"DO", 0, 2, 0);
	    T->nxt	= settr(68,0,67,0,0,"DO", 0, 2, 0);
	trans[0][39]	= settr(38,0,65,76,0,"(cvars[0].signalled)", 1, 2, 0);
	T = trans[ 0][65] = settr(64,2,0,0,0,"ATOMIC", 1, 2, 0);
	T->nxt	= settr(64,2,40,0,0,"ATOMIC", 1, 2, 0);
	trans[0][40]	= settr(39,2,64,77,77,"cvars[0].signalled = 0", 1, 2, 0);
	T = trans[ 0][64] = settr(63,0,0,0,0,"sub-sequence", 1, 2, 0);
	T->nxt	= settr(63,0,41,0,0,"sub-sequence", 1, 2, 0);
	trans[0][41]	= settr(40,2,47,78,0,"printf('@@@ %d LOCKING : state is %e\\n',_pid,mtx.mstate)", 1, 2, 0);
	T = trans[ 0][47] = settr(46,0,0,0,0,"sub-sequence", 1, 2, 0);
	T->nxt	= settr(46,0,45,0,0,"sub-sequence", 1, 2, 0);
	T = trans[0][45] = settr(44,2,0,0,0,"IF", 1, 2, 0);
	    T->nxt	= settr(44,2,42,0,0,"IF", 1, 2, 0);
	trans[0][42]	= settr(41,2,60,79,79,"(((mtx.mstate==unlocked)&&(mtx.mid==255)))", 1, 2, 0); /* m: 43 -> 60,0 */
	reached0[43] = 1;
	trans[0][43]	= settr(0,0,0,0,0,"mtx.mstate = locked",0,0,0);
	trans[0][44]	= settr(0,0,0,0,0,"mtx.mid = _pid",0,0,0);
	trans[0][46]	= settr(45,2,60,1,0,".(goto)", 1, 2, 0);
	trans[0][61]	= settr(60,2,60,1,0,".(goto)", 1, 2, 0);
	T = trans[0][60] = settr(59,2,0,0,0,"DO", 1, 2, 0);
	T = T->nxt	= settr(59,2,48,0,0,"DO", 1, 2, 0);
	    T->nxt	= settr(59,2,53,0,0,"DO", 1, 2, 0);
	trans[0][48]	= settr(47,2,51,80,0,"(((mtx.mstate==unlocked)&&(mtx.mid==255)))", 1, 2, 0);
	T = trans[ 0][51] = settr(50,0,0,0,0,"sub-sequence", 1, 2, 0);
	T->nxt	= settr(50,0,49,0,0,"sub-sequence", 1, 2, 0);
	trans[0][49]	= settr(48,2,62,81,81,"mtx.mstate = locked", 1, 2, 0); /* m: 50 -> 0,62 */
	reached0[50] = 1;
	trans[0][50]	= settr(0,0,0,0,0,"mtx.mid = _pid",0,0,0);
	trans[0][52]	= settr(51,2,62,1,0,"goto :b4", 1, 2, 0);
	trans[0][53]	= settr(52,2,58,2,0,"else", 1, 2, 0);
	T = trans[0][58] = settr(57,2,0,0,0,"IF", 1, 2, 0);
	T = T->nxt	= settr(57,2,54,0,0,"IF", 1, 2, 0);
	    T->nxt	= settr(57,2,56,0,0,"IF", 1, 2, 0);
	trans[0][54]	= settr(53,2,62,82,0,"((mtx.mid==_pid))", 1, 2, 0);
	trans[0][55]	= settr(54,2,62,1,0,"goto :b4", 1, 2, 0);
	trans[0][59]	= settr(58,2,60,1,0,".(goto)", 1, 2, 0);
	trans[0][56]	= settr(55,2,57,2,0,"else", 1, 2, 0);
	trans[0][57]	= settr(56,2,60,1,0,"(1)", 1, 2, 0);
	trans[0][62]	= settr(61,2,63,1,0,"break", 1, 2, 0);
	trans[0][63]	= settr(62,0,72,83,0,"printf('@@@ %d LOCKED : state is %e\\n',_pid,mtx.mstate)", 1, 2, 0);
	trans[0][66]	= settr(65,0,72,1,0,"goto :b3", 0, 2, 0);
	trans[0][67]	= settr(66,0,68,2,0,"else", 0, 2, 0);
	trans[0][68]	= settr(67,0,69,1,0,"(1)", 0, 2, 0);
	trans[0][71]	= settr(70,0,72,1,0,"break", 0, 2, 0);
	trans[0][72]	= settr(71,0,74,84,0,"printf('@@@ %d DONE with cond[%d]=%d with mutex=%e\\n',_pid,0,cvars[0].signalled,mtx.mstate)", 1, 2, 0);
	trans[0][76]	= settr(75,0,77,1,0,"break", 0, 2, 0);
	trans[0][77]	= settr(76,0,97,85,0,"assert((mtx.mid==_pid))", 1, 2, 0);
	T = trans[ 0][97] = settr(96,0,0,0,0,"sub-sequence", 0, 2, 0);
	T->nxt	= settr(96,0,78,0,0,"sub-sequence", 0, 2, 0);
	trans[0][78]	= settr(77,0,79,86,0,"assert(!(bfull))", 1, 2, 0);
	trans[0][79]	= settr(78,0,80,87,87,"buffer[in] = (p+pno)", 1, 2, 0);
	trans[0][80]	= settr(79,0,81,88,0,"printf('@@@ %d INSERT buf[%d] := %d\\n',_pid,in,(p+pno))", 1, 2, 0);
	trans[0][81]	= settr(80,0,82,89,89,"bempty = 0", 1, 2, 0);
	trans[0][82]	= settr(81,0,83,90,90,"bfull = (in==out)", 1, 2, 0);
	trans[0][83]	= settr(82,0,96,91,91,"in = ((in+1)%4)", 1, 2, 0);
	T = trans[ 0][96] = settr(95,0,0,0,0,"sub-sequence", 0, 2, 0);
	T->nxt	= settr(95,0,95,0,0,"sub-sequence", 0, 2, 0);
	T = trans[ 0][95] = settr(94,2,0,0,0,"ATOMIC", 1, 2, 0);
	T->nxt	= settr(94,2,84,0,0,"ATOMIC", 1, 2, 0);
	trans[0][84]	= settr(83,2,92,92,92,"printf('@@@ %d BUFFER in:%d, out:%d, empty:%d, full:%d [|',_pid,in,out,bempty,bfull)", 1, 2, 0); /* m: 85 -> 0,92 */
	reached0[85] = 1;
	trans[0][85]	= settr(0,0,0,0,0,"six = 0",0,0,0);
	trans[0][93]	= settr(92,2,92,1,0,".(goto)", 1, 2, 0);
	T = trans[0][92] = settr(91,2,0,0,0,"DO", 1, 2, 0);
	T = T->nxt	= settr(91,2,86,0,0,"DO", 1, 2, 0);
	    T->nxt	= settr(91,2,89,0,0,"DO", 1, 2, 0);
	trans[0][86]	= settr(85,2,92,93,93,"((six<4))", 1, 2, 0); /* m: 87 -> 92,0 */
	reached0[87] = 1;
	trans[0][87]	= settr(0,0,0,0,0,"printf(' %d |',buffer[six])",0,0,0);
	trans[0][88]	= settr(0,0,0,0,0,"six = (six+1)",0,0,0);
	trans[0][89]	= settr(88,2,90,2,0,"else", 1, 2, 0);
	trans[0][90]	= settr(89,2,94,94,94,"printf(']\\n')", 1, 2, 0); /* m: 91 -> 0,94 */
	reached0[91] = 1;
	trans[0][91]	= settr(90,2,94,1,0,"goto :b5", 1, 2, 0);
	trans[0][94]	= settr(93,0,102,1,0,"break", 1, 2, 0);
	T = trans[ 0][102] = settr(101,0,0,0,0,"sub-sequence", 0, 2, 0);
	T->nxt	= settr(101,0,98,0,0,"sub-sequence", 0, 2, 0);
	trans[0][98]	= settr(97,0,100,95,0,"printf('@@@ %d SIGNAL cond[%d]=%d\\n',_pid,1,cvars[1].signalled)", 1, 2, 0);
	T = trans[ 0][100] = settr(99,2,0,0,0,"ATOMIC", 1, 2, 0);
	T->nxt	= settr(99,2,99,0,0,"ATOMIC", 1, 2, 0);
	trans[0][99]	= settr(98,0,101,96,96,"cvars[1].signalled = 1", 1, 2, 0);
	trans[0][101]	= settr(100,0,103,97,0,"printf('@@@ %d SIGNALLED cond[%d]=%d\\n',_pid,1,cvars[1].signalled)", 1, 2, 0);
	trans[0][103]	= settr(102,0,112,98,0,"assert((mtx.mid==_pid))", 1, 2, 0);
	T = trans[ 0][112] = settr(111,0,0,0,0,"sub-sequence", 0, 2, 0);
	T->nxt	= settr(111,0,104,0,0,"sub-sequence", 0, 2, 0);
	trans[0][104]	= settr(103,0,110,99,0,"printf('@@@ %d UNLOCKING : state is %e\\n',_pid,mtx.mstate)", 1, 2, 0);
	T = trans[ 0][110] = settr(109,2,0,0,0,"ATOMIC", 1, 2, 0);
	T->nxt	= settr(109,2,108,0,0,"ATOMIC", 1, 2, 0);
	T = trans[0][108] = settr(107,2,0,0,0,"IF", 1, 2, 0);
	    T->nxt	= settr(107,2,105,0,0,"IF", 1, 2, 0);
	trans[0][105]	= settr(104,4,111,100,100,"(((mtx.mstate==locked)&&(mtx.mid==_pid)))", 1, 2, 0); /* m: 106 -> 111,0 */
	reached0[106] = 1;
	trans[0][106]	= settr(0,0,0,0,0,"mtx.mstate = unlocked",0,0,0);
	trans[0][107]	= settr(0,0,0,0,0,"mtx.mid = 255",0,0,0);
	trans[0][109]	= settr(108,0,111,1,0,".(goto)", 1, 2, 0);
	trans[0][111]	= settr(110,0,114,101,0,"printf('@@@ %d UNLOCKED : state is %e\\n',_pid,mtx.mstate)", 1, 2, 0);
	trans[0][114]	= settr(113,0,115,102,102,"p = ((p+2)%8)", 0, 2, 0);
	trans[0][117]	= settr(116,0,118,1,0,"break", 0, 2, 0);
	trans[0][118]	= settr(117,0,0,103,103,"-end-", 0, 3500, 0);
	/* np_ demon: */
	trans[_NP_] = (Trans **) emalloc(3*sizeof(Trans *));
	T = trans[_NP_][0] = settr(9997,0,1,_T5,0,"(np_)", 1,2,0);
	    T->nxt	  = settr(9998,0,0,_T2,0,"(1)",   0,2,0);
	T = trans[_NP_][1] = settr(9999,0,1,_T5,0,"(np_)", 1,2,0);
}

Trans *
settr(	int t_id, int a, int b, int c, int d,
	char *t, int g, int tpe0, int tpe1)
{	Trans *tmp = (Trans *) emalloc(sizeof(Trans));

	tmp->atom  = a&(6|32);	/* only (2|8|32) have meaning */
	if (!g) tmp->atom |= 8;	/* no global references */
	tmp->st    = b;
	tmp->tpe[0] = tpe0;
	tmp->tpe[1] = tpe1;
	tmp->tp    = t;
	tmp->t_id  = t_id;
	tmp->forw  = c;
	tmp->back  = d;
	return tmp;
}

Trans *
cpytr(Trans *a)
{	Trans *tmp = (Trans *) emalloc(sizeof(Trans));

	int i;
	tmp->atom  = a->atom;
	tmp->st    = a->st;
#ifdef HAS_UNLESS
	tmp->e_trans = a->e_trans;
	for (i = 0; i < HAS_UNLESS; i++)
		tmp->escp[i] = a->escp[i];
#endif
	tmp->tpe[0] = a->tpe[0];
	tmp->tpe[1] = a->tpe[1];
	for (i = 0; i < 6; i++)
	{	tmp->qu[i] = a->qu[i];
		tmp->ty[i] = a->ty[i];
	}
	tmp->tp    = (char *) emalloc(strlen(a->tp)+1);
	strcpy(tmp->tp, a->tp);
	tmp->t_id  = a->t_id;
	tmp->forw  = a->forw;
	tmp->back  = a->back;
	return tmp;
}

#ifndef NOREDUCE
int
srinc_set(int n)
{	if (n <= 2) return LOCAL;
	if (n <= 2+  DELTA) return Q_FULL_F; /* 's' or nfull  */
	if (n <= 2+2*DELTA) return Q_EMPT_F; /* 'r' or nempty */
	if (n <= 2+3*DELTA) return Q_EMPT_T; /* empty */
	if (n <= 2+4*DELTA) return Q_FULL_T; /* full  */
	if (n ==   5*DELTA) return GLOBAL;
	if (n ==   6*DELTA) return TIMEOUT_F;
	if (n ==   7*DELTA) return ALPHA_F;
	Uerror("cannot happen srinc_class");
	return BAD;
}
int
srunc(int n, int m)
{	switch(m) {
	case Q_FULL_F: return n-2;
	case Q_EMPT_F: return n-2-DELTA;
	case Q_EMPT_T: return n-2-2*DELTA;
	case Q_FULL_T: return n-2-3*DELTA;
	case ALPHA_F:
	case TIMEOUT_F: return 257; /* non-zero, and > MAXQ */
	}
	Uerror("cannot happen srunc");
	return 0;
}
#endif
int cnt;
#ifdef HAS_UNLESS
int
isthere(Trans *a, int b)
{	Trans *t;
	for (t = a; t; t = t->nxt)
		if (t->t_id == b)
			return 1;
	return 0;
}
#endif
#ifndef NOREDUCE
int
mark_safety(Trans *t) /* for conditional safety */
{	int g = 0, i, j, k;

	if (!t) return 0;
	if (t->qu[0])
		return (t->qu[1])?2:1;	/* marked */

	for (i = 0; i < 2; i++)
	{	j = srinc_set(t->tpe[i]);
		if (j >= GLOBAL && j != ALPHA_F)
			return -1;
		if (j != LOCAL)
		{	k = srunc(t->tpe[i], j);
			if (g == 0
			||  t->qu[0] != k
			||  t->ty[0] != j)
			{	t->qu[g] = k;
				t->ty[g] = j;
				g++;
	}	}	}
	return g;
}
#endif
void
retrans(int n, int m, int is, short srcln[], uchar reach[], uchar lpstate[])
	/* process n, with m states, is=initial state */
{	Trans *T0, *T1, *T2, *T3;
	Trans *T4, *T5; /* t_reverse or has_unless */
	int i;
#if defined(HAS_UNLESS) || !defined(NOREDUCE)
	int k;
#endif
#ifndef NOREDUCE
	int g, h, j, aa;
#endif
#ifdef HAS_UNLESS
	int p;
#endif
	if (state_tables >= 4)
	{	printf("STEP 1 %s\n", 
			procname[n]);
		for (i = 1; i < m; i++)
		for (T0 = trans[n][i]; T0; T0 = T0->nxt)
			crack(n, i, T0, srcln);
		return;
	}
	do {
		for (i = 1, cnt = 0; i < m; i++)
		{	T2 = trans[n][i];
			T1 = T2?T2->nxt:(Trans *)0;
/* prescan: */		for (T0 = T1; T0; T0 = T0->nxt)
/* choice in choice */	{	if (T0->st && trans[n][T0->st]
				&&  trans[n][T0->st]->nxt)
					break;
			}
#if 0
		if (T0)
		printf("\tstate %d / %d: choice in choice\n",
		i, T0->st);
#endif
			if (T0)
			for (T0 = T1; T0; T0 = T0->nxt)
			{	T3 = trans[n][T0->st];
				if (!T3->nxt)
				{	T2->nxt = cpytr(T0);
					T2 = T2->nxt;
					imed(T2, T0->st, n, i);
					continue;
				}
				do {	T3 = T3->nxt;
					T2->nxt = cpytr(T3);
					T2 = T2->nxt;
					imed(T2, T0->st, n, i);
				} while (T3->nxt);
				cnt++;
			}
		}
	} while (cnt);
	if (state_tables >= 3)
	{	printf("STEP 2 %s\n", 
			procname[n]);
		for (i = 1; i < m; i++)
		for (T0 = trans[n][i]; T0; T0 = T0->nxt)
			crack(n, i, T0, srcln);
		return;
	}
	for (i = 1; i < m; i++)
	{	if (trans[n][i] && trans[n][i]->nxt) /* optimize */
		{	T1 = trans[n][i]->nxt;
#if 0
			printf("\t\tpull %d (%d) to %d\n",
			T1->st, T1->forw, i);
#endif
			srcln[i] = srcln[T1->st];	/* Oyvind Teig, 5.2.0 */

			if (!trans[n][T1->st]) continue;
			T0 = cpytr(trans[n][T1->st]);
			trans[n][i] = T0;
			reach[T1->st] = 1;
			imed(T0, T1->st, n, i);
			for (T1 = T1->nxt; T1; T1 = T1->nxt)
			{
#if 0
			printf("\t\tpull %d (%d) to %d\n",
				T1->st, T1->forw, i);
#endif
		/*		srcln[i] = srcln[T1->st];  gh: not useful */
				if (!trans[n][T1->st]) continue;
				T0->nxt = cpytr(trans[n][T1->st]);
				T0 = T0->nxt;
				reach[T1->st] = 1;
				imed(T0, T1->st, n, i);
	}	}	}
	if (state_tables >= 2)
	{	printf("STEP 3 %s\n", 
			procname[n]);
		for (i = 1; i < m; i++)
		for (T0 = trans[n][i]; T0; T0 = T0->nxt)
			crack(n, i, T0, srcln);
		return;
	}
#ifdef HAS_UNLESS
	for (i = 1; i < m; i++)
	{	if (!trans[n][i]) continue;
		/* check for each state i if an
		 * escape to some state p is defined
		 * if so, copy and mark p's transitions
		 * and prepend them to the transition-
		 * list of state i
		 */
	 if (!like_java) /* the default */
	 {	for (T0 = trans[n][i]; T0; T0 = T0->nxt)
		for (k = HAS_UNLESS-1; k >= 0; k--)
		{	if (p = T0->escp[k])
			for (T1 = trans[n][p]; T1; T1 = T1->nxt)
			{	if (isthere(trans[n][i], T1->t_id))
					continue;
				T2 = cpytr(T1);
				T2->e_trans = p;
				T2->nxt = trans[n][i];
				trans[n][i] = T2;
		}	}
	 } else /* outermost unless checked first */
	 {	T4 = T3 = (Trans *) 0;
		for (T0 = trans[n][i]; T0; T0 = T0->nxt)
		for (k = HAS_UNLESS-1; k >= 0; k--)
		{	if (p = T0->escp[k])
			for (T1 = trans[n][p]; T1; T1 = T1->nxt)
			{	if (isthere(trans[n][i], T1->t_id))
					continue;
				T2 = cpytr(T1);
				T2->nxt = (Trans *) 0;
				T2->e_trans = p;
				if (T3)	T3->nxt = T2;
				else	T4 = T2;
				T3 = T2;
		}	}
		if (T4)
		{	T3->nxt = trans[n][i];
			trans[n][i] = T4;
		}
	 }
	}
#endif
#ifndef NOREDUCE
	for (i = 1; i < m; i++)
	{	if (a_cycles)
		{ /* moves through these states are visible */
	#if PROG_LAB>0 && defined(HAS_NP)
			if (progstate[n][i])
				goto degrade;
			for (T1 = trans[n][i]; T1; T1 = T1->nxt)
				if (progstate[n][T1->st])
					goto degrade;
	#endif
			if (accpstate[n][i] || visstate[n][i])
				goto degrade;
			for (T1 = trans[n][i]; T1; T1 = T1->nxt)
				if (accpstate[n][T1->st])
					goto degrade;
		}
		T1 = trans[n][i];
		if (!T1) continue;
		g = mark_safety(T1);	/* V3.3.1 */
		if (g < 0) goto degrade; /* global */
		/* check if mixing of guards preserves reduction */
		if (T1->nxt)
		{	k = 0;
			for (T0 = T1; T0; T0 = T0->nxt)
			{	if (!(T0->atom&8))
					goto degrade;
				for (aa = 0; aa < 2; aa++)
				{	j = srinc_set(T0->tpe[aa]);
					if (j >= GLOBAL && j != ALPHA_F)
						goto degrade;
					if (T0->tpe[aa]
					&&  T0->tpe[aa]
					!=  T1->tpe[0])
						k = 1;
			}	}
			/* g = 0;	V3.3.1 */
			if (k)	/* non-uniform selection */
			for (T0 = T1; T0; T0 = T0->nxt)
			for (aa = 0; aa < 2; aa++)
			{	j = srinc_set(T0->tpe[aa]);
				if (j != LOCAL)
				{	k = srunc(T0->tpe[aa], j);
					for (h = 0; h < 6; h++)
						if (T1->qu[h] == k
						&&  T1->ty[h] == j)
							break;
					if (h >= 6)
					{	T1->qu[g%6] = k;
						T1->ty[g%6] = j;
						g++;
			}	}	}
			if (g > 6)
			{	T1->qu[0] = 0;	/* turn it off */
				printf("pan: warning, line %d, ",
					srcln[i]);
			 	printf("too many stmnt types (%d)",
					g);
			  	printf(" in selection\n");
			  goto degrade;
			}
		}
		/* mark all options global if >=1 is global */
		for (T1 = trans[n][i]; T1; T1 = T1->nxt)
			if (!(T1->atom&8)) break;
		if (T1)
degrade:	for (T1 = trans[n][i]; T1; T1 = T1->nxt)
			T1->atom &= ~8;	/* mark as unsafe */
		/* can only mix 'r's or 's's if on same chan */
		/* and not mixed with other local operations */
		T1 = trans[n][i];
		if (!T1 || T1->qu[0]) continue;
		j = T1->tpe[0];
		if (T1->nxt && T1->atom&8)
		{ if (j == 5*DELTA)
		  {	printf("warning: line %d ", srcln[i]);
			printf("mixed condition ");
			printf("(defeats reduction)\n");
			goto degrade;
		  }
		  for (T0 = T1; T0; T0 = T0->nxt)
		  for (aa = 0; aa < 2; aa++)
		  if  (T0->tpe[aa] && T0->tpe[aa] != j)
		  {	printf("warning: line %d ", srcln[i]);
			printf("[%d-%d] mixed %stion ",
				T0->tpe[aa], j, 
				(j==5*DELTA)?"condi":"selec");
			printf("(defeats reduction)\n");
			printf("	'%s' <-> '%s'\n",
				T1->tp, T0->tp);
			goto degrade;
		} }
	}
#endif
	for (i = 1; i < m; i++)
	{	T2 = trans[n][i];
		if (!T2
		||  T2->nxt
		||  strncmp(T2->tp, ".(goto)", 7)
		||  !stopstate[n][i])
			continue;
		stopstate[n][T2->st] = 1;
	}
	if (state_tables && !verbose)
	{	if (dodot)
		{	char buf[256], *q = buf, *p = procname[n];
			while (*p != '\0')
			{	if (*p != ':')
				{	*q++ = *p;
				}
				p++;
			}
			*q = '\0';
			printf("digraph ");
			switch (Btypes[n]) {
			case I_PROC:  printf("init {\n"); break;
			case N_CLAIM: printf("claim_%s {\n", buf); break;
			case E_TRACE: printf("notrace {\n"); break;
			case N_TRACE: printf("trace {\n"); break;
			default:      printf("p_%s {\n", buf); break;
			}
			printf("size=\"8,10\";\n");
			printf("  GT [shape=box,style=dotted,label=\"%s\"];\n", buf);
			printf("  GT -> S%d;\n", is);
		} else
		{	switch (Btypes[n]) {
			case I_PROC:  printf("init\n"); break;
			case N_CLAIM: printf("claim %s\n", procname[n]); break;
			case E_TRACE: printf("notrace assertion\n"); break;
			case N_TRACE: printf("trace assertion\n"); break;
			default:      printf("proctype %s\n", procname[n]); break;
		}	}
		for (i = 1; i < m; i++)
		{	reach[i] = 1;
		}
		tagtable(n, m, is, srcln, reach);
		if (dodot) printf("}\n");
	} else
	for (i = 1; i < m; i++)
	{	int nrelse;
		if (Btypes[n] != N_CLAIM)
		{	for (T0 = trans[n][i]; T0; T0 = T0->nxt)
			{	if (T0->st == i
				&& strcmp(T0->tp, "(1)") == 0)
				{	printf("error: proctype '%s' ",
						procname[n]);
		  			printf("line %d, state %d: has un",
						srcln[i], i);
					printf("conditional self-loop\n");
					pan_exit(1);
		}	}	}
		nrelse = 0;
		for (T0 = trans[n][i]; T0; T0 = T0->nxt)
		{	if (strcmp(T0->tp, "else") == 0)
				nrelse++;
		}
		if (nrelse > 1)
		{	printf("error: proctype '%s' state",
				procname[n]);
		  	printf(" %d, inherits %d", i, nrelse);
		  	printf(" 'else' stmnts\n");
			pan_exit(1);
	}	}
#if !defined(LOOPSTATE) && !defined(BFS_PAR)
	if (state_tables)
#endif
	do_dfs(n, m, is, srcln, reach, lpstate);

	if (!t_reverse)
	{	return;
	}
	/* process n, with m states, is=initial state -- reverse list */
	if (!state_tables && Btypes[n] != N_CLAIM)
	{	for (i = 1; i < m; i++)
		{	Trans *Tx = (Trans *) 0; /* list of escapes */
			Trans *Ty = (Trans *) 0; /* its tail element */
			T1 = (Trans *) 0; /* reversed list */
			T2 = (Trans *) 0; /* its tail */
			T3 = (Trans *) 0; /* remembers possible 'else' */

			/* find unless-escapes, they should go first */
			T4 = T5 = T0 = trans[n][i];
	#ifdef HAS_UNLESS
			while (T4 && T4->e_trans) /* escapes are first in orig list */
			{	T5 = T4;	  /* remember predecessor */
				T4 = T4->nxt;
			}
	#endif
			/* T4 points to first non-escape, T5 to its parent, T0 to original list */
			if (T4 != T0)		 /* there was at least one escape */
			{	T3 = T5->nxt;		 /* start of non-escapes */
				T5->nxt = (Trans *) 0;	 /* separate */
				Tx = T0;		 /* start of the escapes */
				Ty = T5;		 /* its tail */
				T0 = T3;		 /* the rest, to be reversed */
			}
			/* T0 points to first non-escape, Tx to the list of escapes, Ty to its tail */

			/* first tail-add non-escape transitions, reversed */
			T3 = (Trans *) 0;
			for (T5 = T0; T5; T5 = T4)
			{	T4 = T5->nxt;
	#ifdef HAS_UNLESS
				if (T5->e_trans)
				{	printf("error: cannot happen!\n");
					continue;
				}
	#endif
				if (strcmp(T5->tp, "else") == 0)
				{	T3 = T5;
					T5->nxt = (Trans *) 0;
				} else
				{	T5->nxt = T1;
					if (!T1) { T2 = T5; }
					T1 = T5;
			}	}
			/* T3 points to a possible else, which is removed from the list */
			/* T1 points to the reversed list so far (without escapes) */
			/* T2 points to the tail element -- where the else should go */
			if (T2 && T3)
			{	T2->nxt = T3;	/* add else */
			} else
			{	if (T3) /* there was an else, but there's no tail */
				{	if (!T1)	/* and no reversed list */
					{	T1 = T3; /* odd, but possible */
					} else		/* even stranger */
					{	T1->nxt = T3;
			}	}	}

			/* add in the escapes, to that they appear at the front */
			if (Tx && Ty) { Ty->nxt = T1; T1 = Tx; }

			trans[n][i] = T1;
			/* reversed, with escapes first and else last */
	}	}
	if (state_tables && verbose)
	{	printf("FINAL proctype %s\n", 
			procname[n]);
		for (i = 1; i < m; i++)
		for (T0 = trans[n][i]; T0; T0 = T0->nxt)
			crack(n, i, T0, srcln);
	}
}
void
imed(Trans *T, int v, int n, int j)	/* set intermediate state */
{	progstate[n][T->st] |= progstate[n][v];
	accpstate[n][T->st] |= accpstate[n][v];
	stopstate[n][T->st] |= stopstate[n][v];
	mapstate[n][j] = T->st;
}
void
tagtable(int n, int m, int is, short srcln[], uchar reach[])
{	Trans *z;

	if (is >= m || !trans[n][is]
	||  is <= 0 || reach[is] == 0)
		return;
	reach[is] = 0;
	if (state_tables)
	for (z = trans[n][is]; z; z = z->nxt)
	{	if (dodot)
			dot_crack(n, is, z);
		else
			crack(n, is, z, srcln);
	}

	for (z = trans[n][is]; z; z = z->nxt)
	{
#ifdef HAS_UNLESS
		int i, j;
#endif
		tagtable(n, m, z->st, srcln, reach);
#ifdef HAS_UNLESS
		for (i = 0; i < HAS_UNLESS; i++)
		{	j = trans[n][is]->escp[i];
			if (!j) break;
			tagtable(n, m, j, srcln, reach);
		}
#endif
	}
}

extern Trans *t_id_lkup[];

void
dfs_table(int n, int m, int is, short srcln[], uchar reach[], uchar lpstate[])
{	Trans *z;

	if (is >= m || is <= 0 || !trans[n][is])
		return;
	if ((reach[is] & (4|8|16)) != 0)
	{	if ((reach[is] & (8|16)) == 16)	/* on stack, not yet recorded */
		{	lpstate[is] = 1;
			reach[is] |= 8; /* recorded */
			if (state_tables && verbose)
			{	printf("state %d line %d is a loopstate\n", is, srcln[is]);
		}	}
		return;
	}
	reach[is] |= (4|16);	/* visited | onstack */
	for (z = trans[n][is]; z; z = z->nxt)
	{	t_id_lkup[z->t_id] = z;
#ifdef HAS_UNLESS
		int i, j;
#endif
		dfs_table(n, m, z->st, srcln, reach, lpstate);
#ifdef HAS_UNLESS
		for (i = 0; i < HAS_UNLESS; i++)
		{	j = trans[n][is]->escp[i];
			if (!j) break;
			dfs_table(n, m, j, srcln, reach, lpstate);
		}
#endif
	}
	reach[is] &= ~16; /* no longer on stack */
}
void
do_dfs(int n, int m, int is, short srcln[], uchar reach[], uchar lpstate[])
{	int i;
	dfs_table(n, m, is, srcln, reach, lpstate);
	for (i = 0; i < m; i++)
		reach[i] &= ~(4|8|16);
}
void
crack(int n, int j, Trans *z, short srcln[])
{	int i;

	if (!z) return;
	printf("	state %3d -(tr %3d)-> state %3d  ",
		j, z->forw, z->st);
	printf("[id %3d tp %3d", z->t_id, z->tpe[0]);
	if (z->tpe[1]) printf(",%d", z->tpe[1]);
#ifdef HAS_UNLESS
	if (z->e_trans)
		printf(" org %3d", z->e_trans);
	else if (state_tables >= 2)
	for (i = 0; i < HAS_UNLESS; i++)
	{	if (!z->escp[i]) break;
		printf(" esc %d", z->escp[i]);
	}
#endif
	printf("]");
	printf(" [%s%s%s%s%s] %s:%d => ",
		z->atom&6?"A":z->atom&32?"D":"-",
		accpstate[n][j]?"a" :"-",
		stopstate[n][j]?"e" : "-",
		progstate[n][j]?"p" : "-",
		z->atom & 8 ?"L":"G",
		PanSource, srcln[j]);
	for (i = 0; z->tp[i]; i++)
		if (z->tp[i] == '\n')
			printf("\\n");
		else
			putchar(z->tp[i]);
	if (verbose && z->qu[0])
	{	printf("\t[");
		for (i = 0; i < 6; i++)
			if (z->qu[i])
				printf("(%d,%d)",
				z->qu[i], z->ty[i]);
		printf("]");
	}
	printf("\n");
	fflush(stdout);
}
/* spin -a m.pml; cc -o pan pan.c; ./pan -D | dot -Tps > foo.ps; ps2pdf foo.ps */
void
dot_crack(int n, int j, Trans *z)
{	int i;

	if (!z) return;
	printf("	S%d -> S%d  [color=black", j, z->st);

	if (z->atom&6) printf(",style=dashed");
	else if (z->atom&32) printf(",style=dotted");
	else if (z->atom&8) printf(",style=solid");
	else printf(",style=bold");

	printf(",label=\"");
	for (i = 0; z->tp[i]; i++)
	{	if (z->tp[i] == '\\'
		&&  z->tp[i+1] == 'n')
		{	i++; printf(" ");
		} else
		{	putchar(z->tp[i]);
	}	}
	printf("\"];\n");
	if (accpstate[n][j]) printf("  S%d [color=red,style=bold];\n", j);
	else if (progstate[n][j]) printf("  S%d [color=green,style=bold];\n", j);
	if (stopstate[n][j]) printf("  S%d [color=blue,style=bold,shape=box];\n", j);
}

#ifdef VAR_RANGES
#define BYTESIZE	32	/* 2^8 : 2^3 = 256:8 = 32 */

typedef struct Vr_Ptr {
	char	*nm;
	uchar	vals[BYTESIZE];
	struct Vr_Ptr *nxt;
} Vr_Ptr;
Vr_Ptr *ranges = (Vr_Ptr *) 0;

void
logval(char *s, int v)
{	Vr_Ptr *tmp;

	if (v<0 || v > 255) return;
	for (tmp = ranges; tmp; tmp = tmp->nxt)
		if (!strcmp(tmp->nm, s))
			goto found;
	tmp = (Vr_Ptr *) emalloc(sizeof(Vr_Ptr));
	tmp->nxt = ranges;
	ranges = tmp;
	tmp->nm = s;
found:
	tmp->vals[(v)/8] |= 1<<((v)%8);
}

void
dumpval(uchar X[], int range)
{	int w, x, i, j = -1;

	for (w = i = 0; w < range; w++)
	for (x = 0; x < 8; x++, i++)
	{
from:		if ((X[w] & (1<<x)))
		{	printf("%d", i);
			j = i;
			goto upto;
	}	}
	return;
	for (w = 0; w < range; w++)
	for (x = 0; x < 8; x++, i++)
	{
upto:		if (!(X[w] & (1<<x)))
		{	if (i-1 == j)
				printf(", ");
			else
				printf("-%d, ", i-1);
			goto from;
	}	}
	if (j >= 0 && j != 255)
		printf("-255");
}

void
dumpranges(void)
{	Vr_Ptr *tmp;
	printf("\nValues assigned within ");
	printf("interval [0..255]:\n");
	for (tmp = ranges; tmp; tmp = tmp->nxt)
	{	printf("\t%s\t: ", tmp->nm);
		dumpval(tmp->vals, BYTESIZE);
		printf("\n");
	}
}
#endif
