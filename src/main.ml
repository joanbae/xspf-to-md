open Xml
module Tracks = Tracks.Tracks

let x = parse_file "temp.xspf"

let addTrack (t: xml) =
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


let addTracks (tlst: xml list) : Tracks.t =
  List.fold_left (fun lst xml -> Tracks.add (addTrack xml) lst) [] tlst


let parse x =
  let tracklst = children (List.nth (children x) 1) in
  let tracks = addTracks tracklst in
  print_endline (Tracks.to_string tracks)


let main = parse x

let () = main
