
type annotation =
  | ProvidesModule of Module_js.module_
  | Other of string

val extract_annotations: string -> annotation list

(* The returned parse_info is the one associated with the whole comment.
 * We use it in the tag generation.
 *)
val annotations_of_program_with_comments: 
  Ast_js.program2 -> (annotation * Parse_info.info) list