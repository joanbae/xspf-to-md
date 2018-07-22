# xspf-to-md
Convert an .xspf file to markdown file.

## Requirements
* Ocaml 4.04.0
  * ocamlbuild 0.12.0

## How to build & Run

1. To build
```
 make 
```

2. To run

```
./main.native inputFileName outputFileName
```

For example, `./main.native hello.xspf hello.md`  
Remember, The markdown file will be saved as the given string in `outputFileName` field.  
The default output filename is "playlist.md"

Code Reference : Real World Ocaml
