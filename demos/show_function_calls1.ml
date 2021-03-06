(*s: show_function_calls1.ml *)
(*s: basic pfff modules open *)
open Common
open Ast_php
(*e: basic pfff modules open *)

(*s: show_function_calls v1 *)
let show_function_calls file = 
  let (asts2, _stat) = Parse_php.parse file in
  let asts = Parse_php.program_of_program2 asts2 in

  (*s: iter on asts manually *)
    asts |> List.iter (fun toplevel ->

      match toplevel with
      | StmtList stmts ->
          (*s: iter on stmts *)
          stmts |> List.iter (fun stmt ->
            (match stmt with
            | ExprStmt (e, _ptvirg) ->
      
                (match Ast_php.untype e with
                | Lv var ->
          
                    (match Ast_php.untype var with
                    | FunCallSimple (funcname, args) ->
                        (*s: print funcname *)
                        let s = Ast_php.name funcname in
                        let info = Ast_php.info_of_name funcname in
                        let line = Ast_php.line_of_info info in
                        pr2 (spf "Call to %s at line %d" s line);
                        (*e: print funcname *)
                    | _ -> ()
                    )
                | _ -> ()
                )
            | _ -> ()
            )
          )
          (*e: iter on stmts *)

      | (FuncDef _|ClassDef _|InterfaceDef _|Halt _
          |NotParsedCorrectly _| FinalDef _)
        -> ()
    )
  (*e: iter on asts manually *)
(*e: show_function_calls v1 *)

let main = 
  show_function_calls Sys.argv.(1)
(*e: show_function_calls1.ml *)
