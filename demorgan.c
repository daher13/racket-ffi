#include <memory.h>
#include <setjmp.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <z3.h>

void error_handler(Z3_context c, Z3_error_code e) {
  printf("Error code: %d\n", e);
}

Z3_solver mk_solver(Z3_context ctx) {
  Z3_solver s = Z3_mk_solver(ctx);
  Z3_solver_inc_ref(ctx, s);
  return s;
}

Z3_context mk_context_custom(Z3_config cfg, Z3_error_handler err) {
  Z3_context ctx;

  Z3_set_param_value(cfg, "model", "true");
  ctx = Z3_mk_context(cfg);
  Z3_set_error_handler(ctx, err);

  return ctx;
}

Z3_context mk_context() {
  Z3_config cfg;
  Z3_context ctx;
  cfg = Z3_mk_config();
  ctx = mk_context_custom(cfg, error_handler);
  Z3_del_config(cfg);
  return ctx;
}

void demorgan() {
  Z3_config cfg;
  Z3_context ctx;
  Z3_solver s;
  Z3_sort bool_sort;
  Z3_symbol symbol_x, symbol_y;
  Z3_ast x, y, not_x, not_y, x_and_y, ls, rs, conjecture, negated_conjecture;
  Z3_ast args[2];

  printf("\nDeMorgan\n");

  cfg = Z3_mk_config();
  Z3_set_param_value(cfg, "unsat_core", "true");
  ctx = Z3_mk_context(cfg);
  Z3_del_config(cfg);
  bool_sort = Z3_mk_bool_sort(ctx);
  symbol_x = Z3_mk_int_symbol(ctx, 0);
  symbol_y = Z3_mk_int_symbol(ctx, 1);
  x = Z3_mk_const(ctx, symbol_x, bool_sort);
  y = Z3_mk_const(ctx, symbol_y, bool_sort);

  /* De Morgan - with a negation around */
  /* !(!(x && y) <-> (!x || !y)) */
  not_x = Z3_mk_not(ctx, x);
  not_y = Z3_mk_not(ctx, y);
  args[0] = x;
  /* args[1] = y; */
  args[1] = Z3_mk_not(ctx, x);
  x_and_y = Z3_mk_and(ctx, 2, args);
  ls = Z3_mk_not(ctx, x_and_y);
  args[0] = not_x;
  args[1] = x;
  rs = Z3_mk_or(ctx, 2, args);
  conjecture = Z3_mk_iff(ctx, ls, rs);
  /* negated_conjecture = Z3_mk_not(ctx, conjecture); */
  negated_conjecture = Z3_mk_and(ctx, 2, args);

  Z3_ast p = Z3_mk_const(ctx, symbol_x, bool_sort);
  s = mk_solver(ctx);
  Z3_solver_assert_and_track(ctx, s, negated_conjecture, p);
  Z3_ast_vector unsat_core = Z3_solver_get_unsat_core(ctx, s);
  printf("%d", Z3_ast_vector_size(ctx, unsat_core));
  switch (Z3_solver_check(ctx, s)) {
  case Z3_L_TRUE:
    /* The negated conjecture was unsatisfiable, hence the conjecture is valid
     */
    printf("DeMorgan is valid\n");
    break;
  case Z3_L_UNDEF:
    /* Check returned undef */
    printf("Undef\n");
    break;
  case Z3_L_FALSE:
    /* The negated conjecture was satisfiable, hence the conjecture is not valid
     */
    printf("DeMorgan is not valid\n");
    break;
  }
  /* del_solver(ctx, s); */

  Z3_del_context(ctx);
}

void smt2parser_example() {
  Z3_context ctx;
  Z3_ast_vector fs;
  printf("\nsmt2parser_example\n");

  ctx = mk_context();
  fs = Z3_parse_smtlib2_string(ctx,
                               "(declare-fun a () (_ BitVec 8)) (assert (bvuge "
                               "a #x10)) (assert (bvule a #xf0))",
                               0, 0, 0, 0, 0, 0);
  Z3_ast_vector_inc_ref(ctx, fs);
  printf("formulas: %s\n", Z3_ast_vector_to_string(ctx, fs));
  Z3_ast_vector_dec_ref(ctx, fs);

  Z3_del_context(ctx);
}

int main() {
  demorgan();
  smt2parser_example();
}

// unsat_core_and_proof_example
