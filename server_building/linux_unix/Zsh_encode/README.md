# ZSH Encoding Aliases

This is a tiny helper tool for encoding conversion inside your ZSH 
terminal. And after using a comand you receave 2 files - 1 original,
2nd encoded in UTF-8/Windows-1251This is a tiny helper tool for encoding conversion inside your ZSH terminal.  
After running a command, you get two files: the original and a new one encoded in UTF-8 or Windows-1251.

It contains two simple shell functions:

- `win2utf` — converts a file from Windows-1251 to UTF-8
- `utf2win` — converts a file from UTF-8 to Windows-1251

## Usage

Just run:

```bash
win2utf your_file.txt
