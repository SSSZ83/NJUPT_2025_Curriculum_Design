/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/projects/B23020317/clk_gen_tb.v";
static int ng1[] = {0, 0};
static int ng2[] = {1, 0};
static const char *ng3 = "=== 3.73\267\326\306\265\262\342\312\324\277\252\312\274 ===";
static const char *ng4 = "\277\252\312\274\312\261\274\344: %t";
static int ng5[] = {100, 0, 0, 0};
static const char *ng6 = "\n=== \262\342\312\324\275\341\271\373 ===";
static const char *ng7 = "\327\334\312\344\310\353\312\261\326\323\326\334\306\332\312\375: %0d";
static const char *ng8 = "\312\344\263\366\312\261\326\323\326\334\306\332\312\375: %0d";
static const char *ng9 = "\312\265\262\342\267\326\306\265\261\310: %.3f";
static const char *ng10 = "\300\355\302\333\267\326\306\265\261\310: 3.730";
static const char *ng11 = "\316\363\262\356: %.3f%%";
static const char *ng12 = "\n\262\342\312\324\315\352\263\311!";
static int ng13[] = {50, 0};
static const char *ng14 = "\312\261\274\344: %t, \312\344\263\366\312\261\326\323\326\334\306\332: %0d, \265\261\307\260\326\334\306\332: %.3fns, \306\265\302\312: %.3fMHz";
static const char *ng15 = "tb_clk_gen.vcd";
static const char *ng16 = "\267\302\325\346\263\254\312\261!";



static void Initial_51_0(char *t0)
{
    char t4[8];
    char *t1;
    char *t2;
    char *t3;
    char *t5;
    char *t6;
    char *t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    char *t13;
    char *t14;
    char *t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    char *t24;

LAB0:    t1 = (t0 + 4080U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(51, ng0);

LAB4:    xsi_set_current_line(52, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 1880);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(53, ng0);

LAB5:    xsi_set_current_line(53, ng0);
    t2 = (t0 + 3888);
    xsi_process_wait(t2, 5000LL);
    *((char **)t1) = &&LAB6;

LAB1:    return;
LAB6:    xsi_set_current_line(53, ng0);
    t3 = (t0 + 1880);
    t5 = (t3 + 56U);
    t6 = *((char **)t5);
    memset(t4, 0, 8);
    t7 = (t6 + 4);
    t8 = *((unsigned int *)t7);
    t9 = (~(t8));
    t10 = *((unsigned int *)t6);
    t11 = (t10 & t9);
    t12 = (t11 & 1U);
    if (t12 != 0)
        goto LAB10;

LAB8:    if (*((unsigned int *)t7) == 0)
        goto LAB7;

LAB9:    t13 = (t4 + 4);
    *((unsigned int *)t4) = 1;
    *((unsigned int *)t13) = 1;

LAB10:    t14 = (t4 + 4);
    t15 = (t6 + 4);
    t16 = *((unsigned int *)t6);
    t17 = (~(t16));
    *((unsigned int *)t4) = t17;
    *((unsigned int *)t14) = 0;
    if (*((unsigned int *)t15) != 0)
        goto LAB12;

LAB11:    t22 = *((unsigned int *)t4);
    *((unsigned int *)t4) = (t22 & 1U);
    t23 = *((unsigned int *)t14);
    *((unsigned int *)t14) = (t23 & 1U);
    t24 = (t0 + 1880);
    xsi_vlogvar_assign_value(t24, t4, 0, 0, 1);
    goto LAB5;

LAB7:    *((unsigned int *)t4) = 1;
    goto LAB10;

LAB12:    t18 = *((unsigned int *)t4);
    t19 = *((unsigned int *)t15);
    *((unsigned int *)t4) = (t18 | t19);
    t20 = *((unsigned int *)t14);
    t21 = *((unsigned int *)t15);
    *((unsigned int *)t14) = (t20 | t21);
    goto LAB11;

LAB13:    goto LAB1;

}

static void Initial_64_1(char *t0)
{
    char t4[16];
    char t15[8];
    char *t1;
    char *t2;
    char *t3;
    char *t5;
    double t6;
    double t7;
    char *t8;
    char *t9;
    char *t10;
    double t11;
    double t12;
    char *t13;
    double t14;

LAB0:    t1 = (t0 + 4328U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(64, ng0);

LAB4:    xsi_set_current_line(66, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 1720);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(67, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 2520);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);
    xsi_set_current_line(68, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 2680);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);
    xsi_set_current_line(71, ng0);
    t2 = (t0 + 4136);
    xsi_process_wait(t2, 100000LL);
    *((char **)t1) = &&LAB5;

LAB1:    return;
LAB5:    xsi_set_current_line(72, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 1720);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(73, ng0);
    t2 = (t0 + 4136);
    xsi_process_wait(t2, 100000LL);
    *((char **)t1) = &&LAB6;
    goto LAB1;

LAB6:    xsi_set_current_line(75, ng0);
    xsi_vlogfile_write(1, 0, 0, ng3, 1, t0);
    xsi_set_current_line(76, ng0);
    t2 = xsi_vlog_time(t4, 1000.0000000000000, 1000.0000000000000);
    xsi_vlogfile_write(1, 0, 0, ng4, 2, t0, (char)118, t4, 64);
    xsi_set_current_line(79, ng0);
    t2 = (t0 + 4136);
    xsi_process_wait(t2, 100000000LL);
    *((char **)t1) = &&LAB7;
    goto LAB1;

LAB7:    xsi_set_current_line(82, ng0);
    t2 = (t0 + 2680);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    t6 = xsi_vlog_convert_to_real(t5, 32, 1);
    t7 = (1.0000000000000000 * t6);
    t8 = (t0 + 2520);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    t11 = xsi_vlog_convert_to_real(t10, 32, 1);
    t12 = (t7 / t11);
    t13 = (t0 + 2840);
    xsi_vlogvar_assign_value_double(t13, t12, 0);
    xsi_set_current_line(83, ng0);
    t2 = (t0 + 2840);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    t6 = *((double *)t5);
    t7 = (t6 - 3.7300000000000000);
    t11 = (t7 / 3.7300000000000000);
    t8 = ((char*)((ng5)));
    t12 = xsi_vlog_convert_to_real(t8, 32, 1);
    t14 = (t11 * t12);
    t9 = (t0 + 3000);
    xsi_vlogvar_assign_value_double(t9, t14, 0);
    xsi_set_current_line(85, ng0);
    xsi_vlogfile_write(1, 0, 0, ng6, 1, t0);
    xsi_set_current_line(86, ng0);
    t2 = (t0 + 2680);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    xsi_vlogfile_write(1, 0, 0, ng7, 2, t0, (char)119, t5, 32);
    xsi_set_current_line(87, ng0);
    t2 = (t0 + 2520);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    xsi_vlogfile_write(1, 0, 0, ng8, 2, t0, (char)119, t5, 32);
    xsi_set_current_line(88, ng0);
    t2 = (t0 + 2840);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    t6 = *((double *)t5);
    *((double *)t15) = t6;
    xsi_vlogfile_write(1, 0, 0, ng9, 2, t0, (char)114, t15, 64);
    xsi_set_current_line(89, ng0);
    xsi_vlogfile_write(1, 0, 0, ng10, 1, t0);
    xsi_set_current_line(90, ng0);
    t2 = (t0 + 3000);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    t6 = *((double *)t5);
    *((double *)t15) = t6;
    xsi_vlogfile_write(1, 0, 0, ng11, 2, t0, (char)114, t15, 64);
    xsi_set_current_line(92, ng0);
    xsi_vlogfile_write(1, 0, 0, ng12, 1, t0);
    xsi_set_current_line(93, ng0);
    xsi_vlog_finish(1);
    goto LAB1;

}

static void Always_97_2(char *t0)
{
    char t17[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t18;

LAB0:    t1 = (t0 + 4576U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(97, ng0);
    t2 = (t0 + 5888);
    *((int *)t2) = 1;
    t3 = (t0 + 4608);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(97, ng0);

LAB5:    xsi_set_current_line(98, ng0);
    t4 = (t0 + 1720);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 4);
    t8 = *((unsigned int *)t7);
    t9 = (~(t8));
    t10 = *((unsigned int *)t6);
    t11 = (t10 & t9);
    t12 = (t11 != 0);
    if (t12 > 0)
        goto LAB6;

LAB7:
LAB8:    goto LAB2;

LAB6:    xsi_set_current_line(98, ng0);

LAB9:    xsi_set_current_line(99, ng0);
    t13 = (t0 + 2680);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    t16 = ((char*)((ng2)));
    memset(t17, 0, 8);
    xsi_vlog_signed_add(t17, 32, t15, 32, t16, 32);
    t18 = (t0 + 2680);
    xsi_vlogvar_wait_assign_value(t18, t17, 0, 0, 32, 0LL);
    goto LAB8;

}

static void Always_106_3(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;

LAB0:    t1 = (t0 + 4824U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(106, ng0);
    t2 = (t0 + 5904);
    *((int *)t2) = 1;
    t3 = (t0 + 4856);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(106, ng0);

LAB5:    xsi_set_current_line(107, ng0);
    t4 = (t0 + 1320U);
    t5 = *((char **)t4);
    t4 = (t0 + 3160);
    xsi_vlogvar_wait_assign_value(t4, t5, 0, 0, 1, 0LL);
    goto LAB2;

}

static void Always_111_4(char *t0)
{
    char t7[8];
    char t19[8];
    char t30[8];
    char t38[8];
    char t70[8];
    char t84[8];
    char t91[8];
    char t133[8];
    char t137[16];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    char *t14;
    char *t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    char *t29;
    char *t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    unsigned int t36;
    char *t37;
    unsigned int t39;
    unsigned int t40;
    unsigned int t41;
    char *t42;
    char *t43;
    char *t44;
    unsigned int t45;
    unsigned int t46;
    unsigned int t47;
    unsigned int t48;
    unsigned int t49;
    unsigned int t50;
    unsigned int t51;
    char *t52;
    char *t53;
    unsigned int t54;
    unsigned int t55;
    unsigned int t56;
    unsigned int t57;
    unsigned int t58;
    unsigned int t59;
    unsigned int t60;
    unsigned int t61;
    int t62;
    int t63;
    unsigned int t64;
    unsigned int t65;
    unsigned int t66;
    unsigned int t67;
    unsigned int t68;
    unsigned int t69;
    char *t71;
    unsigned int t72;
    unsigned int t73;
    unsigned int t74;
    unsigned int t75;
    unsigned int t76;
    char *t77;
    char *t78;
    unsigned int t79;
    unsigned int t80;
    unsigned int t81;
    char *t82;
    char *t83;
    unsigned int t85;
    unsigned int t86;
    unsigned int t87;
    unsigned int t88;
    unsigned int t89;
    char *t90;
    unsigned int t92;
    unsigned int t93;
    unsigned int t94;
    char *t95;
    char *t96;
    char *t97;
    unsigned int t98;
    unsigned int t99;
    unsigned int t100;
    unsigned int t101;
    unsigned int t102;
    unsigned int t103;
    unsigned int t104;
    char *t105;
    char *t106;
    unsigned int t107;
    unsigned int t108;
    unsigned int t109;
    unsigned int t110;
    unsigned int t111;
    unsigned int t112;
    unsigned int t113;
    unsigned int t114;
    int t115;
    int t116;
    unsigned int t117;
    unsigned int t118;
    unsigned int t119;
    unsigned int t120;
    unsigned int t121;
    unsigned int t122;
    char *t123;
    unsigned int t124;
    unsigned int t125;
    unsigned int t126;
    unsigned int t127;
    unsigned int t128;
    char *t129;
    char *t130;
    char *t131;
    char *t132;
    char *t134;
    double t135;
    double t136;
    double t138;
    double t139;
    double t140;
    double t141;

LAB0:    t1 = (t0 + 5072U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(111, ng0);
    t2 = (t0 + 5920);
    *((int *)t2) = 1;
    t3 = (t0 + 5104);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(111, ng0);

LAB5:    xsi_set_current_line(112, ng0);
    t4 = (t0 + 1720);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memset(t7, 0, 8);
    t8 = (t6 + 4);
    t9 = *((unsigned int *)t8);
    t10 = (~(t9));
    t11 = *((unsigned int *)t6);
    t12 = (t11 & t10);
    t13 = (t12 & 1U);
    if (t13 != 0)
        goto LAB6;

LAB7:    if (*((unsigned int *)t8) != 0)
        goto LAB8;

LAB9:    t15 = (t7 + 4);
    t16 = *((unsigned int *)t7);
    t17 = *((unsigned int *)t15);
    t18 = (t16 || t17);
    if (t18 > 0)
        goto LAB10;

LAB11:    memcpy(t38, t7, 8);

LAB12:    memset(t70, 0, 8);
    t71 = (t38 + 4);
    t72 = *((unsigned int *)t71);
    t73 = (~(t72));
    t74 = *((unsigned int *)t38);
    t75 = (t74 & t73);
    t76 = (t75 & 1U);
    if (t76 != 0)
        goto LAB24;

LAB25:    if (*((unsigned int *)t71) != 0)
        goto LAB26;

LAB27:    t78 = (t70 + 4);
    t79 = *((unsigned int *)t70);
    t80 = *((unsigned int *)t78);
    t81 = (t79 || t80);
    if (t81 > 0)
        goto LAB28;

LAB29:    memcpy(t91, t70, 8);

LAB30:    t123 = (t91 + 4);
    t124 = *((unsigned int *)t123);
    t125 = (~(t124));
    t126 = *((unsigned int *)t91);
    t127 = (t126 & t125);
    t128 = (t127 != 0);
    if (t128 > 0)
        goto LAB38;

LAB39:
LAB40:    goto LAB2;

LAB6:    *((unsigned int *)t7) = 1;
    goto LAB9;

LAB8:    t14 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t14) = 1;
    goto LAB9;

LAB10:    t20 = (t0 + 3160);
    t21 = (t20 + 56U);
    t22 = *((char **)t21);
    memset(t19, 0, 8);
    t23 = (t22 + 4);
    t24 = *((unsigned int *)t23);
    t25 = (~(t24));
    t26 = *((unsigned int *)t22);
    t27 = (t26 & t25);
    t28 = (t27 & 1U);
    if (t28 != 0)
        goto LAB16;

LAB14:    if (*((unsigned int *)t23) == 0)
        goto LAB13;

LAB15:    t29 = (t19 + 4);
    *((unsigned int *)t19) = 1;
    *((unsigned int *)t29) = 1;

LAB16:    memset(t30, 0, 8);
    t31 = (t19 + 4);
    t32 = *((unsigned int *)t31);
    t33 = (~(t32));
    t34 = *((unsigned int *)t19);
    t35 = (t34 & t33);
    t36 = (t35 & 1U);
    if (t36 != 0)
        goto LAB17;

LAB18:    if (*((unsigned int *)t31) != 0)
        goto LAB19;

LAB20:    t39 = *((unsigned int *)t7);
    t40 = *((unsigned int *)t30);
    t41 = (t39 & t40);
    *((unsigned int *)t38) = t41;
    t42 = (t7 + 4);
    t43 = (t30 + 4);
    t44 = (t38 + 4);
    t45 = *((unsigned int *)t42);
    t46 = *((unsigned int *)t43);
    t47 = (t45 | t46);
    *((unsigned int *)t44) = t47;
    t48 = *((unsigned int *)t44);
    t49 = (t48 != 0);
    if (t49 == 1)
        goto LAB21;

LAB22:
LAB23:    goto LAB12;

LAB13:    *((unsigned int *)t19) = 1;
    goto LAB16;

LAB17:    *((unsigned int *)t30) = 1;
    goto LAB20;

LAB19:    t37 = (t30 + 4);
    *((unsigned int *)t30) = 1;
    *((unsigned int *)t37) = 1;
    goto LAB20;

LAB21:    t50 = *((unsigned int *)t38);
    t51 = *((unsigned int *)t44);
    *((unsigned int *)t38) = (t50 | t51);
    t52 = (t7 + 4);
    t53 = (t30 + 4);
    t54 = *((unsigned int *)t7);
    t55 = (~(t54));
    t56 = *((unsigned int *)t52);
    t57 = (~(t56));
    t58 = *((unsigned int *)t30);
    t59 = (~(t58));
    t60 = *((unsigned int *)t53);
    t61 = (~(t60));
    t62 = (t55 & t57);
    t63 = (t59 & t61);
    t64 = (~(t62));
    t65 = (~(t63));
    t66 = *((unsigned int *)t44);
    *((unsigned int *)t44) = (t66 & t64);
    t67 = *((unsigned int *)t44);
    *((unsigned int *)t44) = (t67 & t65);
    t68 = *((unsigned int *)t38);
    *((unsigned int *)t38) = (t68 & t64);
    t69 = *((unsigned int *)t38);
    *((unsigned int *)t38) = (t69 & t65);
    goto LAB23;

LAB24:    *((unsigned int *)t70) = 1;
    goto LAB27;

LAB26:    t77 = (t70 + 4);
    *((unsigned int *)t70) = 1;
    *((unsigned int *)t77) = 1;
    goto LAB27;

LAB28:    t82 = (t0 + 1320U);
    t83 = *((char **)t82);
    memset(t84, 0, 8);
    t82 = (t83 + 4);
    t85 = *((unsigned int *)t82);
    t86 = (~(t85));
    t87 = *((unsigned int *)t83);
    t88 = (t87 & t86);
    t89 = (t88 & 1U);
    if (t89 != 0)
        goto LAB31;

LAB32:    if (*((unsigned int *)t82) != 0)
        goto LAB33;

LAB34:    t92 = *((unsigned int *)t70);
    t93 = *((unsigned int *)t84);
    t94 = (t92 & t93);
    *((unsigned int *)t91) = t94;
    t95 = (t70 + 4);
    t96 = (t84 + 4);
    t97 = (t91 + 4);
    t98 = *((unsigned int *)t95);
    t99 = *((unsigned int *)t96);
    t100 = (t98 | t99);
    *((unsigned int *)t97) = t100;
    t101 = *((unsigned int *)t97);
    t102 = (t101 != 0);
    if (t102 == 1)
        goto LAB35;

LAB36:
LAB37:    goto LAB30;

LAB31:    *((unsigned int *)t84) = 1;
    goto LAB34;

LAB33:    t90 = (t84 + 4);
    *((unsigned int *)t84) = 1;
    *((unsigned int *)t90) = 1;
    goto LAB34;

LAB35:    t103 = *((unsigned int *)t91);
    t104 = *((unsigned int *)t97);
    *((unsigned int *)t91) = (t103 | t104);
    t105 = (t70 + 4);
    t106 = (t84 + 4);
    t107 = *((unsigned int *)t70);
    t108 = (~(t107));
    t109 = *((unsigned int *)t105);
    t110 = (~(t109));
    t111 = *((unsigned int *)t84);
    t112 = (~(t111));
    t113 = *((unsigned int *)t106);
    t114 = (~(t113));
    t115 = (t108 & t110);
    t116 = (t112 & t114);
    t117 = (~(t115));
    t118 = (~(t116));
    t119 = *((unsigned int *)t97);
    *((unsigned int *)t97) = (t119 & t117);
    t120 = *((unsigned int *)t97);
    *((unsigned int *)t97) = (t120 & t118);
    t121 = *((unsigned int *)t91);
    *((unsigned int *)t91) = (t121 & t117);
    t122 = *((unsigned int *)t91);
    *((unsigned int *)t91) = (t122 & t118);
    goto LAB37;

LAB38:    xsi_set_current_line(112, ng0);

LAB41:    xsi_set_current_line(113, ng0);
    t129 = (t0 + 2520);
    t130 = (t129 + 56U);
    t131 = *((char **)t130);
    t132 = ((char*)((ng2)));
    memset(t133, 0, 8);
    xsi_vlog_signed_add(t133, 32, t131, 32, t132, 32);
    t134 = (t0 + 2520);
    xsi_vlogvar_wait_assign_value(t134, t133, 0, 0, 32, 0LL);
    xsi_set_current_line(116, ng0);
    t2 = (t0 + 2200);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t135 = *((double *)t4);
    t5 = ((char*)((ng1)));
    t136 = xsi_vlog_convert_to_real(t5, 32, 1);
    t9 = (t135 > t136);
    *((unsigned int *)t7) = t9;
    t6 = (t7 + 4);
    *((unsigned int *)t6) = 0U;
    t8 = (t7 + 4);
    t10 = *((unsigned int *)t8);
    t11 = (~(t10));
    t12 = *((unsigned int *)t7);
    t13 = (t12 & t11);
    t16 = (t13 != 0);
    if (t16 > 0)
        goto LAB42;

LAB43:
LAB44:    xsi_set_current_line(120, ng0);
    t2 = xsi_vlog_time(t137, 1000.0000000000000, 1000.0000000000000);
    t135 = xsi_vlog_convert_to_real(t137, 64, 2);
    t3 = (t0 + 2200);
    xsi_vlogvar_assign_value_double(t3, t135, 0);
    xsi_set_current_line(123, ng0);
    t2 = (t0 + 2520);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng13)));
    memset(t7, 0, 8);
    xsi_vlog_signed_mod(t7, 32, t4, 32, t5, 32);
    t6 = ((char*)((ng1)));
    memset(t19, 0, 8);
    xsi_vlog_signed_equal(t19, 32, t7, 32, t6, 32);
    t8 = (t19 + 4);
    t9 = *((unsigned int *)t8);
    t10 = (~(t9));
    t11 = *((unsigned int *)t19);
    t12 = (t11 & t10);
    t13 = (t12 != 0);
    if (t13 > 0)
        goto LAB46;

LAB47:
LAB48:    goto LAB40;

LAB42:    xsi_set_current_line(116, ng0);

LAB45:    xsi_set_current_line(117, ng0);
    t14 = xsi_vlog_time(t137, 1000.0000000000000, 1000.0000000000000);
    t138 = xsi_vlog_convert_to_real(t137, 64, 2);
    t15 = (t0 + 2200);
    t20 = (t15 + 56U);
    t21 = *((char **)t20);
    t139 = *((double *)t21);
    t140 = (t138 - t139);
    t141 = (t140 / 1000.0000000000000);
    t22 = (t0 + 2040);
    xsi_vlogvar_assign_value_double(t22, t141, 0);
    xsi_set_current_line(118, ng0);
    t2 = (t0 + 2040);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t135 = *((double *)t4);
    t136 = (1000.0000000000000 / t135);
    t5 = (t0 + 2360);
    xsi_vlogvar_assign_value_double(t5, t136, 0);
    goto LAB44;

LAB46:    xsi_set_current_line(123, ng0);

LAB49:    xsi_set_current_line(124, ng0);
    t14 = xsi_vlog_time(t137, 1000.0000000000000, 1000.0000000000000);
    t15 = (t0 + 2520);
    t20 = (t15 + 56U);
    t21 = *((char **)t20);
    t22 = (t0 + 2040);
    t23 = (t22 + 56U);
    t29 = *((char **)t23);
    t135 = *((double *)t29);
    *((double *)t30) = t135;
    t31 = (t0 + 2360);
    t37 = (t31 + 56U);
    t42 = *((char **)t37);
    t136 = *((double *)t42);
    *((double *)t38) = t136;
    xsi_vlogfile_write(1, 0, 0, ng14, 5, t0, (char)118, t137, 64, (char)119, t21, 32, (char)114, t30, 64, (char)114, t38, 64);
    goto LAB48;

}

static void Initial_131_5(char *t0)
{
    char *t1;

LAB0:    xsi_set_current_line(131, ng0);

LAB2:    xsi_set_current_line(132, ng0);
    xsi_vcd_dumpfile(ng15);
    xsi_set_current_line(133, ng0);
    t1 = ((char*)((ng1)));
    xsi_vcd_dumpvars_args(*((unsigned int *)t1), t0, (char)109, t0, (char)101);

LAB1:    return;
}

static void Initial_137_6(char *t0)
{
    char *t1;
    char *t2;

LAB0:    t1 = (t0 + 5568U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(137, ng0);

LAB4:    xsi_set_current_line(138, ng0);
    t2 = (t0 + 5376);
    xsi_process_wait(t2, 110000000LL);
    *((char **)t1) = &&LAB5;

LAB1:    return;
LAB5:    xsi_set_current_line(139, ng0);
    xsi_vlogfile_write(1, 0, 0, ng16, 1, t0);
    xsi_set_current_line(140, ng0);
    xsi_vlog_finish(1);
    goto LAB1;

}


extern void work_m_00000000003690404289_1374630794_init()
{
	static char *pe[] = {(void *)Initial_51_0,(void *)Initial_64_1,(void *)Always_97_2,(void *)Always_106_3,(void *)Always_111_4,(void *)Initial_131_5,(void *)Initial_137_6};
	xsi_register_didat("work_m_00000000003690404289_1374630794", "isim/tb_clk_gen_isim_beh.exe.sim/work/m_00000000003690404289_1374630794.didat");
	xsi_register_executes(pe);
}
