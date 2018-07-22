open Xml
module Tracks = Tracks.Tracks

let count = ref 0

let track (t: xml) =
  let getTextElement pos xdata =
    pcdata (List.hd (children (List.nth xdata pos)))
  in
  count := !count + 1 ;
  let children = children t in
  let title = getTextElement 1 children in
  let creator = getTextElement 2 children in
  let album = getTextElement 3 children in
  let img = getTextElement 6 children in
  let milisec = int_of_string (getTextElement 7 children) in
  let min, sec =
    ( string_of_int (milisec / 60000)
    , String.sub (string_of_int (milisec mod 60000)) 0 2 )
  in
  Tracks.make_track
    (string_of_int !count)
    title creator album img
    (min ^ ":" ^ sec)


let makeTracks (tlst: xml list) : Tracks.t =
  List.fold_left (fun lst xml -> Tracks.add (track xml) lst) [] tlst


let getTitle =
  let t = Unix.localtime (Unix.time ()) in
  let day, month, year =
    (t.Unix.tm_mday, t.Unix.tm_mon, 1900 + t.Unix.tm_year - 2000)
  in
  Printf.sprintf "Playlist created on %02d/%02d/%02d\n" (month + 1) day year


let parse input : Tracks.t =
  let xdata = parse_file input in
  let tracklst = children (List.nth (children xdata) 1) in
  makeTracks tracklst


let markdown (xlst: Tracks.t) = Markdown.make (Tracks.tracks_rev xlst)

let write md toFile =
  (* Write message to file *)
  let oc = open_out toFile in
  (* create or truncate file, return channel *)
  Printf.fprintf oc "%s" md ;
  (* write something *)
  close_out oc ;
  (* flush and close the channel *)
  ()


let main =
  if Array.length Sys.argv < 2 then (
    prerr_endline "No InputFile was given" ;
    exit 255 ) ;
  let out_fileName = try Sys.argv.(2) with _ -> "playlist.md" in
  let inputFile = Sys.argv.(1) in
  let md = markdown (parse inputFile) in
  write md out_fileName


let () = main
