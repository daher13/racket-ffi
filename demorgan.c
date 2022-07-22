#include<stdio.h>
#include<stdlib.h>
#include<stdarg.h>
#include<memory.h>
#include<setjmp.h>
#include<z3.h>

Z3_solver mk_solver(Z3_context ctx)
{
  Z3_solver s = Z3_mk_solver(ctx);
  Z3_solver_inc_ref(ctx, s);
  return s;
}

void demorgan()
{
    Z3_config cfg;
    Z3_context ctx;
    Z3_solver s;
    Z3_sort bool_sort;
    Z3_symbol symbol_x, symbol_y;
    Z3_ast x, y, not_x, not_y, x_and_y, ls, rs, conjecture, negated_conjecture;
    Z3_ast args[2];

    printf("\nDeMorgan\n");

    cfg                = Z3_mk_config();
    ctx                = Z3_mk_context(cfg);
    Z3_del_config(cfg);
    bool_sort          = Z3_mk_bool_sort(ctx);
    symbol_x           = Z3_mk_int_symbol(ctx, 0);
    symbol_y           = Z3_mk_int_symbol(ctx, 1);
    x                  = Z3_mk_const(ctx, symbol_x, bool_sort);
    y                  = Z3_mk_const(ctx, symbol_y, bool_sort);

    /* De Morgan - with a negation around */
    /* !(!(x && y) <-> (!x || !y)) */
    not_x              = Z3_mk_not(ctx, x);
    not_y              = Z3_mk_not(ctx, y);
    args[0]            = x;
    args[1]            = y;
    x_and_y            = Z3_mk_and(ctx, 2, args);
    ls                 = Z3_mk_not(ctx, x_and_y);
    args[0]            = not_x;
    args[1]            = not_y;
    rs                 = Z3_mk_or(ctx, 2, args);
    conjecture         = Z3_mk_iff(ctx, ls, rs);
    negated_conjecture = Z3_mk_not(ctx, conjecture);

    s = mk_solver(ctx);
    Z3_solver_assert(ctx, s, negated_conjecture);
    switch (Z3_solver_check(ctx, s)) {
    case Z3_L_FALSE:
        /* The negated conjecture was unsatisfiable, hence the conjecture is valid */
        printf("DeMorgan is valid\n");
        break;
    case Z3_L_UNDEF:
        /* Check returned undef */
        printf("Undef\n");
        break;
    case Z3_L_TRUE:
        /* The negated conjecture was satisfiable, hence the conjecture is not valid */
        printf("DeMorgan is not valid\n");
        break;
    }
    /* del_solver(ctx, s); */
    Z3_del_context(ctx);
}

int main(){
  demorgan();
}
