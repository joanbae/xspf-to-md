open Xml
module Tracks = Tracks.Tracks

let out_fileName = "playlist.md"

let track (t: xml) =
  let getTextElement pos xdata =
    pcdata (List.hd (children (List.nth xdata pos)))
  in
  let children = children t in
  let title = getTextElement 1 children in
  let creator = getTextElement 2 children in
  let album = getTextElement 3 children in
  let img = getTextElement 6 children in
  let duration = getTextElement 7 children in
  Tracks.track title creator album img duration


let makeTracks (tlst: xml list) : Tracks.t =
  List.fold_left (fun lst xml -> Tracks.add (track xml) lst) [] tlst


let getTitle =
  let t = Unix.localtime (Unix.time ()) in
  let day, month, year =
    (t.Unix.tm_mday, t.Unix.tm_mon, 1900 + t.Unix.tm_year - 2000)
  in
  Printf.sprintf "Playlist created on %02d/%02d/%02d\n" (month + 1) day year


let parse input =
  let xdata = parse_file input in
  let tracklst = children (List.nth (children xdata) 1) in
  makeTracks tracklst


let markdown xlst = Markdown.make xlst

let message = "Hello!"

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
  if Array.length Sys.argv <> 2 then (
    prerr_endline "No InputFile was given" ;
    exit 255 ) ;
  let inputFile = Sys.argv.(1) in
  let md = markdown (parse inputFile) in
  write md out_fileName


let () = main