import argparse
from generator import (
    generate_bytes,
    to_hex,
    to_base64,
    to_urlsafe,
    save_to_file,
)


def main() -> None:
    parser = argparse.ArgumentParser(description="Secure Key Generator")

    parser.add_argument("--length", type=int, required=True)
    parser.add_argument("--format", choices=["hex", "base64", "urlsafe"], required=True)
    parser.add_argument("--output", type=str)

    args = parser.parse_args()

    raw_bytes = generate_bytes(args.length)

    if args.format == "hex":
        result = to_hex(raw_bytes)
    elif args.format == "base64":
        result = to_base64(raw_bytes)
    else:
        result = to_urlsafe(raw_bytes)

    print(result)

    if args.output:
        save_to_file(result, args.output)


if __name__ == "__main__":
    main()
