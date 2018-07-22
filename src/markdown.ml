open Tracks

let getTitle =
  let t = Unix.localtime (Unix.time ()) in
  let day, month, year =
    (t.Unix.tm_mday, t.Unix.tm_mon, 1900 + t.Unix.tm_year - 2000)
  in
  Printf.sprintf "### Playlist created on %02d/%02d/%02d\n" (month + 1) day
    year


let pad s length = " " ^ s ^ String.make (length - String.length s + 1) ' '

let render_row row widths =
  let padded = List.map2 (fun str size -> pad str size) row widths in
  "|" ^ String.concat "|" padded ^ "|"


let render_seperator widths =
  let pices =
    List.map (fun width -> ":" ^ String.make width '-' ^ ":") widths
  in
  "|" ^ String.concat "|" pices ^ "|"


let max_widths header (rows: Tracks.t) =
  let lengths l = List.map (fun x -> String.length x) l in
  let lengths_rows = List.map (fun row -> Track.to_lenList row) rows in
  List.fold_left
    (fun (acc: int list) (row: int list) ->
      List.map2 (fun col col' -> max col col') acc row)
    (lengths header) lengths_rows


let render_table header rows =
  let widths = max_widths header rows in
  String.concat "\n"
    ( render_row header widths
    :: render_seperator widths
    :: List.map (fun row -> render_row (Track.to_strList row) widths) rows )


let create_table s_xml =
  let header = ["No."; "title"; "artist"; "album"; "jacket"; "duration"] in
  render_table header s_xml


let make s_xml =
  let title = getTitle in
  let table = create_table s_xml in
  title ^ "\n---\n" ^ table ^ "\n___\n"

