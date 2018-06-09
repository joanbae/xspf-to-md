module Track = struct
  type t =
    { title: string
    ; creator: string
    ; album: string
    ; image: string
    ; duration: string }

  let make title creator album image duration =
    {title; creator; album; image; duration}


  let to_string s =
    "(title : " ^ s.title ^ ", creator:" ^ s.creator ^ ", album: " ^ s.album
    ^ ", image: " ^ s.image ^ ", duration: " ^ s.duration ^ ")"

end

module Tracks = struct
  type t = Track.t list

  let init : t list = []

  let add x lst = x :: lst

  let track t c a i d = Track.make t c a i d

  let to_string x =
    let tracks =
      List.fold_left (fun s e -> s ^ Track.to_string e ^ "\n") "" x
    in
    "{" ^ tracks ^ "}"

end
