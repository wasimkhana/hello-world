from typing import Optional


def get_hello_message(name: Optional[str] = None) -> str:
    if name:
        return f"Hello, {name}!"
    return "Hello, World!"


def main() -> int:
    message = get_hello_message()
    print(message)
    return 0


if __name__ == "__main__":
    main()
