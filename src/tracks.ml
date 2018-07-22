module Track = struct
  type t =
    { count: string
    ; title: string
    ; creator: string
    ; album: string
    ; image: string
    ; duration: string }

  let make count title creator album image duration =
    let image = "![](" ^ image ^ "){#id .class width=50 height=50px}" in
    {count; title; creator; album; image; duration}


  let to_string s =
    "(count : " ^ s.count ^ ", title : " ^ s.title ^ ", creator:" ^ s.creator
    ^ ", album: " ^ s.album ^ ", image: " ^ s.image ^ ", duration: "
    ^ s.duration ^ ")"


  let to_lenList {count; title; creator; album; image; duration} =
    let len x = String.length x in
    [len count; len title; len creator; len album; len image; len duration]


  let to_strList {count; title; creator; album; image; duration} =
    [count; title; creator; album; image; duration]

end

module Tracks = struct
  module T = Track

  type t = T.t list

  let init : t list = []

  let add x lst = x :: lst

  let make_track count t c a i d = T.make count t c a i d

  let tracks_rev tracks = List.rev tracks

  let to_string x =
    let tracks = List.fold_left (fun s e -> s ^ T.to_string e ^ "\n") "" x in
    "{" ^ tracks ^ "}"

end
