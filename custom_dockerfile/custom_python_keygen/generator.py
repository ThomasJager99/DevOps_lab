import secrets
import base64


def generate_bytes(length: int) -> bytes:
    return secrets.token_bytes(length)


def to_hex(data: bytes) -> str:
    return data.hex()


def to_base64(data: bytes) -> str:
    return base64.b64encode(data).decode("utf-8")


def to_urlsafe(data: bytes) -> str:
    return base64.urlsafe_b64encode(data).decode("utf-8")


def save_to_file(data: str, path: str) -> None:
    with open(path, "w") as file:
        file.write(data)