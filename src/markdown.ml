let count = ref 0

let getTitle =
  let t = Unix.localtime (Unix.time ()) in
  let day, month, year =
    (t.Unix.tm_mday, t.Unix.tm_mon, 1900 + t.Unix.tm_year - 2000)
  in
  Printf.sprintf "### Playlist created on %02d/%02d/%02d\n" (month + 1) day
    year


let getHeader =
  "| No.| title |  artist | album | jacket  |  &nbsp; &nbsp; &nbsp; duration |\n|:--:|:-----:|:-------:|:-----:|:-------:|:-------------------------------:|\n"


let make_row x =
  let open Tracks.Track in
  let image =
    Printf.sprintf "![](%s){#id .class width=50 height=50px}" x.image
  in
  Printf.sprintf "|%02d &nbsp;|%s|%s|%s|%s|&nbsp;&nbsp;&nbsp;%s|\n" !count
    x.title x.creator x.album image x.duration


let getBody s_xml =
  List.fold_right
    (fun x s ->
      count := !count + 1 ;
      s ^ make_row x)
    s_xml ""


let create_table s_xml =
  let header = getHeader in
  let body = getBody s_xml in
  header ^ body


let make s_xml =
  let title = getTitle in
  let table = create_table s_xml in
  title ^ "\n---\n" ^ table

