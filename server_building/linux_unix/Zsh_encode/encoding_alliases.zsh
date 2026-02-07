win2utf() {
  iconv -f WINDOWS-1251 -t UTF-8 "$1" > "$1".utf8.txt
}


utf2win() {
    iconv -f UTF-8 -t WINDOWS-1251 "$1" > "$1".win1251.txt
}

